require 'spec_helper'

describe AnagramFinder do
  describe '.execute' do
    let(:test_file) { File.dirname(__FILE__) + '/fixtures/test_input.txt' }

    subject { AnagramFinder.execute(test_file) }

    it 'accepts a file name as a parameter for reading' do
      expect{subject}.not_to raise_error
    end
 
    context 'with missing file' do
      let(:test_file) { 'foo.txt' }

      it 'raises an exception' do
        expect {subject}.to raise_error("No such file or directory @ rb_sysopen - #{test_file}")
      end
    end

    context 'with empty file' do
      let(:test_file) { File.dirname(__FILE__) + '/fixtures/empty_file.txt' }

      it 'raises an exception' do
        expect {subject}.to raise_error('Empty input file')
      end
    end

    it 'prints output list of matching anagrams' do
      expect {
        subject
      }.to output("abacus\nsort Tors\n").to_stdout
    end
  end
end