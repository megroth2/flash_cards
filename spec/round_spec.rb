require 'spec_helper'

RSpec.describe Round do
  before(:each) do
    @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?", "North north west", :STEM)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @round = Round.new(@deck)
  end

  it 'exists' do
    expect(@round).to be_a(Round)
    expect(@round.deck).to eq(@deck)
    expect(@round.turns).to eq([])
    expect(@round.current_card).to eq(@card_1)
  end

  it 'tracks turn categories' do
    @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.turn_categories).to eq([:Geography, :STEM])
  end

  it 'inceases current card count' do
    expect(@round.current_card_count).to eq(0)
    expect(@round.current_card).to eq(@card_1)

    @round.increase_current_card_count
    
    expect(@round.current_card_count).to eq(1)
    expect(@round.current_card).to eq(@card_2)
  end

  it 'increases number correct' do
    expect(@round.number_correct).to eq(0)

    new_turn = @round.take_turn("Juneau")

    expect(new_turn.correct?).to eq(true)
    expect(@round.number_correct).to eq(1)

    @round.take_turn("Venus")

    expect(@round.turns.last.feedback).to eq("Incorrect.")
    expect(@round.number_correct).to eq(1)
  end

  it 'takes turns' do
    new_turn = @round.take_turn("Juneau")

    expect(new_turn.class).to eq(Turn)
    expect(@round.turns).to eq([new_turn])
    expect(@round.current_card).to eq(@card_2)

    @round.take_turn("Venus")

    expect(@round.turns.count).to eq(2)
  end
  
  it 'can count number correct_by_category' do
    new_turn = @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.number_correct_by_category(:Geography)).to eq(1)
    expect(@round.number_correct_by_category(:STEM)).to eq(0)
  end 

  it 'returns percent correct' do
    new_turn = @round.take_turn("Juneau")

    expect(@round.number_correct).to eq(1)
    expect(@round.turns.count).to eq(1)
    expect(@round.percent_correct).to eq(100)

    @round.take_turn("Venus")

    expect(@round.number_correct).to eq(1)
    expect(@round.turns.count).to eq(2)
    expect(@round.percent_correct).to eq(50)

    expect(@round.percent_correct_by_category(:Geography)).to eq(100)
    expect(@round.current_card).to eq(@card_3)
  end

  it 'returns percent correct by category' do
    new_turn = @round.take_turn("Juneau")
    @round.take_turn("Venus")

    expect(@round.percent_correct_by_category(:Geography)).to eq(100)
    expect(@round.current_card).to eq(@card_3)
  end

end