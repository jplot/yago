# == Schema Information
#
# Table name: companies
#
#  id                 :bigint           not null, primary key
#  activity_begins_at :date             not null
#  activity_ends_at   :date
#  annual_revenue     :integer          default(0), not null
#  kind               :string           not null
#  name               :string           not null
#  natural_person     :boolean          not null
#  number             :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class CompanySerializer < ApplicationSerializer
  attributes :name, :number, :kind, :natural_person, :annual_revenue, :activity_begins_at, :activity_ends_at

  has_many :establishments
  has_many :activities
end
