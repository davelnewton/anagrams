class AnagramFinder
  attr_reader :anagram_file

  def initialize(anagram_file)
    @anagram_file= anagram_file
  end

  def print_matches  
    words_sorted = sort_words
    out_hash = match_and_aggregate(words_sorted)
    print_hash(out_hash)
  end

  private

  def sort_words
    words = words_array
    words_hash = {}
    words.each do |word|
      #clean word of non alphabetic chars
      word.gsub!(/\W+/, '')
      #store word as downcased sorted values for later comparison 
      words_hash[word] = word.downcase.chars.sort.join
    end
    words_hash
  end

  def words_array
    raise 'No anagram file specified' if anagram_file.nil?
    words = File.readlines(anagram_file)
    raise 'Empty input file' if words.empty?
    words
  end

  def match_and_aggregate(words_hash)
    # puts "match_and_aggregate hash: #{words_hash}"
    new_hash = {}

    #iterate over anagram keys and initialize corresponding words array
    words_hash.values.each do |anagram_key|
      new_hash[anagram_key] = []
    end

    #iterate over words and add them as values in new hash for aggregation purposes 
    words_hash.keys.each do |word_key|
      anagram_key = words_hash[word_key]
      word_array = new_hash[anagram_key] << word_key 
    end

    new_hash
  end

  def print_hash(out_hash)
    out_hash.values.each do |anagram_array|
      if anagram_array.size > 1
        puts anagram_array.join(' ')
      end
    end
  end
end

AnagramFinder.new(ARGV.first).print_matches
