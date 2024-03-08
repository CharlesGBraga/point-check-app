# frozen_string_literal: true

# http://127.0.0.1:5500/coverage/index.html#_AllFiles
require 'simplecov'
SimpleCov.start 'rails' do
  minimum_coverage line: 85
  add_filter '/app/channels/'
  add_filter '/app/models/paginate.rb'
end
