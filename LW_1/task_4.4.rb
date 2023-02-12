# 1.42 Дан целочисленный массив. Найти все элементы, которые меньше
# среднего арифметического элементов массива.
arr = Array.new(30) do
  rand(-100..100)
end
print "#{arr}\n"

arithmetic = arr.sum / arr.size
puts arithmetic

answer = arr.filter {|el| el < arithmetic}
print answer
