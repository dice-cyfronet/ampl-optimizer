require 'restclient'
require 'pp'
require 'json'

s = RestClient::Resource.new 'http://localhost:4567/optimize', timeout: 180

((35..38).to_a).each do |i|

  input = {"hosts"=> {},
     "services"=>
      {"s1"=> {"timeSla"=>5, "type"=>"time", "memoryConst"=>1024, "memoryPerCPU"=>256},
       "s2"=> {"timeSla"=>9, "type"=>"time", "memoryConst"=>512, "memoryPerCPU"=>256},
       "s3"=> {"timeSla"=>5, "type"=>"time", "memoryConst"=>256, "memoryPerCPU"=>256},
       "s4"=> {"type"=>"load", "memoryConst"=>256, "memoryPerCPU"=>256}
      },
     "vms"=> {}
   }
  
   i.times.each do |i|
      input["hosts"]["node#{i}"] = {"totalMemory"=>8192, "totalCpus"=>16, "disk"=>1024000}
   end
   
   i.times.each do |i|
     [1,2,3,4].each do |s|
      input["vms"]["s#{s}i#{i}"] = {"service"=>"s#{s}",
                       "cpus"=>2,
                       "host"=>"node#{i}",
                       "memory"=>1024,
                       "responseTime"=>10,
                       "load"=>0.8,
                       "memoryUsage"=>0.5}
     end
   end
   t_start = Time.now
   ret = s.post(input.to_json)
   t_end = Time.now
   output = JSON.parse ret
   begin
     # t = output["debug"]["stdout"].match(/(\d+.\d+) seconds/)[1]
     puts [i, output["errors"].inspect, t_end-t_start].join "\t"
   rescue
     p output
   end
   # exit
end

