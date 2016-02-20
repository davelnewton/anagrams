class AnagramFinder
  attr_reader :anagram_file, :max_anagram_size, :out_hash

  def initialize(anagram_file)
    @anagram_file= anagram_file
  end

  def print_matches  
    words_sorted = sort_words
    match_and_aggregate words_sorted
    print_hash
  end

  def print_longest_anagrams
    words_sorted = sort_words
    match_and_aggregate words_sorted
    print_hash_with_max_sizes 
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
    words = File.readlines anagram_file
    raise 'Empty input file' if words.empty?
    words
  end

  def match_and_aggregate(words_hash)
    # puts "match_and_aggregate hash: #{words_hash}"
    @out_hash = {}

    #iterate over anagram keys and initialize corresponding words array
    words_hash.values.each do |anagram_key|
      @out_hash[anagram_key] = []
    end

    @max_anagram_size = 0

    #iterate over words and add them as values in new hash for aggregation purposes 
    words_hash.keys.each do |word_key|
      anagram_key = words_hash[word_key]
      word_array = @out_hash[anagram_key] << word_key 
      set_max_anagram_size(anagram_key) if have_anagram?(word_array)
    end
  end

  def have_anagram?(matching_array)
    matching_array.size > 1
  end

  def set_max_anagram_size(anagram)
    @max_anagram_size = anagram.size if anagram.size > @max_anagram_size
  end

  def print_hash
    @out_hash.values.each do |anagram_array|
      if anagram_array.size > 1
        puts anagram_array.join(' ')
      end
    end
  end  

  def print_hash_with_max_sizes
    @out_hash.values.each do |anagram_array|
      if anagram_array.size > 1 && 
         anagram_array.first.size == max_anagram_size
        puts anagram_array.join(' ')
      end
    end
  end
end

AnagramFinder.new(ARGV.first).print_longest_anagrams
