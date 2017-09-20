require 'pry'
require_relative 'deck'

class Game

  def initialize
    $deck = Deck.new
    @purse = 100
    deal_cards
    start_game
  end

  def start_game
    print "Welcome to Blackjack! What is your name, player? "
    @player = gets.chomp
    puts "Welcome #{@player} to a terminal version of the casino-classic, blackjack!"
    puts "You have $#{@purse} to play with. Good Luck!"
    set_wager
  end

  def set_wager
    print "What is your wager? $"
    @wager = gets.chomp.to_i
    read_cards
  end

  def read_cards
    player_value
    p "Your Cards:"
    @player_hand.each do |card|
      puts "[#{card.rank}]"
    end
    p "For a total of: #{@value}"
    p "Dealer Cards:"
    p "[#{@dealer_hand[1].rank}]"
    p "[ ]"
    hit_or_stand
  end

  def player_value
    @value = 0
    @player_hand.each do |card|
      if card.rank == "J" || card.rank == "Q" || card.rank == "K"
        @value += 10
      elsif card.rank != "A"
        @value += card.rank.to_i
      else
        resolve_ace 
      end
    end
  end

  def resolve_ace
  end

  def hit_or_stand
    player_value
    p "Would you like to hit or stand? "
    @answer = gets.chomp[0].to_s
    if @answer == "h"
      p "One card incoming!"
      @player_hand.push($cards.shift)
      read_cards
    elsif @answer == "s"
      p "You have chosen to stand"
      play_dealer_hand
    else
      p "Not a valid input, please try again"
      hit_or_stand
    end
  end

  def play_dealer_hand
  end

  def deal_cards
    @player_hand = []
    @dealer_hand = []
    2.times do @player_hand.push($cards.shift)
    end
    2.times do @dealer_hand.push($cards.shift)
    end
  end

end

Game.new
