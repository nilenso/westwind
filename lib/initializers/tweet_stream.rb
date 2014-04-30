require 'yaml'
require 'tweetstream'

auth = YAML::load_file(File.expand_path("twitter_api_config.yml"))

TweetStream.configure do |config|
  config.consumer_key       = auth["consumer_key"]
  config.consumer_secret    = auth["consumer_secret"]
  config.oauth_token        = auth["oauth_token"]
  config.oauth_token_secret = auth["oauth_token_secret"]
  config.auth_method        = :oauth
end
