class Rhyme
  def initialize(suffix)
    @suffix = suffix
    @previous = nil
  end

  def why_not(line)
    return unless line.rhymes?(@suffix)
    if @previous
      emit(Couplet.new(@previous, line))
      @previous = nil
    else
      @previous = line
    end
  end

end
