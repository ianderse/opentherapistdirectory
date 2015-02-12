require "codeclimate-test-reporter"
ENV["CODECLIMATE_REPO_TOKEN"]="373dbaf095f13eced905af1826d99bc25ed0a7f3e3cf472291638402b0dcf1b5"
CodeClimate::TestReporter.start
# require File.expand_path("../../spec/support", __FILE__)
require 'support/wait_for_ajax.rb'

RSpec.configure do |config|

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end



end
