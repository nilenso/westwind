class Stanza

  def initialize(couplets)
    @lines = [
      couplets[0].first,
      couplets[1].first,
      couplets[0].second,
      couplets[1].second,
      " "
    ]
  end

  def to_s
    @lines.join("\n")
  end
end
