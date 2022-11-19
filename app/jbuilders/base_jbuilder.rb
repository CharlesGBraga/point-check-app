# frozen_string_literal: true

class BaseJbuilder
  attr_accessor :model, :options

  def initialize(model, options: {})
    @model = model
    @options = options
  end

  def call
    if model.respond_to?(:each) && !model.is_a?(Struct)
      build_multiple_json
    else
      build_single_json
    end
  end

  private

  def build_multiple_json
    return model.map { |item| build_json(item) } if options[:included]

    { data: model.map { |item| build_json(item) }, included: includes, meta: { pagination: pagination } }
  end

  def build_single_json
    return  build_json(model) if options[:included]

    { data: build_json(model), included: includes }
  end

  def build_json(item)
    Jbuilder.new do |json|
      json.id item.id
      json.type item.class.name.underscore.pluralize
    end
  end

  def includes
    return [] if ActiveModel::Type::Boolean.new.cast(options[:without_included])

    build_includes
  end

  def build_includes
    arr = if model.respond_to?(:each)
            model.map { |item| build_relationships(item) }
          else
            build_relationships(model)
          end
    return [] if arr.nil?

    result = arr.compact.flatten.uniq { |item| [item['id'], item['type']] }
    result.sort_by { |k| k['id'] }
  end

  def build_relationships(model)
    data = hash_includes(model)
    return if data.blank?

    data.filter_map do |klass, item|
      klass.to_s.constantize.new(item, options: { included: true }).call if item.present? || item.is_a?(Array)
    end
  end

  def hash_includes(item); end

  def pagination
    adapter = PaginationAdapter.new(model)
    Jbuilder.new do |json|
      json.call(adapter, :current, :previous, :next, :per_page, :pages, :total_count)
    end.attributes!
  end
end
