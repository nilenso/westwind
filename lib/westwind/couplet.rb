class Couplet
  def initialize(suffix)
    @suffix = suffix
    @matched = []
  end

  def why_not(line)
    @matched << line if line.end_with?(@suffix)
    if @matched.length > 1
      x = @matched.dup
      @matched.clear
      x
    end
  end
end
