require "statement"

describe Statement do
  let(:account_class_double) { double }
  let(:account_class_transactions_double) { double }
  let(:subject) { described_class.new(account_class_double) }

  describe "#initialize" do
    it "initializes with an account" do
      expect { Statement.new(account_class_double) }.to_not raise_error
    end
  end

  describe "#show" do
    context "dislaying the account's transactions in statment format"
    it "shows the column headers" do
      tr_dbl1 = double(date: Date.new(2011, 1, 1), debit: 50.0, credit: 0.0, balance: 250.0)
      tr_dbl2 = double(date: Date.new(2011, 2, 1), debit: 0.0, credit: 500.0, balance: 750.0)

      account_class_transactions_double = [tr_dbl1, tr_dbl2]
      expect(account_class_double).to receive(:transactions).and_return(account_class_transactions_double)

      expect { subject.show }.to output("#{tr_dbl1}\n#{tr_dbl2}\n").to_stdout
    end
  end
end
