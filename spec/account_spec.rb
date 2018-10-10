require "account"

describe Account do
  let(:date) { "11-11-2011" }
  let(:subject) { described_class.new }
  let(:transaction_class_double) { double }
  let(:transaction_double) { double }


  describe "#initialize" do
    it "initializes with an array of transactions" do
      expect(subject.transactions).to be_an(Array)
    end

    it "initializes with an opening balance of 0" do
      expect(subject.balance).to eq(0.0)
    end
  end

  describe "#withdraw" do
    before do
      subject.instance_variable_set(:@balance, 100)
    end

    context "creating a new transaction" do
      it "creates a new transaction item from the given params" do
        expect(transaction_class_double).to receive(:new).with(Date.new(2011, 11, 11), -100, 0.0).and_return(transaction_double)

        expect {
          subject.withdraw(date, -100.0, transaction_class: transaction_class_double)
        }.to change { subject.transactions.length }.by(1)

        expect(subject.transactions.last).to eq(transaction_double)
      end
    end

    context "updating the account balance" do
      it "reduces the balance by the given amount" do
        expect(transaction_class_double).to receive(:new).with(Date.new(2011, 11, 11), -100, 0.0).and_return(transaction_double)

        subject.withdraw(date, -100.0, transaction_class: transaction_class_double)
        expect(subject.balance).to eq(0.0)
      end
    end

    context "given a positive number" do
      it "raises an error" do
        expect { subject.withdraw(date, 100.0, transaction_class: transaction_class_double) }.to raise_error("Please enter a valid number")
      end

      it "doesn't decrease the balance" do
        begin
          subject.withdraw(date, 100.0, transaction_class: transaction_class_double)
        rescue
        end
        expect(subject.balance).not_to eq(-100)
      end
    end
  end

  describe "#deposit" do
    context "creating a new transaction" do
      it "Creates a new transaction item from the given params" do
        expect(transaction_class_double).to receive(:new).with(Date.new(2011, 11, 11), 100, 100.0).and_return(transaction_double)

        expect {
          subject.deposit(date, 100.0, transaction_class: transaction_class_double)
        }.to change { subject.transactions.length }.by(1)

        expect(subject.transactions.last).to eq(transaction_double)
      end
    end

    context "updating the account balance" do
      it "increases balance by correct value when given positive number" do
        expect(transaction_class_double).to receive(:new).with(Date.new(2011, 11, 11), 100, 100.0).and_return(transaction_double)

        subject.deposit(date, 100.0, transaction_class: transaction_class_double)
        expect(subject.balance).to eq(100.0)
      end
    end

    context "given a negative number" do
      it "raises an error" do
        expect { subject.deposit(date, -100.0, transaction_class: transaction_class_double) }.to raise_error("Please enter a valid number")
      end

      it "doesn't increase the balance" do
        begin
          subject.deposit(date, -100.0, transaction_class: transaction_class_double)
        rescue
        end
        expect(subject.balance).to eq(0)
      end
    end
  end

  describe "statement" do
    it "has column headers displayed and pretty prints the statement transactions" do
      tr_dbl1 = double(date: Date.new(2011, 6, 1), debit: 0.0, credit: 500.0, balance: 750.0)
      tr_dbl2 = double(date: Date.new(2011, 5, 1), debit: 50.0, credit: 0.0, balance: 250.0)

      subject.instance_variable_set(:@transactions, [tr_dbl1, tr_dbl2])
      expected_string = "date       || credit      || debit       || balance    \n01/05/2011 ||        0.00 ||       50.00 ||      250.00\n01/06/2011 ||      500.00 ||        0.00 ||      750.00\n"

      expect { subject.statement }.to output(expected_string).to_stdout
    end

    it "transactions are displayed in reverse chronological order" do
      tr_dbl1 = double(date: Date.new(2011, 1, 1), debit: 50.0, credit: 0.0, balance: 250.0)
      tr_dbl2 = double(date: Date.new(2011, 2, 1), debit: 0.0, credit: 500.0, balance: 750.0)

      subject.instance_variable_set(:@transactions, [tr_dbl1, tr_dbl2])
      expected_string = "date       || credit      || debit       || balance    \n01/02/2011 ||      500.00 ||        0.00 ||      750.00\n01/01/2011 ||        0.00 ||       50.00 ||      250.00\n"

      expect { subject.statement }.to output(expected_string).to_stdout
    end
  end
end
