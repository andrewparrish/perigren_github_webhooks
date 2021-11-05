module PerigrenGithubWebhooks
  class InstallationRepositoryEventService < GithubWebhookService
    prepend CreateEventCheck

    def perform
      super
      create_installation(@data['installation'])
      create_repositories

      create_event
    end

    def create_event
      InstallationRepositoriesEvent.create(
        action: @data['action'],
        perigren_installation_id: @installation.id,
        sender: @sender,
        repository_selection: @data['repository_selection'],
        repositories_added: @data['repositories_added'].map { |r| r['id'] },
        repositories_removed: @data['repositories_removed'].map { |r| r['id'] }
      )
    end

    def create_repositories
      if(@data['repositories'])
        @data['repositories'].each { |repo| handle_repo(repo, @data['action']) }
      end

      if(@data['repositories_added'])
        @data['repositories_added'].each { |repo| handle_repo(repo, 'added') }
      end

      if(@data['repositories_removed'])
        @data['repositories_removed'].each { |repo| handle_repo(repo, 'removed') }
      end
    end

    private

    def handle_repo(repo, action)
      repo = create_repository(repo)
      if(action == 'added')
        InstallationsRepository.find_or_create_by(perigren_installation_id: @installation.id, perigren_repository_id: repo.id)
      elsif (action == 'removed')
        InstallationsRepository.where(perigren_installation_id: @installation.id, perigren_repository_id: repo.id).delete_all
      end
    end
  end
end
