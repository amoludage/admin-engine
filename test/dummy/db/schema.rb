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

ActiveRecord::Schema.define(version: 20151028133029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.string   "access_token"
    t.string   "refresh_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "expires_in"
    t.string   "secret_token"
    t.boolean  "can_publish"
  end

  create_table "elements", force: true do |t|
    t.string   "data_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "dimensions"
    t.string   "data_sample"
    t.integer  "layout_id"
    t.integer  "position"
  end

  create_table "follows", force: true do |t|
    t.integer  "followable_id",                   null: false
    t.string   "followable_type",                 null: false
    t.integer  "follower_id",                     null: false
    t.string   "follower_type",                   null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "follows", ["followable_id", "followable_type"], name: "fk_followables", using: :btree
  add_index "follows", ["follower_id", "follower_type"], name: "fk_follows", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "front_end_builds_apps", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "require_manual_activation", default: false
    t.integer  "live_build_id"
    t.string   "client"
  end

  add_index "front_end_builds_apps", ["name"], name: "index_front_end_builds_apps_on_name", using: :btree

  create_table "front_end_builds_builds", force: true do |t|
    t.integer  "app_id"
    t.string   "sha"
    t.string   "job"
    t.string   "branch"
    t.text     "html"
    t.boolean  "fetched",                 default: false
    t.boolean  "active",                  default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "endpoint",   limit: 2038
    t.integer  "pubkey_id"
    t.text     "signature"
  end

  add_index "front_end_builds_builds", ["active"], name: "index_front_end_builds_builds_on_active", using: :btree
  add_index "front_end_builds_builds", ["app_id", "branch"], name: "index_front_end_builds_builds_on_app_id_and_branch", using: :btree
  add_index "front_end_builds_builds", ["app_id", "job"], name: "index_front_end_builds_builds_on_app_id_and_job", using: :btree
  add_index "front_end_builds_builds", ["app_id", "sha"], name: "index_front_end_builds_builds_on_app_id_and_sha", using: :btree
  add_index "front_end_builds_builds", ["created_at"], name: "index_front_end_builds_builds_on_created_at", using: :btree
  add_index "front_end_builds_builds", ["fetched"], name: "index_front_end_builds_builds_on_fetched", using: :btree

  create_table "front_end_builds_pubkeys", force: true do |t|
    t.string   "name",       null: false
    t.text     "pubkey",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: true do |t|
    t.string   "source"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_type"
    t.string   "public_id"
  end

  create_table "images_posts", id: false, force: true do |t|
    t.integer "image_id"
    t.integer "post_id"
  end

  add_index "images_posts", ["image_id"], name: "index_images_posts_on_image_id", using: :btree
  add_index "images_posts", ["post_id"], name: "index_images_posts_on_post_id", using: :btree

  create_table "layouts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "global"
    t.integer  "post_id"
    t.integer  "position"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "state"
    t.string   "slug"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "body"
    t.string   "title"
    t.text     "short_desc"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "font_style"
    t.datetime "published_at"
    t.string   "slug"
    t.string   "unique_token"
    t.string   "cover_photo_url"
  end

  add_index "posts", ["slug"], name: "index_posts_on_slug", unique: true, using: :btree

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "user_tags", force: true do |t|
    t.string   "tag_image"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "header_type", default: "plain"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               default: "",      null: false
    t.boolean  "anonymous",              default: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.text     "short_bio"
    t.string   "token"
    t.string   "header_type",            default: "plain"
    t.text     "sharing_preference"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "slug"
    t.string   "headline"
    t.string   "status"
    t.boolean  "enable_comments",        default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
