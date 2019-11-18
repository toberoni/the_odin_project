require './lib/caesar_cipher.rb'

RSpec.describe CaesarCipher do
  describe "#caesar_cipher" do

    context "single word with small letters" do
      it "encrypts with shift of 2" do
        cyph = CaesarCipher.new
        expect(cyph.caesar_cipher("hello", 2)).to eql "jgnnq"
      end
    end

    context "single word with capitalized letters" do

      it "encrypts with shift of 2" do
        cyph = CaesarCipher.new
        expect(cyph.caesar_cipher("Hello", 2)).to eql "Jgnnq"
      end

      it "encrypts with shift of 25" do
        cyph = CaesarCipher.new
        expect(cyph.caesar_cipher("Hello", 25)).to eql "Gdkkn"
      end

      it "shows error message if shift is > 25" do
        cyph = CaesarCipher.new
        expect(cyph.caesar_cipher("Hello", 26)).to eql "Shift can be 25 at most. Please choose a smaller number."
      end

    end

    context "multiple words with capitalized letters" do

      it "encrypts with shift of 2" do
        cyph = CaesarCipher.new
        expect(cyph.caesar_cipher("Hello guys!", 2)).to eql "Jgnnq iwau!"
      end

      it "encrypts with shift of 25" do
        cyph = CaesarCipher.new
        expect(cyph.caesar_cipher("Hello guys!", 25)).to eql "Gdkkn ftxr!"
      end

    end
  end
end