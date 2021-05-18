# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_14_131239) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "deploying_resources", force: :cascade do |t|
    t.string "owner_type", null: false
    t.integer "owner_id", null: false
    t.integer "deploying_model_id", null: false
    t.string "path", null: false
    t.string "chmod", default: "0640", null: false
    t.json "params", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deploying_model_id"], name: "index_deploying_resources_on_deploying_model_id"
    t.index ["owner_type", "owner_id"], name: "index_deploying_resources_on_owner"
  end

  create_table "environments", force: :cascade do |t|
    t.string "label", null: false
    t.json "build_config", default: {}, null: false
    t.integer "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_environments_on_project_id"
  end

  create_table "file_patches", force: :cascade do |t|
    t.string "owner_type", null: false
    t.integer "owner_id", null: false
    t.string "name", null: false
    t.integer "owner_priority", null: false
    t.integer "order", default: 0, null: false
    t.string "path", null: false
    t.integer "kind", default: 0, null: false
    t.boolean "optional", default: false, null: false
    t.boolean "newline_on_append", default: true, null: false
    t.integer "newline", default: 0, null: false
    t.string "search_regex"
    t.string "replace"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_file_patches_on_name"
    t.index ["owner_type", "owner_id"], name: "index_file_patches_on_owner"
    t.index ["path"], name: "index_file_patches_on_path"
  end

  create_table "file_resources", force: :cascade do |t|
    t.string "type", null: false
    t.string "owner_type"
    t.integer "owner_id"
    t.integer "owner_priority", null: false
    t.string "label"
    t.integer "render_engine", default: 0, null: false
    t.string "path"
    t.string "chmod", default: "0640", null: false
    t.string "comments_prefix", default: "#", null: false
    t.integer "newline", default: 0, null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["label"], name: "index_file_resources_on_label"
    t.index ["owner_type", "owner_id", "label"], name: "index_file_resources_on_owner_type_and_owner_id_and_label", unique: true
    t.index ["owner_type", "owner_id", "path"], name: "index_file_resources_on_owner_type_and_owner_id_and_path", unique: true
    t.index ["owner_type", "owner_id"], name: "index_file_resources_on_owner"
    t.index ["path"], name: "index_file_resources_on_path"
    t.index ["type"], name: "index_file_resources_on_type"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.string "label", null: false
    t.text "description"
    t.string "token", null: false
    t.json "build_config", default: {}, null: false
    t.integer "template_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["template_id"], name: "index_projects_on_template_id"
  end

  create_table "templates", force: :cascade do |t|
    t.integer "kind", default: 0, null: false
    t.string "name", null: false
    t.text "description"
    t.json "build_config", default: {}, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_templates_on_name"
  end

  add_foreign_key "deploying_resources", "file_resources", column: "deploying_model_id"
  add_foreign_key "environments", "projects"
  add_foreign_key "projects", "templates"
end
