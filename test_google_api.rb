# !/usr/bin/env ruby
require 'google/apis/customsearch_v1'

require 'json'
require "dotenv"

Dotenv.load
API_KEY=ENV['GOOGLE_API_KEY']
CSE_ID=ENV['SEARCH_ENGINE_ID']#カスタムサーチAPI
pp API_KEY,CSE_ID

searcher = Google::Apis::CustomsearchV1::CustomsearchService.new
searcher.key = API_KEY

query = {
  num: 3,
  start: 1,
  cr: 25,
  cx: CSE_ID
}
json=searcher.list_cses(query).to_json
puts json
hash=JSON.parse(json)
puts hash

File.open("result_#{query["q"]}.json", 'w') do |file|
  str = JSON.dump(hash, file)
end