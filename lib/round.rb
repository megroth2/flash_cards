class Round
  attr_reader :deck,
              :current_card_count,
              :current_card,
              :turns,
              :turn_categories,
              :number_correct

  def initialize(deck)
    @deck = deck
    @current_card_count = 0
    @current_card = deck.cards[@current_card_count]
    @turns = []
    @turn_categories = []
    @number_correct = 0
  end

  # Not tested because of puts
  def start
    puts "Welcome! You're playing with #{deck.cards.count} cards."
    puts "-------------------------------------------------"
    next_card
    puts "****** Game over! ******"
    puts "You had #{number_correct} correct guesses out of #{turns.count} for a total score of #{percent_correct}%."
    list_category_breakdown
  end

  # Not tested because of puts
  def list_category_breakdown
    @turn_categories.each do |category|
      puts "#{category} - #{percent_correct_by_category(category)}% correct"
    end
  end

  # Not tested because of puts
  def next_card
    until turns.count == deck.cards.count
      card_number = current_card_count + 1
      puts "This is card number #{card_number} out of #{deck.cards.count}."
      puts "Question: #{current_card.question}"

      response = gets.chomp
      take_turn(response)

      puts @turns.last.feedback
    end
  end

  def track_turn_categories
    @turn_categories << @current_card.category if !@turn_categories.include?(@current_card.category)
  end

  def increase_current_card_count
    @current_card_count += 1
    @current_card = deck.cards[@current_card_count]
  end

  def increase_number_correct
    @number_correct += 1 if @current_turn.correct?
  end

  def take_turn(guess)
    @current_turn = Turn.new(guess, current_card)
    turns << @current_turn
    
    track_turn_categories
    increase_current_card_count
    increase_number_correct

    @current_turn
  end

  def number_correct_by_category(category)
    @correct_turns = @turns.select do |turn|
      turn.feedback == "Correct!" && turn.card.category == category
    end
    @correct_turns.count
  end

  def percent_correct
    (@number_correct.to_f / @turns.count.to_f) * 100
  end

  def percent_correct_by_category(category)
    (number_correct_by_category(category) / deck.cards_in_category(category).count) * 100
  end

end