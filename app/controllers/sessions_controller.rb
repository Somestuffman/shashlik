# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'unauthorised'

  before_action :redirect_on_sign_in, only: %i[new create]

  def new; end

  def create
    if admin&.authenticate(session_params[:password])
      session[:administartor_id] = admin.id
      flash[:success] = 'Добро пожаловать'
      redirect_to admin_root_path
    else
      flash.now[:error] = 'Нэ-а, что-то не так'
      render :new
    end
  end

  def destroy
    session[:administartor_id] = nil
    flash[:success] = 'Доброй дороги!'
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:phone, :password)
  end

  def admin
    @admin ||= ::Administrator.find_by_phone(phone)
  end

  def redirect_on_sign_in
    redirect_to admin_root_path if current_administrator
  end

  def phone
    @phone ||= Phonelib.parse(session_params[:phone]).e164
  end
end
