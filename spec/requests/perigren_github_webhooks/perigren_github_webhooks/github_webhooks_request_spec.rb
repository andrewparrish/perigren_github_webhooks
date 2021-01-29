require 'rails_helper'

RSpec.describe "PerigrenGithubWebhooks::GithubWebhooks", type: :request do
  describe "Auth helpers" do
    describe "auth check enabled" do 
      before do
        ENV['PERIGREN_GITHUB_SECRET'] = 'foo'
      end

      it "calls check_authorization" do
        expect_any_instance_of(PerigrenGithubWebhooks::Auth).to receive(:verify_signature)
        post "/perigren/github_webhooks#create",
          headers: { 'HTTP_X_HUB_SIGNATURE' => 'buzz', 'HTTP_X_GITHUB_EVENT' => 'ping', 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' },
          params: {}.to_json
      end
    end

    describe "auth check disabled" do

    end
  end
end
