require 'pry'
require_relative 'deck'

class Game

  def initialize
    $deck = Deck.new
    @purse = 100
    @wager = 10
    greeting
  end

  def greeting
    puts "Welcome to Blackjack! What is your name, player? "
    @player = gets.chomp.upcase
    puts "------------------------------------------------"
    puts "Welcome #{@player} to a terminal version of the casino-classic, blackjack!"
    puts "You have $#{@purse} to play with. Wager for each hand is set at $10. Good Luck!"
    puts "------------------------------------------------"
    start_game
  end

  def start_game
    clear_game
  end

  def clear_game
    @player_hand = []
    @dealer_hand = []
    @player_face_card = false
    @dealer_face_card = false
    @player_blackjack = false
    @dealer_blackjack = false
    play_or_go?
  end

  def play_or_go?
    puts "Would you like to (p)lay or (c)ash out?"
    @response = gets.chomp[0].downcase
    if @response == "p"
      lets_play
    elsif @response == "c"
      puts "You cash out with $#{@purse}. Come back soon!"
    else
      puts "Not a valid input, please try again"
      play_again?
    end
  end

  def lets_play
    puts "------------------------------------------------"
    puts "Let's Play! You wager $10."
    puts "------------------------------------------------"
    deal_cards
  end

  def deal_cards
    2.times do @player_hand.push($cards.shift)
    end
    2.times do @dealer_hand.push($cards.shift)
    end
    player_value
    dealer_value
    if @player_value == 21
      @player_blackjack = true
    end
    if @dealer_value == 21
      @dealer_blackjack = true
    end
    read_cards
  end

  def player_value
    @player_value = 0
    @player_hand.each do |card|
      if card.rank == "J" || card.rank == "Q" || card.rank == "K"
        @player_face_card = true
        @player_value += 10
      elsif card.rank != "A"
        @player_value += card.rank.to_i
      else
        resolve_ace(@player_hand)
      end
    end
    player_bust?
  end

  def dealer_value
    @dealer_value = 0
    @dealer_hand.each do |card|
      if card.rank == "J" || card.rank == "Q" || card.rank == "K"
        @dealer_face_card = true
        @dealer_value += 10
      elsif card.rank != "A"
        @dealer_value += card.rank.to_i
      else
        resolve_ace(@dealer_hand)
      end
    end
  end

  def player_bust?
    if @player_value > 21
      @purse -= 10
      puts "You BUSTED!"
      puts "You lose $10 and now have $#{@purse} in total"
      start_game
    end
  end

  def resolve_ace(cards)
    cards.each do |card|
      puts "There's an ace in #{cards} hand."
      puts "[#{card.rank}]"
    end
  end

  def read_cards
    puts "Your cards are:"
    @player_hand.each do |card|
      puts "[#{card.rank}]"
    end
    player_blackjack?
    puts "For a total of: #{@player_value}"
    puts "------------------------------------------------"
    puts "Dealer Shows:"
    puts "[#{@dealer_hand[1].rank}][ ]"
    hit_or_stand
  end

  def hit_or_stand
    puts "------------------------------------------------"
    puts "Would you like to hit or stand? "
    @answer = gets.chomp[0].to_s
    if @answer == "h"
      puts "One card incoming!"
      @player_hand.push($cards.shift)
      player_value
      read_cards
    elsif @answer == "s"
      puts "You have chosen to stand at #{@player_value}."
      puts "------------------------------------------------"
      play_dealer_hand
    else
      p "Not a valid input, please try again!"
      puts "------------------------------------------------"
      hit_or_stand
    end
  end

  def play_dealer_hand
    puts "Dealer Cards:"
    @dealer_hand.each do |card|
      p "[#{card.rank}]"
    end
    dealer_blackjack?
    puts "Dealer has #{@dealer_value}"
    puts "------------------------------------------------"
    if @dealer_value < 17
      @dealer_hand.push($cards.shift)
      dealer_value
      puts "Dealer hits."
      play_dealer_hand
    elsif @dealer_value > 21
      dealer_bust
    else
      compare_hands
    end
  end

  def player_blackjack?
    if @player_blackjack
      @purse += 15
      puts "BLACKJACK!!"
      puts "You win $15 and now have $#{@purse} in total."
      puts "------------------------------------------------"
      start_game
    end
  end

  def dealer_blackjack?
    if @dealer_blackjack
      @purse -= 10
      puts "Dealer has blackjack..."
      puts "You lose $10 and now have $#{@purse} in total."
      puts "------------------------------------------------"
      start_game
    end
  end

  def dealer_bust
    @purse += 10
    puts "Dealer busts. You win $10. You now have $#{@purse}."
    puts "------------------------------------------------"
    start_game
  end

  def compare_hands
    if @player_value > @dealer_value
      @purse += 10
      puts "Your #{@player_value} beats the dealer's #{@dealer_value}."
      puts "You win $10 and now have $#{purse} in your stack."
      puts "------------------------------------------------"
      start_game
    elsif @player_value < @dealer_value
      @purse -= 10
      puts "The dealer's #{@dealer_value} beats your #{@player_value}."
      puts "You lose $10 and now have $#{@purse} in your stack."
      puts "------------------------------------------------"
      start_game
    else
      puts "It's a push. You still have $#{@purse} in your stack."
      puts "------------------------------------------------"
      start_game
    end
  end

end

Game.new
