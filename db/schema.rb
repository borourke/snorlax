# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160325223746) do

  create_table "jobs", force: :cascade do |t|
    t.string "alias"
    t.string "akon_id"
    t.text   "formatted_webhook_uri"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "akon_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rules", force: :cascade do |t|
    t.integer "starting_job_id"
    t.integer "ending_job_id"
    t.text    "field"
    t.text    "value"
    t.integer "transformation_id"
  end

  create_table "transformations", force: :cascade do |t|
    t.integer "starting_job_id"
    t.integer "ending_job_id"
    t.text    "code"
    t.string  "type"
  end

  create_table "unit_data", force: :cascade do |t|
    t.text    "field"
    t.text    "value"
    t.integer "unit_id"
  end

  create_table "units", force: :cascade do |t|
    t.integer "project_id"
  end

end
