# frozen_string_literal: true

class CreateFilePatches < ActiveRecord::Migration[6.1]
  def change
    create_table :file_patches do |t|
      t.belongs_to :owner, null: false, polymorphic: true, index: true
      t.integer :owner_priority, null: false
      t.integer :order, null: false, default: 0
      t.string :path, null: false, index: true
      t.integer :kind, null: false, default: 0
      t.boolean :optional, null: false, default: false
      t.boolean :newline_on_append, null: false, default: true
      t.string :newline, null: false, default: "\n"
      t.string :search
      t.string :replace

      t.timestamps
    end
  end
end
