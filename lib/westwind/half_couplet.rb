class HalfCouplet
  def initialize(suffix)
    @suffix = suffix
    @previous = nil
  end

  def why_not(line)
    return if line.strip.empty?
    return unless line.end_with?(@suffix)
    if @previous
      emit(Couplet.new(@previous, line))
      @previous = nil
    else
      @previous = line
    end
  end

end
