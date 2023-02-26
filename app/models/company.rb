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
class Company < ApplicationRecord
  has_many :establishments, dependent: :destroy
  has_one :headquarters, -> { where(primary: true) }, class_name: 'Establishment'
  has_many :activities, as: :record, dependent: :destroy

  validates :kind, presence: true
  validate :kind, if: -> { kind_validator } do
    errors.add(:kind, :inclusion) unless kind_validator.codes.keys.include?(kind)
  end
  validates :name, presence: true
  validates :number, presence: true
  validates :natural_person, inclusion: { in: [true, false] }
  validates :annual_revenue, presence: true
  validates :activity_begins_at, presence: true

  accepts_nested_attributes_for :establishments
  accepts_nested_attributes_for :headquarters
  accepts_nested_attributes_for :activities

  def self.permit_controller_attributes
    [:kind, :name, :number, :natural_person, :annual_revenue, :activity_begins_at, :activity_ends_at,
     headquarters_attributes: Establishment.permit_controller_attributes, establishments_attributes: Establishment.permit_controller_attributes,
     activities_attributes: Activity.permit_controller_attributes]
  end

  def self.params_controller_attributes(raw_params)
    super do |params|
      params[:establishments_attributes] = controller_parameters_to_array(params[:establishments_attributes]).map do |establishment_attributes|
        Establishment.params_controller_attributes(establishment_attributes)
      end
      params[:activities_attributes] = controller_parameters_to_array(params[:activities_attributes]).map do |activity_attributes|
        Activity.params_controller_attributes(activity_attributes)
      end

      params
    end
  end

  def professional_liability
    Insurers::Seraphin::Quotas.professional_liability(
      annual_revenue: annual_revenue,
      number: number,
      name: name,
      natural_person: natural_person,
      activities: activities.map(&:code)
    )
  end

  private

  def kind_validator
    country = headquarters&.address&.country

    return unless country

    @kind_validator ||= "Register::#{country.capitalize}::LegalKind".constantize
  rescue NameError
    # Ignored
  end

  def natural_person?
    kind == 'natural_person'
  end
end
