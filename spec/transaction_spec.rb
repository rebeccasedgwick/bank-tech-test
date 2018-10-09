require "account"

describe Account do
  let(:date) { "11-11-2011" }
  let(:subject) { described_class.new }

  describe "#initialize" do
    it "initializes with an array of transactions" do
      expect(subject.transactions).to be_an(Array)
    end

    it "initializes with an opening balance of 0" do
      expect(subject.balance).to eq(0.00)
    end
  end

  describe "#withdraw" do
    it "reduces the balance by the given amount" do
    subject.withdraw(date, -100.00)
    expect(subject.balance).to eq(-100.00)
  end

    it "reduces balance by correct value when given positive number" do
      expect { subject.withdraw(date, 100.00) }.to change { subject.balance }.by(-100.00)
      expect(subject.balance).to eq(-100.00)
    end

    it "reduces balance by correct value when given negative number" do
      expect { subject.withdraw(date, -100.00) }.to change { subject.balance }.by(-100.00)
      expect(subject.balance).to eq(-100.00)
    end

    it "adds a withdrawl amount as a negative float to transactions array" do
      subject.withdraw(date, 100.00)
      expect(subject.transactions[0]).to include(-100.00)
    end
  end


  describe "#deposit" do
    it "increases the balance by the given amount" do
      subject.deposit(date, 100.00)
      expect(subject.balance).to eq(100.00)
    end

    it "increases balance by correct value when given positive number" do
      expect { subject.deposit(date, 100.00) }.to change { subject.balance }.by(100.00)
      expect(subject.balance).to eq(100.00)
    end

    it "increases balance by correct value when given negative number" do
      expect { subject.deposit(date, -100.00) }.to change { subject.balance }.by(100.00)
      expect(subject.balance).to eq(100.00)
    end

    it "adds a deposited amount as a positive float to transactions array" do
      subject.deposit(date, 500.00)
      expect(subject.transactions[0]).to include(500.00)
    end
  end
end
