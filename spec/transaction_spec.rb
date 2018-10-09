require "transaction"

describe Transaction do
  subject { described_class.new }

  describe "#initialize" do
    it "returns the date, credit, debit, and balance of a transaction" do
      expect(subject.date).to eq("")
      expect(subject.credit).to eq(0.00)
      expect(subject.debit).to eq(0.00)
      expect(subject.balance).to eq(0.00)
    end
  end

  describe "#withdraw" do
    it "updates the date of a transaction" do
      subject.withdraw("11/01/2011", 500, -500)
      expect(subject.date).to eq("11/01/2011")
    end

    it "changes the debit amount of a transaction" do
      expect { subject.withdraw("11/01/2011", 500, -500) }.to change { subject.debit }.by(500)
    end

    it "changes the balance of a transaction" do
      expect { subject.withdraw("11/01/2011", 500, -500) }.to change { subject.balance }.by(-500)
    end
  end
end
