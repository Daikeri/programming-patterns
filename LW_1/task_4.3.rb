# 1.30 Дан целочисленный массив и натуральный индекс (число, меньшее
# размера массива). Необходимо определить является ли элемент по
# указанному индексу локальным максимумом.

arr = [48, -52, 81, -61, -67, 17, 42, -68, -24, 51, 19, -44, 49, -21, -50]
index = gets.chomp.to_i
puts(arr[index] == arr[index-1..index+1].min)