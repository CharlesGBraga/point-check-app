# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'

# require 'rspec/json_expectations'
require 'webmock/rspec'
WebMock.disable_net_connect!

require File.expand_path('../config/environment', __dir__)
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.define_derived_metadata do |meta|
    meta[:aggregate_failures] = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = 'spec/examples.txt'
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = nil
  config.order = :random
  Kernel.srand config.seed

  Shoulda::Matchers.configure do |conf|
    conf.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
