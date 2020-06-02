# frozen_string_literal: true

require 'reform/form/coercion'

module Admin
  class PlaceForm < Reform::Form
    feature Coercion

    model :place

    property :name, type: Types::Coercible::String
    property :description, type: Types::Coercible::String
    property :latitude,
             type: Types::Coercible::Float,
             nilify: true,
             virtual: true

    property :longitude,
             type: Types::Coercible::Float,
             nilify: true,
             virtual: true

    validates :name, :latitude, :longitude, presence: true

    def sync
      super.tap do
        model.lonlat = "POINT(#{longitude} #{latitude})"
      end
    end
  end
end
