# == Schema Information
#
# Table name: establishments
#
#  id                 :bigint           not null, primary key
#  activity_begins_at :date             not null
#  activity_ends_at   :date
#  name               :string
#  number             :string           not null
#  primary            :boolean          default(FALSE), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  company_id         :bigint           not null
#
# Indexes
#
#  index_establishments_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class EstablishmentSerializer < ApplicationSerializer
  attributes :name, :number, :primary, :activity_begins_at, :activity_ends_at

  has_one :address
  has_many :activities
end
