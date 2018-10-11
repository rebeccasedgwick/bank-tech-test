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
end
