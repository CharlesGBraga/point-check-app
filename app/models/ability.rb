# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.blank?

    cannot :read, :all
    return unless user.admin?

    can :manage, :all
  end
end
# https://github.com/CanCanCommunity/cancancan
