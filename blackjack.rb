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
class Player
end
#
# class Dealer
# end

class Game
  def play
    deck = Deck.new
    deck.shuffle_cards

    player = Hand.new
    dealer = Hand.new

    # puts "Initial deck (shuffled):"
    # puts deck.display_deck
    # puts

    player.add_to_hand(deck.deal_card)
    dealer.add_to_hand(deck.deal_card)
    player.add_to_hand(deck.deal_card)
    dealer.add_to_hand(deck.deal_card)

    # puts "Remaining in deck:"
    # puts deck.display_deck
    # puts
    puts "Player hand:"
    puts player.cards_in_hand
    puts
    puts "Dealer hand:"
    puts dealer.cards_in_hand[0]
    puts "unknown"
    puts

    puts "Cards remaining in deck: #{deck.count}"

    puts "Player's total: #{player.calc_total}"
    # puts "dealer total: #{dealer.calc_total}"
    # todo - check for dealer having blackjack too
    if player.calc_total == 21
      puts "Blackjack! Player wins"
    elsif player.calc_total < 21
      puts "Would you like to hit or stay?"
      print "<Please enter 'h' or 's':> "
      hit_or_stay = gets.chomp.upcase
      puts
      if hit_or_stay == 'H'
        # draw another card
        player.add_to_hand(deck.deal_card)
        puts "Players current hand:"
        puts player.cards_in_hand[0]
        puts player.cards_in_hand[1]
        puts player.cards_in_hand[2]
        puts
        puts "player total: #{player.calc_total}"

        if player.calc_total > 21
          puts "Bust! Dealer wins."
        elsif player.calc_total == 21
          puts "Blackjack! Player wins."
        else
          # let dealer finish
          if dealer.calc_total < 16
            puts
            puts "dealer hits:"
            dealer.add_to_hand(deck.deal_card)
            puts dealer.cards_in_hand[2]
            puts "dealer total: #{dealer.calc_total}"
          elsif dealer.calc_total < 21
            puts "dealer total: #{dealer.calc_total}"
            if dealer.calc_total < player.calc_total
              puts "Player's #{player.calc_total} beats the dealer's #{dealer.calc_total}. You win!"
              puts
            elsif dealer.calc_total > player.calc_total && player.calc_total < 22
              puts "Sorry, the dealer's #{dealer.calc_total} beats player's #{player.calc_total}. You lose!"
              puts
            else
              puts "Push! Player's #{player.calc_total} ties the dealer's #{dealer.calc_total}. Boring!"
              puts
            end
          elsif dealer.calc_total == 21
            puts "Dealer has Blackjack! Sorry, you lose!"
          else
            puts "Dealer busts! You win!"
          end
        end

      elsif hit_or_stay == "S"
        puts "player total: #{player.calc_total}"

        # let dealer finish
        if dealer.calc_total < 16
          dealer.add_to_hand(deck.deal_card)
          puts "dealer total: #{dealer.calc_total}"
        elsif dealer.calc_total < 21
          puts "dealer total: #{dealer.calc_total}"
          if dealer.calc_total < player.calc_total
            puts "Player's #{player.calc_total} beats the dealer's #{dealer.calc_total}. You win!"
            puts
          elsif dealer.calc_total > player.calc_total && player.calc_total < 22
            puts "Sorry, the dealer's #{dealer.calc_total} beats player's #{player.calc_total}. You lose!"
            puts
          else
            puts "Push! Player's #{player.calc_total} ties the dealer's #{dealer.calc_total}. Boring!"
            puts
          end
        elsif dealer.calc_total == 21
          puts "Dealer has Blackjack! Sorry, you lose!"
        else
          puts "Dealer busts! You win!"
        end

      else
        puts "Sorry? We're going to need to start over."
      end
    else
      puts "Bust! Dealer wins."
    end
  end
end

Game.new.play
