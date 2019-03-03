require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  matching_character = response_hash["results"].find {|response_character|
    character == response_character["name"].downcase
  }
  film_endpoints = matching_character["films"]
  binding.pry
  films = JSON.parse(film_endpoints.map {|endpoint|
    RestClient.get(endpoint)
  })
  get_names_from_endpoints(films)
end

def get_names_from_endpoints(film_endpoints)
  film_endpoints.map {|film|
    film["results"].first["name"]
  }
end

def print_movies(film_names)
  film_names.each {|name|
    puts "* #{name}"
  }
end

def show_character_movies(character)
  films_names = get_character_movies_from_api(character)
  print_movies(films_names)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
