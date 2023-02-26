require 'csv'

module Register
  module Be
    module LegalKind
      DATA_PATH = Rails.root.join(__dir__, 'data', 'legal_kind')

      module_function

      def codes
        spreadsheet
      end

      # Data: https://economie.fgov.be/fr/themes/entreprises/banque-carrefour-des/services-pour-les/tables-de-codes

      def spreadsheet
        CSV.open(DATA_PATH.join('be.csv'), col_sep: ';').drop(1).map do |row|
          [row[0], row[1]]
        end.to_h
      end
    end
  end
end
