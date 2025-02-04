require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end

  def score
    @grid = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included_in_grid?(@word, @grid)
    if @included
      @english_word = check_word?(@word)
    end
    # raise
  end

  # Taken from previous class
  # https://github.com/awinata/fullstack-challenges/blob/master/01-Ruby/06-Parsing/02-Numbers-and-Letters/lib/longest_word.rb
  def generate_grid(grid_size)
    letters = ("A".."Z").to_a
    samples = []
    (1..grid_size).to_a.each do
      samples << letters.sample
    end
    return samples
  end

  def check_word?(attempt)
    url = "https://dictionary.lewagon.com/#{attempt}"
    output = JSON.parse(URI.parse(url).read)
    return output["found"]
  end

  def included_in_grid?(attempt, grid)
    attempt.chars.all? { |char| attempt.count(char) <= grid.count(char) }
  end
end
