class Poem
  SUFFIXES = ['es', 'nd', 'ak', 'ck', 're', 'ar', 'pe',
    'ne', 'ow', 'en', 'ay', 'me', 'ng', 'la', 'ab', 'an', 'at']

  def initialize
    @half_couplets = SUFFIXES.map {|s| HalfCouplet.new(s) }

    # TODO: clean
    @couplet_streams = @half_couplets.map do |c|
      Frappuccino::Stream.new(c) #.map {|line| line }
    end

    Frappuccino::Stream.merge_all(@couplet_streams).
      partition(2).
      map {|couplets| Stanza.new(couplets) }.
      on_value {|stanza| @callback.call(stanza) }
  end

  def compose(line)
    multiplex(line)
  end

  def multiplex(line)
    # TODO: needs to be a stream op, not collection op
    @half_couplets.each {|c| c.why_not(line) }
  end

  def on_stanza(&block)
    @callback = block
  end

  def clean
    # TODO: remove newliens
    # TODO: remove hashtags
    # TODO: trim n words
  end

  # 1. inbound stream => raw
  # 2. filter => filtered
  # 3. multiplex => parallel
  # 4. couplet match => couplets
  # 5. demux

end
