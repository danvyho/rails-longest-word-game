require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def find_word(word)
    url = "https://dictionary.lewagon.com/#{word}"
    word_dictionary = URI.parse(url).read
    parsed = JSON.parse(word_dictionary)
    parsed['found']
  end

  def valid_word(word, array)
    word.chars.all? { |letter| word.count(letter) <= array.to_s.count(letter) }
  end

  def score
    @word = params[:word]
    @letter =params[:letter]
    @answer = "Congrats! #{@word} is a valid English word! "
    if find_word(@word) == false
      @answer = "Sorry but #{@word} does not seem to be a valid English Word..."
    elsif valid_word(@word, @letters) == false
      @answer = "Sorry but #{@word} can't be built out of #{@letters}"
    end
  end
end
