# frozen_string_literal: true

class CreateTemplates < ActiveRecord::Migration[6.1]
  def change
    create_table :templates do |t|
      t.integer :kind, null: false, default: 0
      t.string :name, null: false, index: true
      t.text :description
      t.json :build_config, null: false, default: {}

      t.timestamps
    end
  end
end
