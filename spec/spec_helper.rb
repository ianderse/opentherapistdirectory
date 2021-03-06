require "codeclimate-test-reporter"
ENV["CODECLIMATE_REPO_TOKEN"]="373dbaf095f13eced905af1826d99bc25ed0a7f3e3cf472291638402b0dcf1b5"
CodeClimate::TestReporter.start
require 'support/wait_for_ajax.rb'
require 'aws'
require "paperclip/matchers"

RSpec.configure do |config|
  AWS.stub!

  config.include Paperclip::Shoulda::Matchers

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end
