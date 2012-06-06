require 'restclient'
require 'pp'
require 'json'

s = RestClient::Resource.new 'http://localhost:4567/optimize'
ret = s.post File.read('sample_input.json')
pp JSON.parse(ret)
