require "statement"

describe Statement do
  describe "#initialize" do
    let(:subject) { described_class.new }

    it "initializes with an Account" do
      account_double = double([transactions: ["10/01/2011", 500], balance: "500.00"])
      expect { Statement.new(account_double) }.to_not raise_error
    end
  end
end
