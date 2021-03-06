class Account
  CAPITAL_BASE = 5000 # 起始资金 USDT

  attr_accessor :usdt_balance, :coin_balance, :account_book

  def initialize(account_book)
    self.usdt_balance = CAPITAL_BASE
    self.coin_balance = 0
    self.account_book = account_book
  end

  def buy(strategy)
    # return if usdt_balance <= strategy.last_price.to_f * 1000 * 1.002
    return if usdt_balance <= 500 * 1.002
    amount = (500 / strategy.last_price.to_f).to_i
    self.usdt_balance -= strategy.last_price.to_f * amount * 1.002
    self.coin_balance += amount
    log strategy, "In", amount
  end

  # def sell(strategy)
  #   return if coin_balance <= 1000
  #   cache_coin_balance = coin_balance
  #   self.usdt_balance += strategy.last_price.to_f * coin_balance * 0.998
  #   self.coin_balance -= 1000
  #   log strategy, "Out", cache_coin_balance
  # end

  def clearance(strategy)
    return if coin_balance == 0
    cache_coin_balance = coin_balance
    self.usdt_balance += strategy.last_price.to_f * coin_balance * 0.998
    self.coin_balance = 0
    log strategy, "Out", cache_coin_balance
  end

  def log(strategy, type, count = 1000)
    price = strategy.last_price
    average_price = strategy.average_price
    time = DateTime.strptime(strategy.time,'%s').to_s
    account_book.puts "#{time},#{type},#{average_price.round(5)},#{price},#{count},#{(price * count).round(5)},#{(price * count * 0.002).round(4)},#{usdt_balance.round(5)},#{coin_balance}"

  end

end
