# frozen_string_literal: true

require 'reform/form/coercion'

module Admin
  class AdministratorForm < Reform::Form
    feature Coercion

    include Reform::Form::ActiveRecord

    model :administrator

    property :name, type: Types::Coercible::String

    property :phone,
             type: Types::Coercible::String,
             populator: :populate_phone

    property :password, type: Types::Coercible::String

    validates :name, :phone, :password, presence: true
    validates_uniqueness_of :phone
    validate :validate_phone

    private

    def populate_phone(fragment:, **)
      self.phone = Phonelib.parse(fragment).e164
    end

    def validate_phone
      return if Phonelib.valid?(phone)

      errors.add(:phone, 'имеет неверное значение')
    end
  end
end
