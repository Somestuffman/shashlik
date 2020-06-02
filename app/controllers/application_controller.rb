# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types :error, :success

  helper_method :current_administrator

  def signed_in?
    session[:administartor_id].present?
  end

  def current_administrator
    @current_administrator ||= ::Administrator.find_by_id(session[:administartor_id])
  end
end
