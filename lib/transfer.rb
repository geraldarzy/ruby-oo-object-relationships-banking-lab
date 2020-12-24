require "pry"

class Transfer
  # your code here

  attr_accessor :sender, :receiver, :amount, :status, :count
  

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @count = 0

  end

  def valid? #checks if both accounts are valid with bank_account.valid?
    @sender.valid? && @receiver.valid?

  end

  def execute_transaction
    if self.status == "pending" && valid? && @sender.balance > @amount
      update_sender
      update_receiver
      self.status = "complete"
    else
      rejection
      
    end
  end

  def rejection
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end

  def update_sender
    self.sender.balance = self.sender.balance - self.amount
  end
  
  def update_receiver
    self.receiver.balance += self.amount
  end

  def reverse_sender
    self.sender.balance += self.amount
  end
  
  def reverse_receiver
    self.receiver.balance -= self.amount
  end

  def reverse_transfer
    if self.status == "complete"
      reverse_sender
      reverse_receiver
      self.status = "reversed"
    end
  end
end
