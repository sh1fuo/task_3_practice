module ConsoleInput
  def self.get_input(prompt)
    print prompt
    gets.chomp  # Зчитує введення користувача з консолі та видаляє символ нового рядка
  end

  def self.get_integer_input(prompt)
    loop do
      print prompt
      input = gets.chomp

      begin
        return Integer(input)  # Перетворює введене значення на ціле число
      rescue ArgumentError
        puts "Invalid input. Please enter an integer."  # Виводить повідомлення про некоректне введення
      end
    end
  end

  def self.get_float_input(prompt)
    loop do
      print prompt
      input = gets.chomp

      begin
        return Float(input)  # Перетворює введене значення на число з плаваючою комою
      rescue ArgumentError
        puts "Invalid input. Please enter a float."  # Виводить повідомлення про некоректне введення
      end
    end
  end
end
