# frozen_string_literal: true

class InitDatabase < ActiveRecord::Migration[5.2]
  def change
    create_table :administrators, id: :integer do |t|
      t.string :name, null: false
      t.string :phone, index: true, unique: true
      t.string :password_digest

      t.timestamps
    end

    create_table :users do |t|
      t.string :name, null: false
      t.string :surname
      t.string :email, index: true, unique: true
      t.string :phone

      t.timestamps
    end

    create_table :places do |t|
      t.string :name, null: false
      t.string :description
      t.st_point :lonlat, geographic: true
      t.integer :average_rating, default: 0
      t.references :author, polymorphic: true

      t.timestamps
    end

    create_table :place_tags do |t|
      t.string :name, null: false

      t.timestamps
    end

    create_join_table :places, :place_tags do |t|
      t.references :places, index: true, foreign_key: true
      t.references :place_tags, index: true, foreign_key: true
    end

    create_table :ratings do |t|
      t.integer :grade, null: false
      t.references :author, polymorphic: true

      t.timestamps
    end
  end
end
