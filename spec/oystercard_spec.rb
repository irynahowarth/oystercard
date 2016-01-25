require 'oystercard'

describe Oystercard do

  it "on initialize should have balance 0" do
    expect(subject.balance).to eq 0
  end

  it "should change balance to 5 when #topup(5)" do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

end