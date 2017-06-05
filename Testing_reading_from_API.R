# Getting data from an API using httr package and application account
# from lecture notes/code

# ConsumerKey, ConsumerSecret and TokenSecret all come from website
# which in this example is twitter

myapp = oauth_app("twitter", 
                  key = "YourConsumerKeyHere", secret = "YourConsumerSecretHere")
sig = sign_oauth1.0(myapp,
                    token = "YourTokenHere",
                    token_secret = "YourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)
json1 = content(homeTL) #use content function to extract json
json2 = jsonlite::fromJSON(toJSON(json1))  # use jsonlite package to reformat as data frame