# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    before_action :authorize_administrator

    def authorize_administrator
      return if current_administrator

      flash[:notice] = 'Необходима авторизация'
      redirect_to root_path
    end
  end
end
