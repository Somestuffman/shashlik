# frozen_string_literal: true

# == Schema Information
#
# Table name: administrators
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  password_digest :string
#  phone           :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_administrators_on_phone  (phone)
#

class Administrator < ApplicationRecord
  has_secure_password

  has_many :places, as: :author
end
