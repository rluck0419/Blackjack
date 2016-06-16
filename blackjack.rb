### todo
# - create a class to hold deck
#   - 52 cards, 4 suits - cards range from 2-10, also J, Q, K (10), and A (11)
# - create a class to represent each card
# - create a game class to play the game
# - player class?
class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def display_card
    # # convert values to string representations (A, K, Q, & J)
    # if @value > 13
    #   @value = 'A'
    # elsif @value == 11
    #   @value = 'J'
    # elsif @value == 12
    #   @value = 'Q'
    # elsif @value == 13
    #   @value = 'K'
    # else
    # end
    "#{@value} of #{@suit}"
  end
end

class Deck
  def initialize
    @cards = []
    #... snip
    suits = [:hearts, :diamonds, :spades, :clubs]
    suits.each do |suit|
      (2..14).each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def count
    @cards.count
  end

  def shuffle_cards
    @cards.shuffle!
  end

  def deal_card
    @cards.shift.display_card
  end

  def display_deck
    @cards.map do |card|
      card.display_card
    end
  end
end

class Hand
  attr_accessor :cards_in_hand

  def initialize
    @cards_in_hand = []
    # @total = 0
  end

  def add_to_hand(dealt_card)
    @cards_in_hand.push(dealt_card)
  end

  def calc_total
    total = 0
    @cards_in_hand.map do |value|
      if value.to_i > 10
        if value.to_i == 14
          value = 11
        else
          value = 10
        end
      end
      total += value.to_i
    end
    total
  end
end

# Not super necessary - keep track of wins, etc.
# class Player
# end
#
# class Dealer
# end

class Game
  def get_player_input
    puts "Would you like to hit or stay?"
    print "<Please enter 'h' or 's'>: "
    player_input = gets.chomp.upcase
  end

  def card_corrector(cards)
    cards.each do |card|
      if card[0..1].to_i > 10
        card_strings = card.split
        if card_strings[0] == "11"
          card_strings[0] = "J"
        elsif card_strings[0] == "12"
          card_strings[0] = "Q"
        elsif card_strings[0] == "13"
          card_strings[0] = "K"
        else card_strings[0] = "A"
        end
        card = card_strings.join(" ")
      end
      puts card
    end
  end

  def play
    deck = Deck.new
    deck.shuffle_cards

    player = Hand.new
    dealer = Hand.new

    2.times do
      player.add_to_hand(deck.deal_card)
      dealer.add_to_hand(deck.deal_card)
    end

    puts "Player hand:"
    puts player.cards_in_hand
    puts
    puts "Dealer hand:"
    puts "unknown"
    puts dealer.cards_in_hand[1]
    puts
    puts "Cards remaining in deck: #{deck.count}"
    puts "Player's total: #{player.calc_total}"
    puts

    # check if player/dealer wins on draw (or busts - aces are always high)
    if player.calc_total == 21
      puts "Blackjack! You win!"
    elsif player.calc_total > 21
      puts "Bust! Dealer wins!"
    elsif dealer.calc_total == 21
      puts "Dealer has Blackjack! Sorry, you lose!"
    elsif dealer.calc_total > 21
      puts "Dealer busts! You win!"
    else
      time_to_break = false
      # loop to let player "hit" (draw card) infinitely until:, "blackjack", or "bust"
      #   - user chooses to stop (stay)
      #   - user has 21 (stay)
      #   - user has over 21 (bust)
      loop do
        if time_to_break
          break
        elsif player.calc_total < 21
          hit_or_stay = get_player_input
          # hit if the player_input == H
          if hit_or_stay == "H"
            player.add_to_hand(deck.deal_card)
          elsif hit_or_stay == "S"
            time_to_break = true
          else puts "Sorry? Please try again."
          end
        elsif player.calc_total == 21
          puts "Blackjack! You win!"
          break
        else
          puts "Bust! Dealer wins!"
          break
        end
        puts "Player's total: #{player.calc_total}"
        puts
      end

      # loop to finish dealer hand based on their total
      if player.calc_total < 21
        loop do
          if dealer.calc_total < 16
            dealer.add_to_hand(deck.deal_card)
          elsif dealer.calc_total < 21
            break
          elsif dealer.calc_total == 21
            puts "Dealer has Blackjack! Sorry, you lose!"
            break
          else
            puts "Dealer busts! You win!"
            break
          end
        end
      end

      puts
      puts "Player's hand: #{player.cards_in_hand}"
      card_corrector(player.cards_in_hand)
      puts
      puts "Dealer's hand: #{dealer.cards_in_hand}"
      card_corrector(dealer.cards_in_hand)
      puts
      puts "Player's total: #{player.calc_total}"
      puts "Dealer's total: #{dealer.calc_total}"
      puts

      # check results
      if dealer.calc_total < 21 && player.calc_total < 21
        if player.calc_total < dealer.calc_total
          puts "Sorry, you lose!"
        elsif player.calc_total > dealer.calc_total
          puts "You win!"
        else
          puts "Bust! How boring!"
        end
      end
    end
  end
end

Game.new.play
