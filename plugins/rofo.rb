
message :body => /^\/(space)?rofo\s*([\d])*\s*$/ do
  rofo = ["Subways, subways, subways!", 
    "Anything else?", 
    "I saved a billion dollars.", 
    "I'm running for mayor in 2014!", 
    "Gridlock creates pollution. It keeps you away from your families.", 
    "Cyclists are a pain in the ass.", 
    "The purpose of marathons is to create revenue for charities.", 
    "I stopped the Gravy Train!"
  ]
  send_to members, rofo.sample
end
