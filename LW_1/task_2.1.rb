
def simple_div(source_divisor)
  quan = 0
  divisor = source_divisor

  while divisor > 0
    quan += 1 if source_divisor % divisor == 0
    divisor -= 1
  end

  quan > 2

end


def sum_div(source_number)
  sum = 0
  divisor = source_number

  while divisor > 0
    sum += divisor if source_number % divisor == 0 and simple_div divisor
    divisor -= 1
  end

  sum

end

puts sum_div 6