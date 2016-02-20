require 'spec_helper'

describe AnagramFinder do
  let(:test_file) { File.dirname(__FILE__) + '/fixtures/test_input.txt' }

  subject { AnagramFinder.new(test_file) }

  describe '#anagram_file' do
    it 'returns anagram file' do
      expect(subject.anagram_file).to eq test_file
    end
  end

  describe '#print_matches' do

    it 'does not raise error with valid file' do
      expect{subject.print_matches}.not_to raise_error
    end

    context 'with missing file' do
      let(:test_file) { 'foo.txt' }

      it 'raises an exception' do
        expect {subject.print_matches}.to raise_error("No such file or directory @ rb_sysopen - #{test_file}")
      end
    end

    context 'with empty file' do
      let(:test_file) { File.dirname(__FILE__) + '/fixtures/empty_file.txt' }

      it 'raises an exception' do
        expect {subject.print_matches}.to raise_error('Empty input file')
      end
    end

    it 'prints output list of matching anagrams' do
      expect {
        subject.print_matches
      }.to output("sort Tors\nbabble lebabb\nabcdef cbadef\n").to_stdout
    end
  end

  describe '#print_longest_anagrams' do
    it 'prints out the longest anagram words' do
      expect {
        subject.print_longest_anagrams
      }.to output("babble lebabb\nabcdef cbadef\n").to_stdout
    end
  end
end