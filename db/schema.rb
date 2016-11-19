# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161118142306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "organization_name"
    t.string   "organization_site"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "developer_projects", force: :cascade do |t|
    t.integer  "percentage_complete", default: 0
    t.string   "est_completion_date"
    t.integer  "project_id"
    t.integer  "developer_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.index ["developer_id"], name: "index_developer_projects_on_developer_id", using: :btree
    t.index ["project_id"], name: "index_developer_projects_on_project_id", using: :btree
  end

  create_table "developers", force: :cascade do |t|
    t.integer  "karma_points", default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "karma_comments", force: :cascade do |t|
    t.string   "karma_comment",                 null: false
    t.integer  "comment_like",      default: 0
    t.integer  "karma_question_id"
    t.integer  "developer_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["developer_id"], name: "index_karma_comments_on_developer_id", using: :btree
    t.index ["karma_question_id"], name: "index_karma_comments_on_karma_question_id", using: :btree
  end

  create_table "karma_questions", force: :cascade do |t|
    t.string   "karma_question",             null: false
    t.integer  "question_like",  default: 0
    t.integer  "developer_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["developer_id"], name: "index_karma_questions_on_developer_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title",                             null: false
    t.string   "brief_description",                 null: false
    t.string   "description",                       null: false
    t.string   "github_repo_url",                   null: false
    t.string   "active_site_url",                   null: false
    t.string   "fix_type"
    t.boolean  "fulfilled",         default: false
    t.integer  "client_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["client_id"], name: "index_projects_on_client_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.integer  "account_id"
    t.string   "account_type"
    t.string   "code_karma_token"
    t.string   "github_token"
    t.json     "github_oauth_data"
    t.string   "email"
    t.string   "nickname"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["account_type"], name: "index_users_on_account_type", using: :btree
    t.index ["code_karma_token"], name: "index_users_on_code_karma_token", using: :btree
  end

  add_foreign_key "developer_projects", "developers"
  add_foreign_key "developer_projects", "projects"
  add_foreign_key "karma_comments", "developers"
  add_foreign_key "karma_comments", "karma_questions"
  add_foreign_key "karma_questions", "developers"
  add_foreign_key "projects", "clients"
end
