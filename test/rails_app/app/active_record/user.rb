# frozen_string_literal: true

require 'shared_user'

class User < ActiveRecord::Base
  include Shim
  include SharedUser

  has_many :passkeys, class_name: "UserPasskey", dependent: :destroy

  validates :sign_in_count, presence: true

  cattr_accessor :validations_performed

  after_validation :after_validation_callback

  def after_validation_callback
    # used to check in our test if the validations were called
    @@validations_performed = true
  end
end
