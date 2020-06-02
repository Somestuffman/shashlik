# frozen_string_literal: true

module Api
  class PlaceSerializer
    include FastJsonapi::ObjectSerializer

    attributes :name,
               :description,
               :average_rating

    attribute :point do |object|
      RGeo::GeoJSON.encode(object.lonlat)
    end
  end
end
