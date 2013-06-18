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

@poem = Poem.new
@poem.on_stanza {|stanza| puts stanza; puts ""}

words = ["is", "was", "and"]
TweetStream::Client.new.track(*words) do |status|
  @poem.compose(status.text)
end
