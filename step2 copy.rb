class Card
  attr_reader :shapes, :number
  def initialize(shapes, number)
    @shapes = shapes
    @number = number
  end
end

class Carddeck
  attr_reader :carddeck
  def initialize()
    @carddeck = []
    for s in ['ハート', 'スペード', 'ダイヤ', 'クラブ']
      for n in [*1..13]
        card = Card.new(s, n)
        @carddeck.push(card)
      end
    end
  end

  def shuffle
    @carddeck.shuffle
  end

  def deal
    @carddeck.shift
  end
end

class User
  attr_reader :cards
  def initialize
    @cards = []
  end

  def getcard(card)
    @cards.push(card)
  end

  def draw
    @cards.shift
  end
#   cards.group_by.each_with_index {|card, i| i % 2 }.values
# p cards
end

class Game
  attr_reader :deck, :user1, :user2, :stock_user1, :stock_user2
  def initialize
    # カードデッキをここで作成
    @deck = Carddeck.new
    @user1 = User.new
    @user2 = User.new
    @stock_user1 = []
    @stock_user2 = []
  end

  def run
    p '戦争を開始します。'
    @deck.shuffle
    for i in 1..26
      @user1.getcard(@deck.deal)
      @user2.getcard(@deck.deal)
    end
    p 'カードが配られました。'
    while (@user1.cards.count && @user2.cards.count) > 0 do
      while
        p '戦争！'
        card1 = @user1.draw
        card2 = @user2.draw
  # card.numberを比較する際に使用したい。そのため、card.numberを上書きさせないために、文字に変換する数字の場合は、numberに代入する。
  ## card2で、1,11以降を文字に変換
        if card2.number == 11
          number2 = 'J'
        elsif card2.number == 12
          number2 = 'Q'
        elsif card2.number == 13
          number2 = 'K'
        elsif card2.number == 1
          number2 = 'A'
        else
          number2 = card2.number
        end
  ## card1で、1,11以降を文字に変換
        if card1.number == 11
          number1 = 'J'
        elsif card1.number == 12
          number1 = 'Q'
        elsif card1.number == 13
          number1 = 'K'
        elsif card1.number == 1
          number1 = 'A'
        else
          number1 = card1.number
        end
    # カードの形と数値
        p "プレイヤー1のカードは、#{card1.shapes}の#{number1}です。"

        p "プレイヤー2のカードは、#{card2.shapes}の#{number2}です。"
    # 場合分け
        if card1.number > card2.number
          if card2.number == 1
            p 'プレイヤー2が勝ちました。'
            @stock_user2.push(card1)
            @stock_user2.push(card2)
          else
            p 'プレイヤー1が勝ちました。'
            @stock_user1.push(card1)
            @stock_user1.push(card2)
          end

          break
        elsif card1.number == card2.number
          p '引き分けです。'

        else
          if card1.number == 1
            p 'プレイヤー1が勝ちました。'
            @stock_user1.push(card1)
            @stock_user1.push(card2)
          else
            p 'プレイヤー2が勝ちました。'
            @stock_user2.push(card1)
            @stock_user2.push(card2)
          end
          break
        end
      end
    end

    if @user1.cards.count == 0
      p 'プレイヤー1の手札がなくなりました。'
    else
      p 'プレイヤー2の手札がなくなりました。'
    end

    user1_sum = @user1.cards.count + @stock_user1.count
    user2_sum = @user2.cards.count + @stock_user2.count
    p "プレイヤー1の手札の枚数は#{ user1_sum }枚です。プレイヤー2の手札の枚数は#{ user2_sum
    }枚です。"

    if user1_sum > user2_sum
      p 'プレイヤー1が1位、プレイヤー2が2位です。'
    else
      p 'プレイヤー1が2位、プレイヤー2が1位です。'
    end
    p '戦争を終了します。'
  end
end
game = Game.new
game.run
