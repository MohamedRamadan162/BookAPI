# frozen_string_literal: true

class CreateCountry < ActiveRecord::Migration[7.0]
  def change
    create_table :countries do |t|
      t.string :name_en, null: false
      t.string :name_ar, null: false
      t.string :dial_code, null: false
      t.string :short_code, null: false

      t.timestamps
    end
  end
end
