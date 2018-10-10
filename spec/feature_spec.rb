require "account"
require "transaction"
require "test_helpers"

describe "Bank feature tests" do
  let(:transaction_date) { "12-02-2012" }

  describe "user can deposit" do
    it "when a user deposits money, it is added to their balance" do
      create_account
      make_deposit
      account_balance_increases
    end
  end

  describe "user can withdraw" do
    it "when a user withdraws money, it is added to their balance" do
      create_account
      make_deposit
      make_withdrawal
      account_balance_decreases
    end
  end

  describe "user can view their statement" do
    it "shows a statement with recent transactions" do
      create_account
      make_deposit
      make_withdrawal
      displays_statement
    end
  end
end
