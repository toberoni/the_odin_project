prices = [17,3,6,9,15,8,6,1,10]

def stock_picker(prices)
  profits = {}

  prices.each.with_index do |price, index|
    res = {}
    index2 = index
    while index2 < prices.length - 1
      index2 += 1
      res[index2] = - price + prices[index2]
    end
    profits[index] = res
  end


  profits.each.with_index do |ar, index|
    if index < profits.size - 1
      @max_val = ar[1].max_by{|k,v| v}
    end
    #max_val[0] is key(day) and [1] is value(profit)
    if index == 0 || index > 0 && @max_val[1] > @res[:profit]
      @res = {}
      @res[:buy] = index
      @res[:sell] = @max_val[0]
      @res[:profit] = @max_val[1]
    end
  end
  puts @res
end