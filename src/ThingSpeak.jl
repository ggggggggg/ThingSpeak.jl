module ThingSpeak
using Requests
immutable TSChannel
  writekey::AbstractString
end
const updateapiurl = "https://api.thingspeak.com/update"
const updateheaders = Dict("Content-type"=> "application/x-www-form-urlencoded","Accept"=> "text/plain")
defaultchannel = TSChannel("")
setdefaultchannel(s::AbstractString) = (global defaultchannel = TSChannel(s))

function updatedata(channel::TSChannel, status::AbstractString, fields::Dict)
  data = "key=$(channel.writekey)"
  for (i,f) in fields
    data *= "&field$i="*@sprintf("%f",f)
  end
  if status != ""
    length(status)>140 && error("status is limited to 140 characters in ThingSpeak API")
    data *= "&status=$status"
  end
  data
end
function tsupdate(fields::Dict;status::AbstractString="", channel::TSChannel=defaultchannel)
  response = post(updateapiurl, data=updatedata(channel, status, fields), headers=updateheaders)
end
function tsupdate(fields...;status::AbstractString="", channel::TSChannel=defaultchannel)
  response = post(updateapiurl, data=updatedata(channel, status, Dict(k=>v for (k,v) in enumerate(fields))), headers=updateheaders)
end

tssuccess(r::Requests.Response) = r.data != "0" && r.status==200

export tsupdate, tssuccess
end # module
