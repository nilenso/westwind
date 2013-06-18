module Frappuccino
  class Stream

    def self.merge_all(streams)
      streams.reduce {|c, s| Stream.merge(c, s) }
    end

    def partition(n)
      Partition.new(self, n)
    end

  end
end
