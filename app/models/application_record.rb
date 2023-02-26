class ApplicationRecord < ActiveRecord::Base
  include EnumConcern
  include ControllerConcern

  primary_abstract_class

  def self.permit_controller_attributes
    []
  end

  def self.params_controller_attributes(params)
    return {} if !params.is_a?(ActionController::Parameters) && !params.is_a?(Hash)

    if block_given?
      yield params
    else
      params
    end
  end
end
