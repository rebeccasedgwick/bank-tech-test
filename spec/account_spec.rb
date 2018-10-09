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

  describe "statement" do
    it "has column headers displayed and pretty prints the statement transactions" do
      tr_dbl1 = double(date: "01/06/2011", debit: 0.00, credit: 500.00, balance: 750.00)
      tr_dbl2 = double(date: "01/05/2011", debit: 50.00, credit: 0.00, balance: 250.00)

      subject.instance_variable_set(:@transactions, [tr_dbl1, tr_dbl2])
      expected_string = "date       || credit     || debit      || balance   \n01/05/2011 ||        0.0 ||       50.0 ||      250.0\n01/06/2011 ||      500.0 ||        0.0 ||      750.0\n"

      expect { subject.statement }.to output(expected_string).to_stdout
    end

    it "transactions are displayed in reverse chronological order" do
      tr_dbl1 = double(date: "01/01/2011", debit: 50.00, credit: 0.00, balance: 250.00)
      tr_dbl2 = double(date: "01/02/2011", debit: 0.00, credit: 500.00, balance: 750.00)

      subject.instance_variable_set(:@transactions, [tr_dbl1, tr_dbl2])
      expected_string = "date       || credit     || debit      || balance   \n01/02/2011 ||      500.0 ||        0.0 ||      750.0\n01/01/2011 ||        0.0 ||       50.0 ||      250.0\n"

      expect { subject.statement }.to output(expected_string).to_stdout
    end
  end
end
