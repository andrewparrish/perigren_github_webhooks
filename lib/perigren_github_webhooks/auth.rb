module PerigrenGithubWebhooks
  module Auth
    def check_authorization
      return true unless PerigrenGithubWebhooks.use_webhooks_secret_auth
      verify_signature
    end

    private

    def verify_signature
      signature = 'sha1=' + OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('sha1'),
                                                    ENV['PERIGREN_GITHUB_SECRET'], request.body.read)
      Rack::Utils.secure_compare(signature, request.env['HTTP_X_HUB_SIGNATURE'])
    end
  end
end
