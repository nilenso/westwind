class CoupletStream < Frappuccino::Stream
  def initialize(suffix)
    @suffix = suffix
    @matched = []
  end

  def why_not(line)
    @matched << line if line.end_with?(@suffix)
    if @matched.length > 1
      emit(@matched)
      @matched.clear
    end
  end
end
