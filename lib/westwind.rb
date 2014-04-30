
require 'frappuccino'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/streaming'
require 'json'

require_relative 'westwind/muxdemux'
require_relative 'westwind/partition'
require_relative 'westwind/stream'

require_relative 'westwind/raw'
require_relative 'westwind/line'
require_relative 'westwind/couplet'
require_relative 'westwind/stanza'
require_relative 'westwind/rhyme'
require_relative 'westwind/poem'

require_relative 'initializers/tweet_stream'

module Westwind
  class Application < Sinatra::Base
    helpers Sinatra::Streaming

    connections = []

    configure :development do
      register Sinatra::Reloader
    end

    get '/stream', provides: 'text/event-stream' do
      stream(:keep_open) do |out|
        connections << out
        out.callback { connections.delete(out) } # callback called when connection closed
      end
    end

    get '/' do
      poem = Poem.new do |stanza|
        connections.each { |out| out << "data: #{stanza.lines.to_json} \n\n" }
      end

      words = ["is", "was", "and"]
      TweetStream::Client.new.track(*words) do |status|
        poem.compose_by(status.text)
      end
      erb :home
    end

  end
end
