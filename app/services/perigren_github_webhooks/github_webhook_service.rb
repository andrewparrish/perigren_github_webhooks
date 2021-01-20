module PerigrenGithubWebhooks
  class GithubWebhookService
    def initialize(data)
      @data = data
    end

    def perform
      @sender = create_user(@data['sender'])
    end

    def create_user(user_data)
      user_klass = user_data['type'].constantize
      # TODO: Configurable overwrite on user class
      user_klass = GithubUser if user_klass == User
      user = user_klass.find_or_initialize_by(id: user_data['id'])
      user.update(user_data.select do |k, _v|
        user_klass.column_names.include?(k) &&  k != 'type'
      end)
      user
    end

    def create_pull_request(pr_data)
      create_creator
      pr_data['repository_id'] = @repo.id
      @pr = PullRequest.find_or_initialize_by(id: pr_data['id'])
      @pr.update(clean_data(pr_data, PullRequest, ['head', 'base', '_links']).merge(pull_request_data.merge(last_touched_at: Time.now)))
      @pr
    end

    def create_creator
      @creator = create_user(@data['pull_request']['user'])
    end

    def create_commit(commit_data)
      author = create_user(commit_data['author'])
      committer = create_user(commit_data['committer'])
      @commit = Commit.find_or_initialize_by(sha: commit_data['sha'], node_id: commit_data['node_id'])
      @commit.update(
        author: author,
        committer: committer,
        commit: commit_data['commit'],
        url: commit_data['url'],
        parents: commit_data['parents'],
        message: commit_data['message'],
        distinct: commit_data['distinct']
      )
      @commit
    end

    def pull_request_data
      {
        requested_reviewers: @data['pull_request']['requested_reviewers'].map { |r| r['id'] },
        requested_teams: @data['pull_request']['requested_teams'].map { |r| r['id'] },
        creator: @creator
      }
    end

    def create_repository(repo_data)
      owner = create_user(repo_data['owner']) if repo_data['owner']
      @repo = Repository.find_or_initialize_by(id: repo_data['id'])
      @repo.update(clean_data(repo_data, Repository, ['owner', 'created_at', 'pushed_at']).merge(owner: owner || @sender))
      @repo
    end

    def organization_creation
      @organization = create_user(@data['organization'].merge('type' => 'Organization'))
    end

    def create_installation(installation_data)
      installation_data['deleted'] = true if @data['action'] == 'deleted'
      installation_data['installer_id'] = @sender.id
      account = create_user(installation_data['account'])
      @installation = Installation.find_or_create_by parse_installation_data(installation_data, account) do |installation|
        installation.id = installation_data['id']
        installation.permissions = installation_data['permissions']
        installation.save
        installation.installation_setting = InstallationSetting.create(installation_id: installation.id)
      end
    end

    def create_team(team_data)
      team_data['organization_id'] = @organization.id
      @team = Team.find_or_initialize_by(id: team_data['id'])
      @team.update(clean_data(team_data, Team))
      @team
    end

    protected

    def parse_installation_data(data, account) 
      {
        repository_selection: data['repository_selection'],
        events: data['events'],
        account: account,
        app_id: data['app_id'],
        target_id: data['target_id'],
        target_type: data['target_type'],
        single_file_name: data['single_file_name'],
        deleted: data['deleted'] || false,
        installer_id: data['installer_id']
      }
    end

    def clean_data(data, klass, ignore_keys = [])
      data.select do |k, v|
        klass.column_names.include?(k) && !ignore_keys.include?(k) && !v.to_s.blank?
      end
    end
  end
end
