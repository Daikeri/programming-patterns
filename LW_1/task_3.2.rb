if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

def min(source_arr)
  m = source_arr[0]
  source_arr.each { |i| m = i if i < m }
  m
end

def first_pos(source_arr)
  n = source_arr.size
  for ind in 0..n do
    return ind if source_arr[ind] > 0
  end
end

puts 'Укажите номер необходимой функции, а также путь к файлу с массивом'
func, path = gets.chomp.split(' ')

file_info = File.new path
arr = file_info.gets.chomp.split(' ')
arr.map! { |el| el.to_i }


case  func
when '1'
  puts "Минимальный элемент:#{min arr}"
when '2'
  puts "Индекс первого положительного элемента:#{first_pos arr}"
  else puts 'Указанная функция не найдена'
end