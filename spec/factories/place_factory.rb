# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id             :bigint(8)        not null, primary key
#  author_type    :string
#  average_rating :decimal(, )      default(0.0)
#  description    :string
#  lonlat         :geography({:srid point, 4326
#  name           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  author_id      :bigint(8)
#
# Indexes
#
#  index_places_on_author_type_and_author_id  (author_type,author_id)
#

FactoryBot.define do
  factory :place do
    name { 'admin' }
    description { 'very cozy place' }
    average_rating { 5.0 }
    lonlat { 'POINT (37.595985 55.751019)' }
    author { create(:administartor) }
  end
end
