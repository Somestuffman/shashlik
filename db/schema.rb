# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_323_184_139) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'
  enable_extension 'postgis'

  create_table 'administrators', id: :serial, force: :cascade do |t|
    t.string 'name', null: false
    t.string 'phone'
    t.string 'password_digest'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['phone'], name: 'index_administrators_on_phone'
  end

  create_table 'place_tags', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'place_tags_places', id: false, force: :cascade do |t|
    t.bigint 'place_id', null: false
    t.bigint 'place_tag_id', null: false
    t.bigint 'places_id'
    t.bigint 'place_tags_id'
    t.index ['place_tags_id'], name: 'index_place_tags_places_on_place_tags_id'
    t.index ['places_id'], name: 'index_place_tags_places_on_places_id'
  end

  create_table 'places', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'description'
    t.geography 'lonlat', limit: { srid: 4326, type: 'st_point', geographic: true }
    t.decimal 'average_rating', default: '0.0'
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_places_on_author_type_and_author_id'
  end

  create_table 'ratings', force: :cascade do |t|
    t.integer 'grade', null: false
    t.string 'author_type'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_type author_id], name: 'index_ratings_on_author_type_and_author_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'surname'
    t.string 'email'
    t.string 'phone'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email'
  end

  add_foreign_key 'place_tags_places', 'place_tags', column: 'place_tags_id'
  add_foreign_key 'place_tags_places', 'places', column: 'places_id'
end
