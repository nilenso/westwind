class Poem
  def initialize(couplets)
    @couplets = couplets
  end

  def compose(line)
    @couplets.each {|c| c.why_not(line) }
  end

end
