require_relative "lib/perigren_github_webhooks/version"

Gem::Specification.new do |spec|
  spec.name        = "perigren_github_webhooks"
  spec.version     = PerigrenGithubWebhooks::VERSION
  spec.authors     = ["Andrew Parrish"]
  spec.email       = ["andrew@perigren.com"]
  spec.homepage    = "https://github.com/andrewparrish/perigren_github_webhooks"
  spec.summary     = ""
  spec.description = ""
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://github.com/andrewparrish/perigren_github_webhooks"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/andrewparrish/perigren_github_webhooks"
  spec.metadata["changelog_uri"] = "https://github.com/andrewparrish/perigren_github_webhooks/releases"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0.0"
end
