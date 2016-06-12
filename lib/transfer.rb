require "pry"

class Transfer
  attr_accessor :status, :amount, :sender, :receiver
  @@all = []

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @sender_balance = sender.balance
    @receiver_balance = receiver.balance
    @amount = amount
  end

  def valid?
    ((sender.balance - amount) > 0) && (sender.valid? && receiver.valid?) && status == "pending"
  end

  def self.all
    @@all
  end

  def execute_transaction
    if valid?
      sender.balance -= @amount
      receiver.balance += @amount
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if status == "complete"
      sender.balance += amount
      receiver.balance -= amount
      @status = "reversed"
    end
  end
end
