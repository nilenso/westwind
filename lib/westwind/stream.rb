class Frappuccino::Stream

  def self.fold_merge(streams)
    streams.reduce {|c, s| Frappuccino::Stream.merge(c, s) }
  end

end
