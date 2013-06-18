class HalfCouplet
  def initialize(suffix)
    @suffix = suffix
    @matched = []
  end

  def why_not(line)
    return if line.strip.empty?
    @matched << line if line.end_with?(@suffix)
    if @matched.length > 1
      emit(Couplet.new(@matched[0], @matched[1]))
      @matched.clear
    end
  end

  def clean
    # remove newliens
  end
end
