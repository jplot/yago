module Insurers
  class Seraphin < Base
    BASE_URL = 'https://staging-gtw.seraphin.be'

    def request(path, method, payload: nil, query: {}, headers: {})
      headers.merge!(content_type: 'application/json') unless headers[:content_type]
      headers.merge!('X-Api-Key': Rails.application.secrets[:seraphin_api_key])

      super
    end
  end
end
