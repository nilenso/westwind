class Poem
  SUFFIXES = ['es', 'nd', 'ak', 'ck', 're', 'ar', 'pe',
    'ne', 'ow', 'en', 'ay', 'me', 'ng', 'la', 'ab', 'an', 'at']

  def initialize
    @half_couplets = SUFFIXES.map {|s| HalfCouplet.new(s) }

    # TODO: clean
    @couplet_streams = @half_couplets.map do |c|
      Frappuccino::Stream.new(c) #.map {|line| line }
    end

    # TODO: remove newlines / hashtags

    #    Frappuccino::Stream.merge_all(@couplet_streams).

    @raw = RawLine.new
    Frappuccino::Stream.new(@raw).
      select {|line| line.split(" ").length < 10 }.
      multiplex(@half_couplets) {|hc, line| hc.why_not(line) }.
      partition(2).
      map {|couplets| Stanza.new(couplets) }.
      on_value {|stanza| @callback.call(stanza) }
  end

  def compose(line)
    @raw.read(line)
  end

  def multiplex(line)
    # TODO: needs to be a stream op, not collection op
    @half_couplets.each {|c| c.why_not(line) }
  end

  def on_stanza(&block)
    @callback = block
  end

  # 1. inbound stream => raw
  # 2. filter => filtered
  # 3. multiplex => parallel
  # 4. couplet match => couplets
  # 5. demux

end
