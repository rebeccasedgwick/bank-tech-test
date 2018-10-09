require "statement"

describe Statement do
  describe "#initialize" do
    let(:subject) { described_class.new(account_double) }

    it "initializes with an Account" do
      account_double = double
      expect { Statement.new(account_double) }.to_not raise_error
    end
  end

  describe "#show" do
    it "returns the transactions of an account" do
      account_double = Account.new
      account_double.transactions << ["transaction item", "transaction item 2"]
      subject = described_class.new(account_double)

      expect(subject.show).to be_an(Array)
      expect(subject.show).to include(["transaction item", "transaction item 2"])
    end
  end
end
