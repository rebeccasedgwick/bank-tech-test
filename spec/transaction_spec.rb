require "account"

describe Account do
  subject { described_class.new }

  describe "#initialize" do
    it "initializes with an array of transactions" do
      expect(subject.transactions).to be_an(Array)
    end

    it "initializes with an opening balance of 0" do
      expect(subject.balance).to eq(0)
    end
  end

  describe "withdraw" do
    it "takes a param to withdraw" do
      expect { subject.withdraw(100) }.not_to raise_error
    end
  end
end
