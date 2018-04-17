require_relative './scraper'
require "yaml"

puts "Fetching URLs..."
urls = fetch_movie_urls

puts "Scraping movies..."
movies =  urls.map do |url|
            scrape_movie(url)
          end

puts "Writing to movies.yml"

File.open("movies.yml", "wb") do |file|
  file.write(movies.to_yaml)
end
