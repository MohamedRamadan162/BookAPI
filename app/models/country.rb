# frozen_string_literal: true

class Country < ApplicationRecord
  ############################ Enums ############################

  ######################### Localization ########################
  translates :name

  ######################### Validations #########################
  validates_presence_of :name_en
  validates_presence_of :name_ar

  ######################### Associations ########################
  has_many :users, dependent: :nullify

  ###################### Scopes #######################
  scope :filter_by_name, ->(name) { where('name_en ILIKE :name or name_ar ILIKE :name', name: "%#{name}%") }

  ############################ Hooks ############################

  ########################### Methods ###########################
end

# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  dial_code  :string           not null
#  name_ar    :string           not null
#  name_en    :string           not null
#  short_code :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
