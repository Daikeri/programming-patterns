
if (Gem.win_platform?)
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

# штучка сверху для корректной работы с русским языком

puts "Представтесь, пожалуйста."
user_name = gets
exit if user_name.nil? or user_name.empty?
user_name.chomp!
print "Здравствуйте, #{user_name}!\n"

puts "Какой ваш любимый ЯП?"
answer = gets
exit if answer.nil? or answer.empty?
answer.chomp!

case answer
when "Ruby"
  puts "Подлиза конкретная"
when "Python"
  puts "Ну тут вся понятно, жуйка"
when "Dart"
  puts "Ага, мобилки"
else
  puts "Не знаю, что это за язык, но это не имеет значение, ибо Ruby - твое будущее"
end

