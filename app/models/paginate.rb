# frozen_string_literal: true

class Paginate
  include ActiveModel::API
  attr_accessor :id, :name, :email, :cpf, :admin, :current, :previous, :next, :per_page, :pages, :total_count
end
