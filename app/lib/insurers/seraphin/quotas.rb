module Insurers
  class Seraphin
    module Quotas
      module_function

      def professional_liability(annual_revenue:, number:, name:, natural_person:, activities:)
        Seraphin.instance.post('/quotes/professional-liability', payload: {
          annualRevenue: annual_revenue,
          enterpriseNumber: number,
          legalName: name,
          naturalPerson: natural_person,
          nacebelCodes: activities
        }).body_parsed.data
      rescue Faraday::Error
        OpenStruct.new(available: false)
      end
    end
  end
end
