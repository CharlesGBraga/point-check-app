# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def welcome_email(user:)
    @user = user
    mail(from: 'system@system.com.br', to: @user.email, subject: I18n.t(:welcome))
  end
end
