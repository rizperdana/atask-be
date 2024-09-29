class Wallet < ApplicationRecord
  belongs_to :walletable, polymorphic: true
  has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'
  has_many :source_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'

  def balance
    self[:balance] || 0
  end

  def deposit(amount)
    self.update!(balance: self.balance + amount)
  end

  def withdraw(amount)
    raise 'insufficient funds' if self.balance < amount
    self.update!(balance: self.balance - amount)
  end
end
