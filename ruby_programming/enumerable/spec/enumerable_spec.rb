require './lib/enumerable.rb'

RSpec.describe Enumerable do

  describe "#my_each" do
    it "does the same as the '#each' method" do
      words = ["hello", "world"]
      arr = []
      check = words.my_each { |n| arr << n }
      expect(check).to eql words.each { |n| arr << n }
    end
  end

  describe "#my_select" do
    it "selects the same values as the '#select' method" do
      words = ["hello", "world"]
      check = words.my_select { |n| n == "hello" }
      expect(check).to eql words.select { |n| n == "hello" }
    end

    it "selects no values when enum is empty" do
      words = []
      check = words.my_select { |n| n == "hello" }
      expect(check).to eql words.select { |n| n == "hello" }
    end
  end

  describe "#my_any?" do
    it "does check if array has any values" do
      words = ["hello", "world"]
      check = words.my_any?
      expect(check).to eql true
    end

    it "does the same as the '#any?' method with block" do
      words = ["hello", "world"]
      check = words.my_any? { |n| n == "hello" }
      expect(check).to eql words.any? { |n| n == "hello" }
    end
  end

  describe "#my_all?" do
    it "checks if all checks are 'true' successfully" do
      words = ["hello", "hello"]
      check = words.my_all? { |n| n == "hello" }
      expect(check).to eql true
    end

    it "checks if all checks are 'true' unsuccessfully" do
      words = ["hello", "world"]
      check = words.my_all? { |n| n == "hello" }
      expect(check).to eql false
    end
  end

  describe "#my_none?" do
    it "checks if there are none occurences" do
      words = []
      check = words.my_none?
      expect(check).to eql true
    end


    it "checks if there are none occurences with block successfully" do
      words = ["hello", "hello"]
      check = words.my_none? { |n| n == "h" }
      expect(check).to eql true
    end

    it "checks if there are none occurences with block unsuccessfully " do
      words = ["hello", "world"]
      check = words.my_none? { |n| n == "hello" }
      expect(check).to eql false
    end
  end

  describe "#my_inject" do
    it "does the same as the '#inject' method with block" do
      numbers = [1, 2, 3, 4, 5]
      check = numbers.my_inject { |sum, n| sum * n }
      expect(check).to eql 120
    end

    it "does the same as the '#inject' method with block & starting value" do
      numbers = [1, 2, 3, 4, 5]
      check = numbers.my_inject(2) { |sum, n| sum * n }
      expect(check).to eql 240
    end
  end
end