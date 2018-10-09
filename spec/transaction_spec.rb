require "transaction"

describe Transaction do
  subject { described_class.new }

  describe "#initialize" do
    it "returns the date, credit, debit, and balance of a transaction" do
      expect(subject.date).to eq(nil)
      expect(subject.credit).to eq(nil)
      expect(subject.debit).to eq(nil)
      expect(subject.balance).to eq(0.00)
    end
  end
end
