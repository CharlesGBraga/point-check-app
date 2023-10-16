# frozen_string_literal: true

class Point < ApplicationRecord
  belongs_to :user
  acts_as_paranoid

  validates :marking, :marking_type, presence: true
end
