favbot
======

Automatically favorite tweets that contain certain keywords

### Configure and Run

First install the dependencies.

`npm install`

Copy the settings file `settings.example.json` and create a `settings.json` in the same location. DO NOT COMMIT THIS TO GITHUB.

```json
{
    "twitter": {
        "consumer_key": "YOUR_CONSUMER_KEY",
        "consumer_secret": "YOUR_CONSUMER_SECRET",
        "access_token": "YOUR_ACCESS_TOKEN",
        "access_token_secret": "YOUR_ACCESS_TOKEN_SECRET"
    },

    "keywords": [],

    "delay": 32
}
```

Run the favbot
`node favbot`

### Twitter Account Setup

Go to [https://apps.twitter.com](https://apps.twitter.com) and create an application. Make sure you select Read Write permissions. Generate access tokens and API keys and place those in your `settings.json` file.

### Development

Will compile coffeescript files and will watch for changes to the code base.

`gulp`
