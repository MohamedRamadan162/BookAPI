# frozen_string_literal: true

module Lookupable
  extend ActiveSupport::Concern
  def fetch_lookups_data(lookup_keys)
    lookups = []
    keys = params[:keys].present? ? params[:keys] : lookup_keys
    keys.split(',').flatten.each do |key|
      next unless lookup_keys.include?(key)

      model = key.singularize.classify
      lookups << { key.to_s => "Lookups::#{model}Serializer".constantize.new(model.constantize.all).to_j }
    end
    lookups
  end
end
