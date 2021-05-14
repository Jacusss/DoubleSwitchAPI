
--[[
%% properties
%% globals
--]]

local http = net.HTTPClient()
http:request("http://api.openweathermap.org/data/2.5/weather?q=<>,<>.,<>&appid=<>&units=metric&lang=<>",
  {
    options = {method = 'GET'}, 
    success = function(response)
      t=json.decode(response.data)
      a=(t.main.temp)
      b=(t.main.pressure)
      c=(t.main.humidity)
      delta = (math.pow(b, 2) - ((4 * a) * c))
    print("delta jest równa:", delta)

      if delta>0 then
        for i=0, 10, 1 do
        fibaro:call(9, "turnOn")
        fibaro:sleep(i*100)
        fibaro:call(9, "turnOff")        
      end  
  
      elseif delta==0 then
      for i=0, 10, 1 do
        fibaro:call(9, "turnOn")
        fibaro:sleep(500)
        fibaro:call(9, "turnOff")     
      end
    
    else
         fibaro:call(9, "turnOn")
    end

end,
  error = function(errorcode) 
      fibaro:debug("error=" .. errorcode)
    end 
  })

