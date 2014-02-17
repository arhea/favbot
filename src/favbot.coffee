twitter = require 'twit'
moment = require 'moment'
colors = require 'colors'
settings = require './settings/settings.js'

tweeper = new twitter settings.twitter

log = (str) ->
    console.log('[' + 'favbot'.green + ']', str)

delay = (ms, func) ->
    setTimeout func, ms

favoriteTweet = (tweet) ->
    tweeper.post 'favorites/create', { id: tweet.id_str }, (error, tweet) ->

        if error

            log 'ERROR! '.red

            twitterError = JSON.parse error.twitterReply

            if twitterError.errors
                log twitterError.errors
            else
                log twitterError.error

        else
            log ('Tweet by @' + tweet.user.screen_name + ' favorited!').green

startTracking = ->
    stream = tweeper.stream 'statuses/filter', { track: settings.keywords.join ', '  }

    stream.on 'tweet', (tweet) ->

        log ('[' + moment().format('h:mm:ss a') + ']').white + ' ' + ('@' + tweet.user.screen_name + ': ').cyan.bold + (tweet.text).yellow

        log ('waiting ' + settings.delay + 's to favorite...').grey

        delay settings.delay * 1000, -> favoriteTweet tweet

startTracking()
