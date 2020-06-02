# frozen_string_literal: true

module Admin
  class PlacesController < BaseController
    def index
      @places = Place.all
    end

    def new
      form
    end

    def create
      if form.validate(params[:place] || {}) && form.save
        flash[:success] = 'Место создано'
        redirect_to %i[admin places]
      else
        flash[:error] = 'Не удалось создать место'
        render :new
      end
    end

    def edit
      form
    end

    def update
      if form.validate(params[:place] || {}) && form.save
        flash[:success] = 'Место обновлёно'
        redirect_to %i[admin places]
      else
        flash[:error] = 'Не удалось обновить место'
        render :edit
      end
    end

    def destroy
      if place.destroy
        flash[:success] = 'Место удалёно'
      else
        flash[:error] = 'Не удалось удалить место'
      end

      redirect_to %i[admin places]
    end

    private

    def place
      @place ||= if params[:id]
                   ::Place.find(params[:id])
                 else
                   ::Place.new(author: current_administrator)
                 end
    end

    def form
      @form ||= PlaceForm.new(place)
    end
  end
end
