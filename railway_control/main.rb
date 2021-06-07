# frozen_string_literal: true

require './menu'

puts 'Это программа управления ж/д сообщением'

menu = Menu.new

answer = ''
while answer.downcase != 'стоп'
  answer = menu.menu
  break if answer.downcase == 'стоп'

  menu.sub_menu(answer)
end
