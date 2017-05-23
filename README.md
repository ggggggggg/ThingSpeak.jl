# ThingSpeak

[![Build Status](https://travis-ci.org/ggggggggg/ThingSpeak.jl.svg?branch=master)](https://travis-ci.org/ggggggggg/ThingSpeak.jl)

This just provides a function to use the ThingSpeak API.  Get your write API Keys by signing up, creating a channel, and clicking on "API Key".

```Julia
using ThingSpeak
ThingSpeak.setdefaultchannel("YOURAPIKEY") #this is technically a secret but its a dedicated channel for testing
response = tsupdate(1,2,47,status="I posted a status") # this post the values 1,2 and 47 to fields 1,2 and 3 respectively
tssuccess(response) || error("it didn't work!") # in case you care if it worked
response = tsupdate(Dict(3=>47.2})) # post just to field 3
```

[The testing Channel](https://thingspeak.com/channels/25131)
