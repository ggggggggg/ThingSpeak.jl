using ThingSpeak
using Base.Test

# write your own tests here
using ThingSpeak
function loadsecret(name="THINGSPEAK_API_KEY")
  if name in keys(ENV)
    println("Loading $name from environment variable")
    return ENV[name]
  else
    println("Loading $name from file")
    return open(name) do f
      chomp(readline(f))
    end
  end
end

ThingSpeak.setdefaultchannel(loadsecret()) #this is technically a secret but its a dedicated channel for testing
response = tsupdate(Dict(3=>3.5),status="ran runtests.jl for ThingSpeak.jl")
response = tsupdate(1.1,2.2)
@test tssuccess(response)

badresponse = tsupdate(1,2,channel=ThingSpeak.TSChannel("ABC")) # use invalid API key
@test !tssuccess(badresponse)
