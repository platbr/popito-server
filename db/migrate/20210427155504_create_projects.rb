# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false, unique: true
      t.string :label, null: false, unique: true
      t.text :description
      t.string :token, null: false, unique: true
      t.json :build_config, null: false, default: {}
      t.belongs_to :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
