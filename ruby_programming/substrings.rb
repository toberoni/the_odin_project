dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]


def substrings(string, dictionary)
  @dictionary = dictionary
  results = {}
  words = string.split(" ")
  words.each do |word|
    word.downcase!
    entries = lookup(word)
    entries.each do |word| 
      if results.has_key?(word)
        results[word] += 1
      else
        results[word] = 1
      end
    end
  end
  return results
end

def lookup(word)
  entries = []
  @dictionary.each do |entry|
    entries << entry if word.include?(entry)
  end
  entries
end