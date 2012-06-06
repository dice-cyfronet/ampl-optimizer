require 'sinatra'
require 'json'
require 'erb'
require 'yaml'
require 'open3'

post '/optimize' do
  status = 200
  request.body.rewind  # in case someone already read it
  postdata = request.body.read
  # p postdata
  data = JSON.parse postdata
  
  hosts = data['hosts']
  services = data['services']
  vms = data['vms']
  
  template = ERB.new File.read('private/optimizer.ampl.erb')
  input = template.result(binding)

  File.open('debug_input.ampl', 'w') { |f| f.write input } if settings.environment == :development
  
  output, error = Open3.popen3('ampl') do |stdin, stdout, stderr, wait_thr|
    stdin.puts input
    [stdout.read, stderr.read]
  end
  # puts output 
  # puts error 

  ret = Hash.new
  
  errors = []
  
  begin
    matches = output.match(/--- solution ---(.*)--- end ---/m)
    raise ArgumentError.new "AMPL failed" if matches.nil?
    ret = YAML.load matches[1]    
    raise ArgumentError.new "solver failed [#{ret['ampl']['solve_result']}]" unless ret['ampl']['solve_result_num'].to_i == 0
  rescue ArgumentError => e
    errors << e.message
  end
  ret['stop_vm'] = [] if ret['stop_vm'].nil?
  ret['start_vm'] = [] if ret['start_vm'].nil?
  ret['errors'] = errors
  ret['debug'] = {stdin: input, stdout: output, stderr: error}  if settings.environment == :development

  
  
  content_type :json
  [status, ret.to_json]
end