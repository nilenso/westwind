module Frappuccino
  class Partition < Stream
    def initialize(source, n)
      @n = n
      @so_far = []
      source.add_observer(self)
    end

    def update(value)
      @so_far << value
      if @so_far.length == @n
        occur(@so_far.dup)
        @so_far.clear
      end
    end
  end
end
