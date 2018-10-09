require "transaction"

describe Transaction do
  subject { described_class.new("11-01-2001", "500", "", "500") }

  describe "#initialize" do
    it "returns the date, debit, credit, and balance of a transaction" do
      expect(subject.date).to eq("11-01-2001")
      expect(subject.debit).to eq("500")
      expect(subject.credit).to eq("")
      expect(subject.balance).to eq("500")
    end
  end
end
