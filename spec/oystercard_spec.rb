require 'oystercard'

describe Oystercard do

  it "on initialize should have balance 0" do
    expect(subject.balance).to eq 0
  end

  it "should change balance to 5 when #topup(5)" do
    subject.top_up(5)
    expect(subject.balance).to eq 5
  end

  it "should raise error if on top_up balance will exceed 90" do
    message = "Balance will exceed maximum #{Oystercard::MAX_LIMIT}!"
    expect{subject.top_up(Oystercard::MAX_LIMIT+1)}.to raise_error message
  end

  it "should deduct balance on 20 when #deduct(20)" do
    subject.top_up(30)
    subject.deduct(20)
    expect(subject.balance).to eq 10
  end

  it "when initialize #in_jorney? is return false" do
    expect(subject.in_jorney?).to eq false
  end

  it "should change the #in_jorney? for true if #touch_in" do
    subject.touch_in
    expect(subject.in_jorney?).to eq true
  end

  it "should change the #in_jorney? for false if #touch_out" do
    subject.touch_in
    subject.touch_out
    expect(subject.in_jorney?).to eq false
  end

end