# frozen_string_literal: true

class UserJbuilder < BaseJbuilder
  def build_json(user)
    Jbuilder.new do |json|
      json.id user.id
      json.type 'users'
      json.attributes do
        json.call(user, :name, :email, :cpf, :admin, :created_at, :updated_at)
      end
    end.attributes!
  end
end
