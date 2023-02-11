
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

test = Array.new(20) do
  rand(-100..100)
end

puts "Source array:#{test}"
puts "min = #{min test}"
puts "first positive = #{first_pos test}"
