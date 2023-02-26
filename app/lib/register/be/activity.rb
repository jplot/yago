require 'csv'

module Register
  module Be
    module Activity
      DATA_PATH = Rails.root.join(__dir__, 'data', 'activity')

      module_function

      def codes
        subclasses.map { |code, row| [code, row] }.to_h
      end

      # Data: https://statbel.fgov.be/fr/propos-de-statbel/methodologie/classifications/nace-bel-2008

      def spreadsheet
        CSV.open(DATA_PATH.join('NACEBEL_2008.csv'), col_sep: ';').drop(1).each_with_object({}) do |row, acc|
          acc[row[0]] ||= []
          acc[row[0]] << [row[1], row[4]]
        end
      end

      def sections
        @sections ||= spreadsheet['1'].drop(1).to_h
      end

      def divisions
        @divisions ||= spreadsheet['2'].drop(1).to_h
      end

      def groups
        @groups ||= spreadsheet['3'].drop(1).to_h
      end

      def classes
        @classes ||= spreadsheet['4'].drop(1).to_h
      end

      def subclasses
        @subclasses ||= spreadsheet['5'].drop(1).to_h
      end
    end
  end
end
