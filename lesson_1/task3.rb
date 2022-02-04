puts 'Чему равна сторона 1?'
a = gets.chomp

puts 'Чему равна сторона 2?'
b = gets.chomp

puts 'Чему равна сторона 3?'
c = gets.chomp

if c.to_i**2 == a.to_i**2 + b.to_i**2
  puts 'Треугольник является прямоугольным'
elsif a.to_i == b.to_i && b.to_i != c.to_i
  puts 'Треугольник является равнобедренным'
else
  a.to_i == b.to_i || b.to_i == c.to_i
  puts 'Тругольник является равносторонним'
end
