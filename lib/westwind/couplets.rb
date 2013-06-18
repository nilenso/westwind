class Couplets
  SUFFIXES = ['es', 'nd', 'ak', 'ck', 're', 'ar', 'pe', 'ne', 'ow', 'en', 'ay', 'me', 'ng', 'la', 'ab', 'an', 'at']

  def initialize
    @couplets = SUFFIXES.map {|s| Couplet.new(s) }
  end

  def compose_poetry(line)
    @couplets.each do |c|
      couplet = c.why_not(line)
      emit(couplet) if couplet
    end
  end
end
