# frozen_string_literal: true

module ApplicationHelper
  def flash_classes(key)
    case key.to_sym
    when :success
      'alert alert-success'
    when :error
      'alert alert-danger'
    when :alert
      'alert alert-warning'
    else
      'alert alert-info'
    end
  end

  def edit_button_label
    '<i class="fa fa-pencil-square-o"></i>'.html_safe
  end

  def delete_button_label
    '<i class="fa fa-trash-o"></i>'.html_safe
  end

  def logout_label
    'Выйти <i class="fa fa-sign-out"></i>'.html_safe
  end
end
