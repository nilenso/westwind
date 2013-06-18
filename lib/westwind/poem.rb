class Poem
  SUFFIXES = ['es', 'nd', 'ak', 'ck', 're', 'ar', 'pe',
    'ne', 'ow', 'en', 'ay', 'me', 'ng', 'la', 'ab', 'an', 'at']

  def initialize
    @half_couplets = SUFFIXES.map {|s| HalfCouplet.new(s) }

    @raw = RawLine.new
    Frappuccino::Stream.new(@raw).
      map {|line| clean(line) }.
      select {|line| good?(line) }.
      multiplex(@half_couplets) {|hc, line| hc.why_not(line) }.
      partition(2).
      map {|couplets| Stanza.new(couplets) }.
      on_value {|stanza| @callback.call(stanza) }
  end

  def clean(line)
    line.gsub(/(@\S*)|(#\S*)|(RT )/, "")
  end

  def good?(line)
    line.split(" ").length < 10
  end

  def compose(line)
    @raw.read(line)
  end

  def on_stanza(&block)
    @callback = block
  end

end
