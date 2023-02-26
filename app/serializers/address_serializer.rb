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
class AddressSerializer < ApplicationSerializer
  attributes :address, :additional_info, :zipcode, :city, :country
end
