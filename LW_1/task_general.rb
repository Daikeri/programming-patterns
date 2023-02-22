

def task_1
  test = [1, 2, 3, 4, 5, 6, 7]

  answer = test.concat(test.shift(3))
  puts answer
end

def task_2
  arr = [-20, 26, 8, -74, 79, -29, -74, 73, 82, 75, -20]
  min = arr.min
  answer = arr.take_while { |el| el != min }
  puts "answer:#{answer}"
end

def task_3

  def my_local(array, index)
    if array[index - 1] == array.last
      return array[index] == array[index..index+1].max
    elsif array[index + 1] == array.first
      return array[index] == array[index-1..index].max
    else
      array[index] == array[index-1..index+1].max
    end
  end

  arr = [48, -52, 81, -61, -67, 17, 42, -68, -24, 51, 19, -44, 49, -21, -50]
  res = my_local_max arr, 0
  puts res

end

def task_4
  arr = Array.new(30) do
    rand(-100..100)
  end
  print "#{arr}\n"

  arithmetic = arr.sum / arr.size
  puts arithmetic

  answer = arr.filter {|el| el < arithmetic}
  print answer
end


def task_5
  arr = [32, 58, -31, -19, 49, 36, 45, 18, 89, 9, -35, 47, -78, -19, 49,
         -19, -89, 97, -96, 70, 77, -3, -34, -19, 39, 44, 49, -41, -41, 49]

  answer = arr.select do |el|
    (arr.inject(0) {|acc, item|if item == el then acc + 1 else acc end }) > 3
  end

  answer.uniq!

  print answer
end


task = gets.chomp

case task
when '1'
  task_1
when '2'
  task_2
when '3'
  task_3
when '4'
  task_4
when '5'
  task_5
else
  puts 'error'
end