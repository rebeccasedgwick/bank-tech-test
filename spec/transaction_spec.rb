require "transaction"

describe Transaction do
  describe "#initialize" do
    context "sorting debits and credits" do
      it "allocates positive amounts to credits" do
        transaction = Transaction.new("11-11-2011", 100.0, 100.0)
        expect(transaction.credit).to eq(100.0)
        expect(transaction.debit).to eq(0)
        expect(transaction.balance).to eq(100.0)
      end
      it "allocates negative amounts to debits" do
        transaction = Transaction.new("12-12-2012", -200.0, 200.0)
        expect(transaction.debit).to eq(-200.0)
        expect(transaction.credit).to eq(0)
        expect(transaction.balance).to eq(200.0)
      end
    end
  end
end
