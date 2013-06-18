#!/usr/bin/env ruby

require 'yaml'
require 'tweetstream'
require 'frappuccino'

auth = YAML::load_file("twitter_api_config.yml")

TweetStream.configure do |config|
  config.consumer_key       = auth["consumer_key"]
  config.consumer_secret    = auth["consumer_secret"]
  config.oauth_token        = auth["oauth_token"]
  config.oauth_token_secret = auth["oauth_token_secret"]
  config.auth_method        = :oauth
end

class Hose
  def twoot(text)
    emit(text)
  end
end

class Frappuccino::TwootStream < Frappuccino::Stream
  def juxt

  end
end


@hose = Hose.new
@stream = Frappuccino::TwootStream.new(@hose)
@stream.on_value {|value| puts value }

# words = ["wind", "commotion", "maenad", "zenith", "overgrown", "pumice",
#   "cleave", "impulse", "tremble", "mankind", "trumpet", "suddenly", "hues"]
words = ["rain", "chicken"]
TweetStream::Client.new.track(*words) do |status|
  @hose.twoot(status.text)
end

# cities = [ "-122.75", "36.8", "-121.75", "37.8",
#   "-74", "40", "-73", "41" ]
# TweetStream::Client.new.locations(*cities) do |status|
#   @hose.twoot(status.text)
# end
