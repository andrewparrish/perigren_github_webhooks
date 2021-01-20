module PerigrenGithubWebhooks
  module Handlers
    class InstallationEventService < GithubWebhookService
      CREATE_ACTIONS = %w[created added]
      DELETE_ACTIONS = %w[deleted removed]

      def perform
        super
        create_installation(@data['installation'])
        (@data['repositories'] || []).each do |repo_data|
          create_repository(repo_data)
          if CREATE_ACTIONS.include?(@data['action'])
            InstallationsRepository.find_or_create_by(assoc_hash(repo_data['id']))
          elsif DELETE_ACTIONS.include?(@data['action'])
            InstallationRepository.where(assoc_hash(repo_data['id'])).delete_all
          end
        end
        create_event
      end

      def create_event
        event = InstallationEvent.create(action: @data['action'], installation_id: @installation.id, sender_id: @sender.id, sender_type: @sender.class.to_s) 
        @installation.update(deleted_event_id: event.id) if event.action == 'deleted' && @installation.deleted_event_id.nil?

        handle_assoc(event)
        event
      end

      private

      def handle_assoc(event)
        if event.action == 'created' && @sender.is_a?(GithubUser)
          GithubUsersInstallations.find_or_create_by(github_user_id: @sender.id, installation_id: @installation.id)
        end

        if @sender.is_a?(Organization) || @data['installation']['account']['type'] == 'Organization' 
          org_id = if @data['sender']['type'] == 'Organization'
                     @sender.id
                   elsif @data['installation']['account']['type'] == 'Organization'
                     @data['installation']['account']['id']
                   end

          SynchronizeOrganizationWorker.perform_async(@installation.id, org_id)
        end
      end

      def assoc_hash(repo_id)
        { installation_id: @installation.id, repository_id: repo_id }
      end
    end
  end
end
