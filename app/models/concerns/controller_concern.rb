module ControllerConcern
  extend ActiveSupport::Concern

  class_methods do
    def controller_parameters_to_array(params)
      case params
      when Array
        params
      when Hash, ActionController::Parameters
        params.values
      else
        []
      end
    end

    def controller_base64_to_uploaded_file(type, content)
      return if content.blank?

      tempfile = Tempfile.new('base64_to_uploaded_file')
      tempfile.binmode
      tempfile.write(Base64.strict_decode64(content))
      tempfile.flush
      tempfile.rewind

      mine_type = if MIME::Types[type].any?
                    MIME::Types[type]
                  else
                    type = Marcel::MimeType.for(tempfile)
                    MIME::Types[type]
                  end

      return unless mine_type

      preferred_extension = mine_type.find do |mine_type|
        mine_type.preferred_extension.presence
      end
      extension = preferred_extension ? ".#{preferred_extension}" : nil

      ActionDispatch::Http::UploadedFile.new(
        type: type,
        filename: "#{SecureRandom.hex}#{extension}",
        tempfile: tempfile
      )
    rescue ArgumentError
      nil
    end
  end

  delegate :controller_parameters_to_array, to: :class
  delegate :controller_base64_to_uploaded_file, to: :class
end
