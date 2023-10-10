require './lib/turn'
require './lib/card'

RSpec.describe Turn do
    it 'exists' do
      turn = Turn.new("Juneau", Card)
  
      expect(turn).to be_instance_of(Turn)
    end

    it 'has a string' do
        turn = Turn.new("Juneau", Card)
    
        expect(turn.string).to eq("Juneau")
      end

      it 'has a card' do
        turn = Turn.new("Juneau", Card)
    
        expect(turn.card).to eq(Card)
      end

    it 'has a guess' do
        turn = Turn.new("Juneau", Card)
        expect(turn.guess).to eq(turn.string)
    end

    it 'is correct' do
        card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
        turn = Turn.new("Juneau", Card)
        expect(turn.guess).to eq(card.answer)

    end

    it 'has correct feedback' do
        card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
        turn = Turn.new("Juneau", card)
        expect(turn.feedback).to eq("Correct!") 
    end

    it 'has incorrect feedback' do
        card = Card.new("Which planet is closest to the sun?", "Mercury", :STEM)
        turn = Turn.new("Saturn", card)
        expect(turn.feedback).to eq("Incorrect.") 
    end

end