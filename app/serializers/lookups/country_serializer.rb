# frozen_string_literal: true

class Lookups::CountrySerializer < ApplicationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name_en, :name_ar
end
