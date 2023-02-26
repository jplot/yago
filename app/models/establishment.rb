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
class Establishment < ApplicationRecord
  belongs_to :company

  has_one :address, as: :record, dependent: :destroy
  has_many :activities, as: :record, dependent: :destroy

  validates :primary, inclusion: { in: [true, false] }
  validates :primary, if: -> { primary }, uniqueness: { scope: :company_id }
  validates :number, presence: true

  validates :activity_begins_at, presence: true

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :activities

  def self.permit_controller_attributes
    [:number, :activity_begins_at, :activity_ends_at, :name,
     address_attributes: Address.permit_controller_attributes, activities_attributes: Activity.permit_controller_attributes]
  end

  def self.params_controller_attributes(raw_params)
    super do |params|
      params[:address_attributes] = Address.params_controller_attributes(params[:address_attributes])
      params[:activities_attributes] = controller_parameters_to_array(params[:activities_attributes]).map do |activity_attributes|
        Activity.params_controller_attributes(activity_attributes)
      end

      params
    end
  end
end
