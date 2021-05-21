months = {
  jan: 31,
  feb: 28,
  march: 31,
  april: 30,
  may: 31,
  june: 30,
  july: 31,
  aug: 31,
  sep: 30,
  oct: 31,
  nov: 30,
  dec: 31,
}

months.each do |month, days_count|
  puts month if days_count == 30
end
