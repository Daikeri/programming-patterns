#Найти количество чисел, не являющихся делителями исходного
# числа, не взамнопростых с ним и взаимно простых с суммой простых цифр
# этого числа.



def sum_simple(source)

  def quan_div(source)
    quan = 0
    divisor = source
    while divisor > 0
      quan += 1 if source % divisor == 0
      divisor -= 1
    end
    quan
  end

  sum = 0
  while source > 0
    cur = source % 10
    sum += cur if quan_div(cur) <= 2

    source /= 10
  end

  sum

end

def nod(num_one, num_two)
  while num_one != 0 and num_two != 0
    if num_one > num_two
      num_one %= num_two
    else
      num_two %= num_one
    end
  end
  num_one + num_two == 1
end


def main(origin_number)
  quan = 0
  divisor = origin_number
  while divisor > 0
    if origin_number % divisor != 0 and !nod(origin_number, divisor) and nod(sum_simple(origin_number), divisor)
      quan += 1
      puts divisor
      end
    divisor -= 1
  end
  quan
end

puts main 12