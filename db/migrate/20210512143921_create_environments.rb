class CreateEnvironments < ActiveRecord::Migration[6.1]
  def change
    create_table :environments do |t|
      t.string :label, null: false
      t.json :build_config, null: false, default: {}
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
