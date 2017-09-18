class Card
  RANK = [:A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K]
  SUIT = [:hearts, :spades, :diamonds, :clubs]

  attr_reader :rank, :suit

  def initialize (rank, suit)
    @rank = rank
    @suit = suit
  end

  def greater_than? (card)
    RANK.index(self.rank) > RANK.index(card.rank)
  end

  def ==(other)
    self.rank == other.rank && self.suit == other.suit
  end

end
