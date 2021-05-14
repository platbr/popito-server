# frozen_string_literal: true

class CreateFileResources < ActiveRecord::Migration[6.1]
  def change
    create_table :file_resources do |t|
      t.string :type, index: true, null: false
      t.belongs_to :owner, null: true, polymorphic: true, index: true
      t.integer :owner_priority, null: false
      t.string :label, index: true
      t.integer :render_engine, null: false, default: 0
      t.string :path, index: true
      t.string :chmod, null: false, default: '0640'
      t.string :comments, default: "#", null: false
      t.string :newline, default: "\n", null: false
      t.json :required_params, default: [], null: false
      t.json :optional_params, default: [], null: false
      t.text :data

      t.timestamps
    end

    add_index :file_resources, [:owner_type, :owner_id, :path], unique: true
    add_index :file_resources, [:owner_type, :owner_id, :label], unique: true
  end
end
