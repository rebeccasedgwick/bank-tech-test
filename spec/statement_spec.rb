require "statement"

describe Statement do
  let(:account_class_double) { double }

  describe "#initialize" do
    it "initializes with an account" do
      expect { Statement.new(account_class_double) }.to_not raise_error
    end
  end
end
