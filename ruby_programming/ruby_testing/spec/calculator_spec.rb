require './lib/calculator'

RSpec.describe Calculator do
  describe "#add" do
    it "returns the sum of two numbers" do
      calc = Calculator.new
      expect(calc.add(5, 2)).to eql(7)
    end

    it "returns the sum of more than two numbers" do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe "#substract" do
    it "returns the remainder of a substraction of two numbers" do 
      calc = Calculator.new
      expect(calc.substract(5, 2)).to eql(3)
    end
  end

  describe "#multiply" do
    it "returns the product of two numbers" do 
      calc = Calculator.new
      expect(calc.multiply(5, 2)).to eql(10)
    end
  end

  describe "#multiply" do
    it "returns the remainder of a division of two numbers" do 
      calc = Calculator.new
      expect(calc.divide(10, 2)).to eql(5)
    end
  end
end
