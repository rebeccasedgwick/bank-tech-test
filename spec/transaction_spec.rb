require "transaction"

describe "#initialize" do
  it "initializes with an array of transactions" do
    transaction = Transaction.new
    expect(transaction.transactions).to be_an(Array)
  end
end
