#!/usr/bin/env ruby

require 'yaml'
require 'tweetstream'
require 'frappuccino'
require_relative 'lib/westwind'

auth = YAML::load_file("twitter_api_config.yml")

TweetStream.configure do |config|
  config.consumer_key       = auth["consumer_key"]
  config.consumer_secret    = auth["consumer_secret"]
  config.oauth_token        = auth["oauth_token"]
  config.oauth_token_secret = auth["oauth_token_secret"]
  config.auth_method        = :oauth
end

# 1. inbound stream (PoemStream) =>
# 2. array of CoupletStreams
# 3. merged CSs #on_value => puts

SUFFIXES = ['es', 'nd', 'ak', 'ck', 're', 'ar', 'pe', 'ne', 'ow', 'en', 'ay', 'me', 'ng', 'la', 'ab', 'an', 'at']
@couplets = SUFFIXES.map {|s| CoupletStream.new(s) }
@poem = Poem.new(@couplets)

@output = Frappuccino::Stream.fold_merge(@couplets)
@output.on_value {|value| puts value.inspect }

# words = ["wind", "commotion", "maenad", "zenith", "overgrown", "pumice",
#   "cleave", "impulse", "tremble", "mankind", "trumpet", "suddenly", "hues"]
words = ["is", "was", "and"]
TweetStream::Client.new.track(*words) do |status|
  @poem.compose(status.text)
end

# cities = [ "-122.75", "36.8", "-121.75", "37.8",
#   "-74", "40", "-73", "41" ]
# TweetStream::Client.new.locations(*cities) do |status|
#   @hose.twoot(status.text)
# end
