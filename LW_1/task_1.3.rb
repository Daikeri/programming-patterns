puts "Введи команду для Ruby"
cmd_ruby = gets.chomp
system "ruby -e \"#{cmd_ruby}\""
puts ''
puts "Введите команду для вашей OS"
cmd_os = gets.chomp
system cmd_os

