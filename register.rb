class Register

  attr_accessor :denominations

  def initialize(coins = {})
    @denominations = coins
  end

  def change_given(change)
    result = {}
    denominations.each do |coin_value, quantity|
      coins_needed = (change / coin_value).floor
      if quantity >= coins_needed
        result[coin_value] = coins_needed
        denominations[coin_value] -= coins_needed
        change = change % coin_value
      else
        result[coin_value] = denominations[coin_value]
        denominations[coin_value] = 0
        qty_of_coins_needed = coins_needed - result[coin_value]
        change = (change % coin_value) + (qty_of_coins_needed*coin_value)
      end
    end
    result.reject { |k,v| v == 0 }
  end

  def transaction(balance, payment)
    change_given(payment - balance)
  end

end