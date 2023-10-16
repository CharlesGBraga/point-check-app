# frozen_string_literal: true

class PaginationAdapter
  attr_reader :model

  def initialize(model)
    @model = model
  end

  delegate :total_count, to: :model

  def current
    model.current_page
  end

  def pages
    model.total_pages
  end

  def per_page
    model.try(:limit_value)
  end

  def previous
    current > 1 ? (current - 1) : nil
  end

  def next
    current < pages ? (current + 1) : nil
  end
end
