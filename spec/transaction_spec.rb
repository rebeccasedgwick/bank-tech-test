require "account"

describe Account do
  subject { described_class.new }

  describe "#initialize" do
    it "initializes with an array of transactions" do
      expect(subject.transactions).to be_an(Array)
    end

    it "initializes with an opening balance of 0" do
      expect(subject.balance).to eq(0.00)
    end
  end

  describe "#withdraw" do
    it "takes a param to withdraw" do
      expect { subject.withdraw(100.00) }.not_to raise_error
    end

    it "reduces the balance by the given amount" do
      expect { subject.withdraw(100.00) }.not_to raise_error
    end

    describe "correctly calculates when given negative or positive amount" do
      it "reduces balance by correct value when given positive number" do
        expect { subject.withdraw(100.00) }.to change { subject.balance }.by(-100.00)
        expect(subject.balance).to eq(-100.00)
      end

      it "reduces balance by correct value when given negative number" do
        expect { subject.withdraw(-100.00) }.to change { subject.balance }.by(-100.00)
        expect(subject.balance).to eq(-100.00)
      end
    end
  end
end
