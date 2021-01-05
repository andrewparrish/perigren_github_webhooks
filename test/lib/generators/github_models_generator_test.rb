require "test_helper"
require "generators/github_models/github_models_generator"

class GithubModelsGeneratorTest < Rails::Generators::TestCase
  tests GithubModelsGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
