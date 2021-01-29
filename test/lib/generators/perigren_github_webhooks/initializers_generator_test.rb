require "test_helper"
require "generators/initializers/initializers_generator"

module PerigrenGithubWebhooks
  class InitializersGeneratorTest < Rails::Generators::TestCase
    tests InitializersGenerator
    destination Rails.root.join('tmp/generators')
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
