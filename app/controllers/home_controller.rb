class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    url = 'https://s3-ap-southeast-1.amazonaws.com/kiyo-development/test/categories.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @data_hash = JSON.parse(response) 
  end
end
