# frozen_string_literal: true

class EmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)
    # UserMailer.with(user: user).welcome_email.deliver_now
    UserMailer.welcome_email(user: user).deliver_now
  end
end
