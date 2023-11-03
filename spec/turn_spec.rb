require 'spec_helper'

RSpec.describe Turn do
  it 'exists' do
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    turn = Turn.new("Juneau", card)

    expect(turn).to be_instance_of(Turn)
    expect(turn.guess).to eq("Juneau")
    expect(turn.card).to eq(card)
  end

  it 'is correct' do
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    turn = Turn.new("Juneau", card)

    expect(turn.correct?).to eq(true)

    turn = Turn.new("Denver", card)

    expect(turn.correct?).to eq(false)
  end

  it 'gives feedback' do
    card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    turn = Turn.new("Juneau", card)

    expect(turn.feedback).to eq("Correct!") 

    turn = Turn.new("Denver", card)

    expect(turn.feedback).to eq("Incorrect.") 
  end

end