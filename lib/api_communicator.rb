require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  matching_character = find_matching_character(character)
  film_endpoints = matching_character["films"]
  films = film_endpoints.map {|endpoint| get_endpoint(endpoint)}
  get_names_from_endpoints(films)
end

def characters
  get_endpoint('http://www.swapi.co/api/people/')["results"]
end

def find_matching_character character
  characters.find {|response_character|
    character == response_character["name"].downcase
  }
end

def get_endpoint endpoint
  response = RestClient.get(endpoint)
  JSON.parse(response)
end

def get_names_from_endpoints(films)
  films.map {|film| film["title"]}
end

def print_movies(film_names)
  film_names.each {|name| puts "* #{name}"}
end

def show_character_movies(character)
  films_names = get_character_movies_from_api(character)
  print_movies(films_names)
end
