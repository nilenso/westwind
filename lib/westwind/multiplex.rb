module Frappuccino
  class Multiplex < Stream
    def initialize(source, objs, &block)
      @objs = objs
      @callback = block
      @streams = @objs.map {|obj| Stream.new(obj) }
      @output = Stream.merge_all(@streams)
      source.add_observer(self)
    end

    def update(value)
      @objs.each {|obj| @callback.call(obj, value) }
    end

    def demux
      @output
    end
  end
end
