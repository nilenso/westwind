class Line
  def initialize(text)
    @text = text.gsub(/(@\S*)|(#\S*)|(RT )/, "").gsub("\n", "").strip
  end

  def good?
    exists? && nine_words? && no_ugly_words?
  end

  def rhymes?(suffix)
    @text.end_with?(suffix)
  end

  def to_s
    @text
  end

  private

  def exists?
    !@text.strip.empty?
  end

  def nine_words?
    @text.split(" ").length < 10
  end

  def no_ugly_words?
    ["http", ".com", ".net", "cunt", "lol", ":)", "&lt", "hmm", "haha", ":-)", ":)", "srsly", "&gt;", "&amp;", "xxx",
     "!!", ";)", "ooo", "aaa", "nnn", "ccc", "ur ", "ma " "wtf", ":/", "sss", "%", ':(', ':d', 'yeahh', 'wth','yyy', 'eee', 'fml',
     "tbh", "tbd", "??", "?!", '___', "idk", "//", "smh", "lmao", "shit"
    ].reduce(true) do |is_clean, word|
      is_clean && !@text.include?(word)
    end
  end
end
