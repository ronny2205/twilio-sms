class Message < ApplicationRecord
  include ActiveModel::Validations

  # VALID_PHONE_NUMBER_REGEX = /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/
  VALID_PHONE_NUMBER_REGEX = /\A\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}[ ]*\z/

  validates :phone_number, presence: { message: "You must provide a phone number." }
  validates_format_of :phone_number,
      :with => VALID_PHONE_NUMBER_REGEX,
      :message => "Please provide a valid US phone number."
end
