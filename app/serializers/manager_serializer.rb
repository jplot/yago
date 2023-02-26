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
class ManagerSerializer < ApplicationSerializer
  attributes :role

  belongs_to :company
end
