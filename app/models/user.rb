# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  attr_accessor :exp, :token

  validates :name, :email, :cpf, :admin, presence: true
  validates :password, length: { minimum: 6, maximum: 20 }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
