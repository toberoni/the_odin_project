class Code
  VALID_COLORS = %w(red green blue orange white black)

  attr_accessor :colors

  def initialize(colors)
    @colors = colors
  end

  def get_hints(code2)
    colors1 = self.colors
    colors2 = code2.colors
    return_reds_and_whites(colors1, colors2)
  end

  def self.generate!
    colors = Array.new(4) { VALID_COLORS.sample }
    self.new(colors)
  end

  private

  def return_reds_and_whites(colors1, colors2)
    reds = 0
    white_hash = {}
    VALID_COLORS.each { |color| white_hash[color] = 0 }

    colors1.each_with_index do |color, index|
      begin
      if color == colors2[index]
        reds += 1
        # deletes color to avoid duplicate white pegs
        white_hash.delete(color)
      elsif colors2.include?(color)
        white_hash[color] += 1
      end
      # rescues if no color key is found in white_hash
      rescue NoMethodError
        next
      end
    end
    { reds: reds, whites: count_unique_whites(white_hash) } 
  end

  def count_unique_whites(white_hash)
    puts white_hash
    white_hash.select { |color, count| count > 0 }.count
  end

  # ["black", "red", "orange", "black"]
  # ["orange", "red", "black", "black"]
  # ["red", "black", "black", "white"]
  # ["white", "white", "black", "black"]
  # ["red", "white", "black", "white"]
  # %w(black black green black) uniq?
  # %w(green black black black)
end