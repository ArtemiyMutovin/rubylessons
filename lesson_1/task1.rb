puts 'Твое имя?'

name = gets.chomp

puts "Привет #{name},какой твой рост?"

height = gets.chomp

puts "Дорогой #{name}!Твой вес составляет #{(height.to_i - 100) * 1.15}кг"

puts 'Твой вес является оптимальным' if ((height.to_i - 100) * 1.15).negative?
