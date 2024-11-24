require 'net/http'
require 'json'

module LatestStockPrice
  class Client
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com'
    HEADERS = {
      'X-RapidAPI-Key' => 'eeeb488c56msh3329ca76c310145p1a28f5jsn8853fbe8df0f',
      'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com'
    }

    def price_all
      request('/any')
    end

    private

    def request(path)
      uri = URI("#{BASE_URL}#{path}")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri, HEADERS)
      response = http.request(request)
      raise "Failed to fetch data: #{response.message}" unless response.is_a?(Net::HTTPSuccess)

      JSON.parse(response.body)
    end
  end
end
