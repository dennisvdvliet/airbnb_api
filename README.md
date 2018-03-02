# AirbnbApi

[![Build Status](https://travis-ci.org/dennisvdvliet/airbnb_api.svg?branch=master)](https://travis-ci.org/dennisvdvliet/airbnb_api) [![Maintainability](https://api.codeclimate.com/v1/badges/616582587775bcabe3cd/maintainability)](https://codeclimate.com/github/dennisvdvliet/airbnb_api/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/616582587775bcabe3cd/test_coverage)](https://codeclimate.com/github/dennisvdvliet/airbnb_api/test_coverage)

The AirbnbApi ruby library provides an easy way to interact with the Airbnb API. The Airbnb API is being actively developed so please expect this gem to change regularly. The documentation for the Airbnb API can be found [here](https://www.airbnb.com/partner/api-docs/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'airbnb_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install airbnb_api

## Usage

### Authorization

Some endpoints on the Airbnb API can be accessed using the Client ID and Client Secret you obtain by registering your application with Airbnb. However the majority of endpoints require and oAuth token you get from the end user.

To obtain an oAuth token redirect a user to the following url:
```
https://www.airbnb.com/oauth2/auth?client_id=:your_client_id&redirect_uri=:your_redirect_url&scope=:your_scope&state=:whatever_you_want
```

One the user logged in and approved your application they will be redirected to `:your_redirect_url`. This redirect request will include two additional GET parameters: `code` and `scope`

In case the user does not approve your application the same URL will be used but the followin GET parameters will be included: `error` and `error_description`

The `code` can be used to obtain an `access_token` and a `refresh_token` you can use to perform API requests. You can use the following code to get them.

```ruby
client = AirbnbApi::Client.new(id: '1234', secret: 'topsecret')
tokens = client.tokens.create_from_code(code)
```

You save both the `access_token` and `refresh_token` since you will need the `refresh_token` to obtain a new `access_token` once it expires. Currently the `access_token` expires after 24 hours.

Refreshing a token is done as follows:

```ruby
tokens = client.tokens.refresh_token(refresh_token)
```



## Supported endpoints

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dennisvdvliet/airbnb_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
