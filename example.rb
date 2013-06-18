#!/usr/bin/env ruby

require 'yaml'
require 'tweetstream'
require_relative 'lib/westwind'

auth = YAML::load_file("twitter_api_config.yml")

TweetStream.configure do |config|
  config.consumer_key       = auth["consumer_key"]
  config.consumer_secret    = auth["consumer_secret"]
  config.oauth_token        = auth["oauth_token"]
  config.oauth_token_secret = auth["oauth_token_secret"]
  config.auth_method        = :oauth
end

@poem = Poem.new {|stanza| puts stanza }

words = ["is", "was", "and"]
TweetStream::Client.new.track(*words) do |status|
  @poem.compose_by(status.text)
end
