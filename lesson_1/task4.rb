puts 'Коэффициент 1?'
a = gets.chomp

puts 'Коэффициент 2?'
b = gets.chomp

puts 'Коэффициент 3?'
c = gets.chomp

d = b.to_i**2 - 4 * a.to_i * c.to_i

puts "Дискриминант равен #{d}"

if d.negative?
  puts 'Корней нет'
elsif d.positive?
  puts 'Имеет 2 корня'
else
  d.zero?
  puts 'Имеет 1 корень'
end
