# == Schema Information
#
# Table name: activities
#
#  id          :bigint           not null, primary key
#  code        :string
#  record_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  record_id   :bigint           not null
#
# Indexes
#
#  index_activities_on_record  (record_type,record_id)
#
class Activity < ApplicationRecord
  belongs_to :record, polymorphic: true

  validates :code, presence: true
  validate :code, if: -> { code_validator } do
    errors.add(:code, :inclusion) unless code_validator.codes.keys.include?(code)
  end

  def self.permit_controller_attributes
    [:code]
  end

  private

  def code_validator
    country = record.is_a?(Company) ? record.headquarters&.address&.country : record&.address&.country

    return unless country

    @code_validator ||= "Register::#{country.capitalize}::Activity".constantize
  rescue NameError
    # Ignored
  end
end
