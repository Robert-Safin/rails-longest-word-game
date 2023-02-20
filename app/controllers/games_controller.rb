require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    alphabet = ('a'..'z').to_a
    @letters = []
    10.times do
      @letters << alphabet.sample
    end

  end

  def score
    @word = params[:word]
    @letters = params[:letters]

    #check if word is in the grid
    @word_array = @word.split("")
    @letters_array = @letters.split("")

    @word_array.each do |letter|
      if @letters_array.include?(letter)
        @letters_array.delete_at(@letters_array.index(letter))
      else
        @message = "Sorry but #{@word} can't be built out of #{@letters}"
        return
      end
    end

    #check if word is an english word
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    @json = JSON.parse(URI.open(url).read)
    if @json["found"]
      @message = "Congratulations! #{@word} is a valid English word!"
    else
      @message = "Sorry but #{@word} does not seem to be a valid English word..."
    end
  end
end
