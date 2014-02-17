(function() {
  var delay, favoriteTweet, log, moment, settings, startTracking, tweeper, twitter;

  twitter = require('twit');

  moment = require('moment');

  settings = require('./settings/settings.json');

  tweeper = new twitter(settings.twitter);

  log = function(str) {
    return console.log("[favbot] " + str);
  };

  delay = function(ms, func) {
    return setTimeout(func, ms);
  };

  favoriteTweet = function(tweet) {
    return tweeper.post('favorites/create', {
      id: "" + tweet.id_str
    }, function(errors, tweet) {
      if (errors) {
        log(errors);
        return;
      }
      return log('Tweet by @' + tweet.user.screen_name + ' favorited!');
    });
  };

  startTracking = function() {
    var stream;
    stream = tweeper.stream('statuses/filter', {
      track: settings.keywords.join(', ')
    });
    return stream.on('tweet', function(tweet) {
      log('[' + moment().format("h:mm:ss a") + '] Found a tweet from @' + tweet.user.screen_name + " (id " + tweet.id_str + ", waiting for " + settings.delay + "s)");
      log('  ' + tweet.text);
      return delay(settings.delay * 1000, function() {
        return favoriteTweet(tweet);
      });
    });
  };

  startTracking();

}).call(this);
