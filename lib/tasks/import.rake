# frozen_string_literal: true

namespace :import do
  desc 'import countries'
  task countries: :environment do
    p 'Destroying old countries'
    Country.destroy_all
    p 'Old countries destroyed'
    p 'Creating countries'
    Countries::COUNTRIES.each do |country|
      Country.create(name_ar: country[:name_ar], name_en: country[:name_en], dial_code: country[:dial_code],
                     short_code: country[:code])
    end
    p 'Countries created!'
  end

  desc 'Import All'
  task all: %i[environment countries]
end
