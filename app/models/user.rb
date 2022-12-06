# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  belongs_to :company

  validates :name, :email, :cpf, presence: true
  validates :password, length: { minimum: 6, maximum: 20 }

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
