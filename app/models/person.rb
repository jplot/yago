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
class Person < ApplicationRecord
  has_one :address, as: :record, dependent: :destroy

  has_many :managers, dependent: :destroy
  has_many :companies, through: :managers, source: :company

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
  validates :phone, format: { with: /\A\+?\d+\z/ }, allow_blank: true

  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :managers

  def self.permit_controller_attributes
    [:first_name, :last_name, :middle_name, :usage_name, :email, :phone,
     address_attributes: Address.permit_controller_attributes, managers_attributes: Manager.permit_controller_attributes]
  end

  def self.params_controller_attributes
    def self.params_controller_attributes(raw_params)
      super do |params|
        params[:address_attributes] = Address.params_controller_attributes(params[:address_attributes])
        params[:managers_attributes] = controller_parameters_to_array(params[:managers_attributes]).map do |manager_attributes|
          Manager.params_controller_attributes(manager_attributes)
        end

        params
      end
    end
  end
end
