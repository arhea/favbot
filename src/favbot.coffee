twitter = require 'twit'
moment = require 'moment'
colors = require 'colors'
_ = require 'lodash'
settings = require './settings/settings.js'

tweetCount = 0

tweeper = new twitter settings.twitter

log = (str) ->
    console.log('[' + 'favbot'.green + ']', str)

favoriteTweetLater = (ms, func) ->
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
            tweetCount++;
            log ('[' + tweetCount + ']').magenta + ('Tweet by @' + tweet.user.screen_name + ' favorited!').green

startTracking = () ->

    log "Starting to listen...."
    log settings.keywords.join ', '

    stream = tweeper.stream 'statuses/filter', { track: settings.keywords.join ', '  }

    stream.on 'tweet', (tweet) ->

        time = _.result(settings, 'delay')
        now = moment().format('h:mm:ss a')

        log ('[' + now + ']').white + ' ' + ('@' + tweet.user.screen_name + ': ').cyan.bold + (tweet.text).yellow

        log ('waiting ' + time + ' minutes to favorite...').grey

        favoriteTweetLater time * 1000 * 60, -> favoriteTweet tweet

startTracking()
