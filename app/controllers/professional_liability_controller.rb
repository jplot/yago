class ProfessionalLiabilityController < ApplicationController
  def quotas
    person = Person.new(person_params)

    if person.save
      render json: person.companies.first.professional_liability, include: '**'
    else
      render json: person.errors, status: :unprocessable_entity
    end
  end

  protected

  def person_params
    params.require(:person).permit(Person.permit_controller_attributes)
  end
end