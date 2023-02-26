# == Schema Information
#
# Table name: addresses
#
#  id              :bigint           not null, primary key
#  additional_info :string           default(""), not null
#  address         :string           not null
#  city            :string           not null
#  country         :string           not null
#  record_type     :string           not null
#  zipcode         :string           default(""), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  record_id       :bigint           not null
#
# Indexes
#
#  index_addresses_on_record  (record_type,record_id)
#
class Address < ApplicationRecord
  include CountryConcern

  belongs_to :record, polymorphic: true

  validates :address, presence: true
  validates :city, presence: true

  enum country: ENUM_COUNTRIES, _prefix: true
  validate_enum_of :country, presence: true

  def self.permit_controller_attributes
    [:address, :zipcode, :city, :country, :additional_info]
  end
end
