require "transaction"

describe Transaction do
  subject { described_class.new }

  describe "#initialize" do
    it "initializes with an array of transactions" do
      transaction = Transaction.new
      expect(transaction.transactions).to be_an(Array)
    end
  end

  describe "withdraw" do
    it "takes a param to withdraw" do
      expect{ subject.withdraw(100) }.not_to raise_error
    end
  end

end
