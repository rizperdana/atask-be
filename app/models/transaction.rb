class Transaction < ApplicationRecord
  belongs_to :source_wallet, class_name: "Wallet", optional: true
  belongs_to :target_wallet, class_name: "Wallet", optional: true

  validates :amount, presence: true
  validate :validate_wallets

  after_create :update_wallets

  private

  def validate_wallets
    errors.add(:base, "invalid wallets") if source_wallet.nil? && target_wallet.nil?
  end

  def validate_wallets
    ActiveRecord::Base.transaction do
      source_wallet.withdraw(amount) if source_wallet
      target_wallet.deposit(amount) if target_wallet
    end
  end
end
