# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  belongs_to :company
  has_many :points, dependent: :destroy
  acts_as_paranoid

  validates :name, :email, :cpf, presence: true
  validates :password, length: { minimum: 6, maximum: 20 }
  validates :cpf, uniqueness: { scope: :company_id, message: I18n.t('errors.messages.uniqueness') }
  validates :email, uniqueness: { scope: :company_id, message: I18n.t('errors.messages.uniqueness') }

  before_save :downcase_email
  after_create :send_welcome_mailer

  def downcase_email
    self.email = email.downcase
  end

  private

  def send_welcome_mailer
    # UserMailer.welcome_email(self).deliver_now
    # EmailWorker.set(wait: 1.minute).perform_async(id)
    EmailWorker.perform_async(id)
  end
end
