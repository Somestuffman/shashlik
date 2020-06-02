# frozen_string_literal: true

class ChangePlaceAverageRatingType < ActiveRecord::Migration[5.2]
  def change
    change_column :places, :average_rating, :decimal, default: 0.0
  end
end
