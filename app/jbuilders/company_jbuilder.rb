# frozen_string_literal: true

class CompanyJbuilder < BaseJbuilder
  def build_json(company)
    Jbuilder.new do |json|
      json.id company.id
      json.type 'company'
      json.attributes do
        json.call(company, :name, :phone, :cnpj, :created_at, :updated_at)
      end
    end.attributes!
  end
end
