# frozen_string_literal: true

module Api
  class PlacesController < ActionController::API
    def index
      render json: ::Api::PlaceSerializer.new(Place.all),
             status: :ok
    end
  end
end
