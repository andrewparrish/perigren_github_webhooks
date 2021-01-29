module PerigrenGithubWebhooks
  module Auth
    def check_authorization
      # TODO: This should be configurable if you want to include auth
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
