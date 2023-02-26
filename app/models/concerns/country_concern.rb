module CountryConcern
  extend ActiveSupport::Concern

  COUNTRIES = ISO3166::Country.translations.keys.map(&:downcase)
  ENUM_COUNTRIES = COUNTRIES.zip(COUNTRIES).to_h
end
