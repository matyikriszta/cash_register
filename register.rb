class Register

  def denominations
    [2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01]
  end

  def change_given(value)
    result = {}
    denominations.each do |d|
      result[d] = (value / d).floor
      value = value % d
    end
    result.reject { |k,v| v == 0 }
  end

  def transaction(balance, payment)
    change_given(payment - balance)
  end

end