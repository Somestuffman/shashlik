# frozen_string_literal: true

module Admin
  class AdministratorsController < BaseController
    def index
      @administrators = ::Administrator.all
    end

    def new
      form
    end

    def create
      if form.validate(params[:administrator] || {}) && form.save
        flash[:success] = 'Администратор создан'
        redirect_to %i[admin administrators]
      else
        flash[:error] = 'Не удалось создать администратора'
        render :new
      end
    end

    def edit
      form
    end

    def update
      if form.validate(params[:administrator] || {}) && form.save
        flash[:success] = 'Администратор обновлён'
        redirect_to %i[admin administrators]
      else
        flash[:error] = 'Не удалось обновить администратора'
        render :edit
      end
    end

    def destroy
      if administrator.destroy
        flash[:success] = 'Администратор удалён'
      else
        flash[:error] = 'Не удалось удалить администратора'
      end

      redirect_to %i[admin administrators]
    end

    private

    def administrator
      @administrator ||= if params[:id]
                           ::Administrator.find(params[:id])
                         else
                           ::Administrator.new
                         end
    end

    def form
      @form ||= AdministratorForm.new(administrator)
    end
  end
end
