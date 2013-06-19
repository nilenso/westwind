class Poem
  SUFFIXES = ["es", "nd", "ak", "ck", "re", "ar", "pe", "ne", "ow", "en", "ay", "me", "ng", "la", "ab", "an", "at", "ad", "am", "ap", "aw", "in", "ip", "it", "og", "oo", "op", "ot", "ug", "oot", "un"]

  # SUFFIXES = ["ack", "age", "ail", "ain", "ake", "ale", "all", "ame", "ank", "ash", "ate", "bad", "ban", "bar", "bat", "bay", "bin", "bit", "bog", "boo", "bop", "bot", "bow", "bug", "bun", "cad", "cam", "can", "cap", "car", "cat", "caw", "cog", "coo", "cop", "cot", "cow", "dad", "dam", "day", "den", "din", "dip", "dog", "dot", "dug", "eat", "eel", "eep", "eet", "ell", "ent", "est", "fan", "far", "fat", "fen", "fin", "fit", "fog", "fun", "gap", "gar", "gay", "gin", "goo", "got", "gun", "had", "ham", "hat", "hay", "hen", "hip", "hit", "hog", "hop", "hot", "how", "hug", "ice", "ick", "ide", "ife", "ile", "ill", "ine", "ink", "jam", "jar", "jaw", "jay", "jog", "jot", "jug", "kin", "kit", "lad", "lam", "lap", "law", "lay", "lip", "lit", "log", "lop", "lot", "low", "lug", "mad", "man", "map", "mar", "mat", "may", "men", "mit", "moo", "mop", "mow", "mug", "nap", "nay", "nip", "not", "now", "nun", "oat", "ock", "oil", "oke", "ood", "oof", "ook", "ool", "oom", "oon", "oop", "ore", "orn", "out", "own", "pad", "pan", "par", "pat", "paw", "pay", "pen", "pin", "pit", "pop", "pot", "pug", "pun", "ram", "ran", "rap", "rat", "raw", "ray", "rip", "rot", "row", "rug", "run", "sad", "sap", "sat", "saw", "say", "sin", "sip", "sit", "sop", "sow", "sun", "tam", "tan", "tap", "tar", "tat", "ten", "tin", "tip", "too", "top", "tot", "tow", "tug", "uck", "ump", "unk", "van", "vat", "vow", "way", "win", "wit", "woo", "wow", "yam", "yap", "yen", "zap", "zip", "zoo", "ning", "ming", "king", "cing", "ding", "fing", "ging", "hing", "king", "ling", "ping", "oing" ]

  def initialize(&block)
    @output = block
    @input = Raw.new
    Frappuccino::Stream.new(@input).
      map {|text| Line.new(text) }.
      select {|line| line.good? }.
      muxdemux(rhymes) {|rhyme, line| rhyme.why_not(line) }.
      partition(2).
      map {|couplets| Stanza.new(couplets) }.
      on_value {|stanza| @output.call(stanza) }
  end

  def rhymes
    SUFFIXES.map {|s| Rhyme.new(s) }
  end

  def compose_by(text)
    @input.read(text)
  end

end
