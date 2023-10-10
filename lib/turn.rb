class Turn
    attr_reader :string, :card

    def initialize(string, card)
      @string = string
      @card = card
    end
    
    def guess
        @string
    end

    def correct?
        guess == card.answer
    end

    def feedback
        if correct? == true
            "Correct!"
        else
            "Incorrect."
        end
    end

end