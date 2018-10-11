require "statement"

describe Statement do
  let(:account_double) { double }
  let(:account_transactions_double) { double }
  let(:subject) { described_class.new(account_double) }

  describe "#initialize" do
    it "initializes with an account" do
      expect { Statement.new(account_double) }.to_not raise_error
    end
  end

  describe "#show" do
    it "shows the column headers & transactions in reverse chronological order" do
      tr_dbl1 = double(date: Date.new(2011, 1, 1), debit: 0.0, credit: 500.0, balance: 500.0)
      tr_dbl2 = double(date: Date.new(2011, 2, 1), debit: 250.0, credit: 0.0, balance: 250.0)

      account_transactions_double = [tr_dbl1, tr_dbl2]

      expect(account_double).to receive(:transactions).and_return(account_transactions_double)

      expected_string = "date       || credit      || debit       || balance    \n01/02/2011 ||        0.00 ||      250.00 ||      250.00\n01/01/2011 ||      500.00 ||        0.00 ||      500.00\n"

      expect { subject.show }.to output(expected_string).to_stdout
    end
  end
end
