twitter = require 'twit'
moment = require 'moment'
settings = require './settings/settings.json'

tweeper = new twitter settings.twitter

log = (str) ->
    console.log("[favbot] " + str)

delay = (ms, func) ->
    setTimeout func, ms

favoriteTweet = (tweet) ->
    tweeper.post 'favorites/create', { id: "" + tweet.id_str }, (errors, tweet) ->
        if errors
            log errors
            return
        log 'Tweet by @' + tweet.user.screen_name + ' favorited!'

startTracking = ->
    stream = tweeper.stream 'statuses/filter', { track: settings.keywords.join ', ' }
    stream.on 'tweet', (tweet) ->
        log '[' + moment().format('h:mm:ss a') + '] @' + tweet.user.screen_name + ': ' + tweet.text
        log 'wating ' + settings.delay + 's to favorite...'
        delay settings.delay * 1000, -> favoriteTweet tweet

startTracking()
