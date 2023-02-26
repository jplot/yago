# == Schema Information
#
# Table name: managers
#
#  id         :bigint           not null, primary key
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  person_id  :bigint           not null
#
# Indexes
#
#  index_managers_on_company_id  (company_id)
#  index_managers_on_person_id   (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (person_id => people.id)
#
class Manager < ApplicationRecord
  belongs_to :person
  belongs_to :company

  enum role: { chief_executive_officier: 0, human_resources: 1, accountant: 2 }
  validate_enum_of :role, presence: true

  accepts_nested_attributes_for :company

  def self.permit_controller_attributes
    [:role, company_attributes: Company.permit_controller_attributes]
  end

  def self.params_controller_attributes(raw_params)
    super do |params|
      params[:company_attributes] = Company.params_controller_attributes(params[:company_attributes])

      params
    end
  end
end
