class User < ApplicationRecord
  has_one :wallet, as: :walletable
  after_create :create_wallet

  private

  def create_wallet
    Wallet.create(walletable: self, balance: 0)
  end
end
