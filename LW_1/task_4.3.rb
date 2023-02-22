# 1.30 Дан целочисленный массив и натуральный индекс (число, меньшее
# размера массива). Необходимо определить является ли элемент по
# указанному индексу локальным максимумом.

def my_local_max(array, index)
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
