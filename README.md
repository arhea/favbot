favbot
======

Automatically favorite tweets that contain certain keywords

## Configure and Run

First install the dependencies.
`npm install`

Copy the settings file `settings.example.json` and create a `settings.json` in the same location. DO NOT COMMIT THIS TO GITHUB.

```json
{
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

## Develop

To compile changes run
`gulp`
