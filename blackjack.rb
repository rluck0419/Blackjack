class Deck
  def initialize
    @cards = []
  end

  def make_deck
    #... snip
    suits = [:hearts, :diamonds, :spades, :clubs]
    suits.each do |suit|
      (2..14).each do |value|
        @cards << Card.new(suit, value)
      end
    end
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

class Hand
  attr_accessor :cards_in_hand

  def initialize
    @cards_in_hand = []
    @total = 0
  end

  def add_to_hand(dealt_card)
    @cards_in_hand.push(dealt_card)
  end

  def calc_total
    @cards_in_hand.map do |value|
      if value.to_i > 10
        if value.to_i == 14
          value = 11
        else
          value = 10
        end
      end
      @total += value.to_i
    end
    @total
  end
end

class Player
end

class Dealer
end

deck = Deck.new
deck.make_deck
deck.shuffle_cards
puts "shuffled deck: #{deck.display_deck}"
puts
player = Hand.new
dealer = Hand.new

player.add_to_hand(deck.deal_card)
dealer.add_to_hand(deck.deal_card)
player.add_to_hand(deck.deal_card)
dealer.add_to_hand(deck.deal_card)

puts "Remaining in deck:"
puts deck.display_deck
puts
puts "Player hand:"
puts player.cards_in_hand
puts
puts "Dealer hand:"
puts dealer.cards_in_hand
puts

puts player.calc_total
puts dealer.calc_total
