require "thor"
require "pry"

class Drink
  attr_reader :name, :price
  def initialize(name, price)
    @name = name
    @price = price
  end

  def self.water
    self.new( 'water',100 )
  end

  def self.cola
    self.new( 'cola', 120 )
  end

  def self.redbull
    self.new( 'redbull', 200)
  end
end

class VendingMachine
  attr_reader :total_money, :sale_amount, :stocks
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @total_money = 0
    @sale_amount = 0
    @stocks = {cola: 5, water: 5, redbull: 5}
    @drinks = [Drink.cola, Drink.water, Drink.redbull]

  end

  def insert(money)   
    if MONEY.include?(money)
      @total_money += money 
    end
  end

  def buy(drink)
    @total_money -= drink.price
    @stocks[drink.name.to_sym] -= 1
    @sale_amount += drink.price
  end    

  def return_money
    @total_money = 0    
  end 

  def purchasable?(drink)
    @total_money >= drink.price && @stocks[drink.name.to_sym] > 0 
  end

  def purchasable_drink_list
    @drinks.each do |drink|
      if purchasable?(drink)
        puts "#{drink.name}を買えます"
      else
        puts "#{drink.name}を買えません"
      end
    end
  end

  def store(drink, num)
    @stocks[drink.name.to_sym] += num 
  end
end

vm = VendingMachine.new
vm.insert(100)
vm.purchasable_drink_list