# frozen_string_literal: true

class PointJbuilder < BaseJbuilder
  def build_json(point)
    Jbuilder.new do |json|
      json.id point.id
      json.type 'points'
      json.attributes do
        json.call(point, :marking, :marking_type, :approved, :user_id, :created_at, :updated_at)
      end
      json.link do
        json.link_user "http://localhost:3000/users/#{point.user_id}"
      end
    end.attributes!
  end

  # def hash_includes(point)
  #   {
  #     UserJbuilder: point.user
  #   }
  # end
end
