# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'net/http'
require 'json'
require 'uri'

puts 'Delete all movies'
Movie.destroy_all

uri_movies = URI('https://tmdb.lewagon.com/movie/top_rated')
response_movies = Net::HTTP.get_response(uri_movies)
results_movies = JSON.parse(response_movies.body)['results']

config_uri = URI('https://tmdb.lewagon.com/configuration')
response_config = Net::HTTP.get_response(config_uri)
results_config = JSON.parse(response_config.body)

base_url = results_config['images']['base_url']
poster_size = results_config['images']['poster_sizes'][4] # 'w500'

results_movies.each do |movie|
  title = movie['title']
  overview = movie['overview']
  poster_url = "#{base_url}#{poster_size}#{movie['poster_path']}"
  rating = movie['vote_average']
  puts "Create movie : #{title}"
  Movie.create(title: title, overview: overview, poster_url: poster_url, rating: rating)
end

puts 'All seeds loaded'
# Movie.create(title: 'Wonder Woman 1984',
#              overview: 'Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s',
#              poster_url: 'https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg',
#              rating: 6.9)
# Movie.create(title: 'The Shawshank Redemption',
#              overview: 'Framed in the 1940s for double murder,
#               upstanding banker Andy Dufresne begins a new life at the Shawshank prison',
#              poster_url: 'https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
#              rating: 8.7)
# Movie.create(title: 'Titanic',
#              overview: '101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.',
#              poster_url: 'https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg',
#              rating: 7.9)
# Movie.create(title: "Ocean's Eight",
#              overview: 'Debbie Ocean, a criminal mastermind,
#               gathers a crew of female thieves to pull off the heist of the century.',
#              poster_url: 'https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg',
#              rating: 7.0)
