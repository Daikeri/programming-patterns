# 1.6 Дан целочисленный массив. Необходимо осуществить циклический
# сдвиг элементов массива влево на три позиции.

test = [1, 2, 3, 4, 5, 6, 7]

answer = test.concat(test.shift(3))
puts answer