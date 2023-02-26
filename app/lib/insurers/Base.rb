module Insurers
  class InvalidMethod < StandardError; end

  class OpenStruct < ::OpenStruct
    def as_json(options = nil)
      @table.as_json(options)
    end
  end

  class Base
    include Singleton

    def get(path = nil, query: {}, headers: {})
      request(path, :get, query: query, headers: headers)
    end

    def post(path = nil, payload: nil, query: {}, headers: {})
      request(path, :post, payload: payload, query: query, headers: headers)
    end

    def request(path, method, payload: nil, query: {}, headers: {})
      decomposed_url = [self.class::BASE_URL]
      decomposed_url << path if path.present?

      uri = URI(decomposed_url.join)
      uri.query = CGI.parse(uri.query || '').merge(query).to_query if query.present?
      resource = Faraday.new(uri.to_s, headers: headers) do |faraday|
        faraday.response :raise_error
      end

      case method.to_s
      when 'post'
        response = resource.post(nil, payload.to_json)
      when 'get'
        response = resource.get
      else
        raise InvalidMethod.new(method)
      end

      case Mime::Type.parse(response.headers[:content_type]).first.to_s
      when 'application/json'
        response.define_singleton_method(:body_parsed) { JSON(body, object_class: OpenStruct) }
      else
        response.define_singleton_method(:body_parsed) { body }
      end

      response
    end
  end
end
