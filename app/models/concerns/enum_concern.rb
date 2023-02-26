module EnumConcern
  extend ActiveSupport::Concern

  included do
    validate do
      enum_validations.each do |attr_name|
        errors.add(attr_name, :inclusion)
      end
    end
  end

  class_methods do
    def validate_enum_of(name, **options)
      class_eval <<-METHODS, __FILE__, __LINE__ + 1
        def #{name}=(value)
          super(value.to_s.downcase)
        rescue ArgumentError
          enum_validations << :#{name}
        end
      METHODS

      return unless options[:presence]

      class_eval <<-METHODS, __FILE__, __LINE__ + 1
        validates :#{name}, presence: true, unless: -> { enum_validations.include?(:#{name}) }
      METHODS
    end
  end

  def enum_validations
    @enum_validations ||= []
  end
end
