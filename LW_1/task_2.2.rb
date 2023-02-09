# Метод 2. Найти количество цифр числа, меньших 3.

def quan_numb(source)
  quan = 0
  while source > 0
    quan += 1 if source % 10 < 3
    source /= 10
  end

  quan

end

puts quan_numb 121