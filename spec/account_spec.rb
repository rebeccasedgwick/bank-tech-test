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
    context "creating a new transaction" do
      it "creates a new transaction item from the given params" do
        withdraw_double = double(date: "01-01-2001", amount: -100.00)
        subject.withdraw(withdraw_double.date, withdraw_double.amount)

        expect(subject.transactions[0]).to be_a(Transaction)
        expect { subject.withdraw(withdraw_double.date, withdraw_double.amount) }.to change { subject.transactions.length }.by(1)
      end
    end

    context "updating the account balance" do
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
    end
  end

  describe "#deposit" do
    context "creating a new transaction" do
      it "Creates a new transaction item from the given params" do
        deposit_double = double(date: "02-02-2012", amount: 200.00)
        subject.deposit(deposit_double.date, deposit_double.amount)

        expect(subject.transactions[0]).to be_a(Transaction)
        expect { subject.deposit(deposit_double.date, deposit_double.amount) }.to change { subject.transactions.length }.by(1)
      end
    end

    context "updating the account balance" do
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
    end
  end

  describe "#date_formatter" do
    it "converts a given string to a time" do
      date_test = "13-01-2012"
      expect(subject.date_formatter(date_test)).to eq("13/01/2012")
    end
  end
end
