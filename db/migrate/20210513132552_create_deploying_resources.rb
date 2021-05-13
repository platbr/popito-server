class CreateDeployingResources < ActiveRecord::Migration[6.1]
  def change
    create_table :deploying_resources do |t|
      t.references :owner, polymorphic: true, null: false
      t.references :deploying_model, null: false, foreign_key: {to_table: :file_resources}
      t.string :path, null: false
      t.string :chmod, null: false, default: '0640'
      t.json :params, null: false, default: {}

      t.timestamps
    end
  end
end
