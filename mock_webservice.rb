require 'sinatra'
require 'json'

post '/optimize' do
  request.body.rewind  # in case someone already read it
  postdata = request.body.read
  p postdata
  data = JSON.parse postdata
  
  hosts = data['hosts']
  services = data['services']
  vms = data['vms']
  
  ret = {start_vms: [], stop_vms: [], errors: []}

  ret[:stop_vms] = vms.keys.select { Random.new.rand < 0.5 }
  ret[:start_vms] = services.keys.select { Random.new.rand < 0.5 }.map{|s| {service: s, memory: 512, cpu: 4} }
  
  
  content_type :json
  ret.to_json
end