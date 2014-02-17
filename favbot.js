(function() {
  var colors, delay, favoriteTweet, log, moment, settings, startTracking, tweeper, twitter;

  twitter = require('twit');

  moment = require('moment');

  colors = require('colors');

  settings = require('./settings/settings.json');

  tweeper = new twitter(settings.twitter);

  log = function(str) {
    return console.log('[' + 'favbot'.green + ']', str);
  };

  delay = function(ms, func) {
    return setTimeout(func, ms);
  };

  favoriteTweet = function(tweet) {
    return tweeper.post('favorites/create', {
      id: tweet.id
    }, function(error, tweet) {
      var twitterError;
      if (error) {
        twitterError = JSON.parse(error.twitterReply);
        return log(twitterError.error.red);
      } else {
        return log(('Tweet by @' + tweet.user.screen_name + ' favorited!').green);
      }
    });
  };

  startTracking = function() {
    var stream;
    stream = tweeper.stream('statuses/filter', {
      track: settings.keywords.join(', ')
    });
    return stream.on('tweet', function(tweet) {
      log(('[' + moment().format('h:mm:ss a') + ']').white + ' ' + ('@' + tweet.user.screen_name + ': ').cyan.bold + tweet.text.yellow);
      log(('waiting ' + settings.delay + 's to favorite...').grey);
      return delay(settings.delay * 1000, function() {
        return favoriteTweet(tweet);
      });
    });
  };

  startTracking();

}).call(this);
