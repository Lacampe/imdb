require "open-uri"
require "nokogiri"

def fetch_movie_urls
  url = "https://www.imdb.com/chart/top"
  serialized_url = open(url).read
  document = Nokogiri::HTML(serialized_url)
  movies = document.search(".titleColumn a").first(5)
  movies.map do |movie|
    uri = URI::parse(movie.attributes['href'].value)
    uri.host = 'www.imdb.com'
    uri.scheme = 'https'
    uri.to_s
  end
end


def scrape_movie(url)
  serialized_url = open(url).read
  document = Nokogiri::HTML(serialized_url)
  movie = {}
  title_and_year = document.search("h1").text.strip.match /(?<title>.*)[[:space:]]\((?<year>\d{4})\)/
  movie[:title] = title_and_year[:title]
  movie[:year] = title_and_year[:year]
  director = document.search("[itemprop='director']").text.strip
  movie[:director] = director
  return movie
end


