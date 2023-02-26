# == Schema Information
#
# Table name: people
#
#  id          :bigint           not null, primary key
#  email       :string           default(""), not null
#  first_name  :string           not null
#  last_name   :string           not null
#  middle_name :string           default(""), not null
#  phone       :string           default(""), not null
#  usage_name  :string           default(""), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class PersonSerializer < ApplicationSerializer
  attributes :first_name, :last_name, :middle_name, :usage_name, :email, :phone

  has_one :address
  has_many :managers
end
