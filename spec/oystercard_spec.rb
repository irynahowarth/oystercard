require 'oystercard'

describe Oystercard do

  subject(:oystercard){ described_class.new }

  describe "#initialize" do

    it "should have balance 0" do
      expect(subject.balance).to eq 0
    end

    it "should #in_jorney? return false" do
      expect(subject.in_jorney?).to eq false
    end

  end

  describe "#top_up" do

    before(:each) { subject.top_up(Oystercard::MAX_LIMIT) }

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should return money when given 5" do
      expect(subject.balance).to eq Oystercard::MAX_LIMIT
    end

    it "should raise error when balance >= MAX_LIMIT" do
      message = "Balance will exceed maximum #{Oystercard::MAX_LIMIT}!"
      expect{subject.top_up(Oystercard::MAX_LIMIT+1)}.to raise_error message
    end

  end

  describe "#deduct" do

    it { is_expected.to respond_to(:deduct).with(1).argument }

    it "should return (balance-20) when #deduct(20)" do
      subject.top_up(30)
      subject.deduct(20)
      expect(subject.balance).to eq 10
    end

  end

  describe "#touch_in" do
    it "should change the #in_jorney? for true" do
      subject.touch_in
      expect(subject.in_jorney?).to eq true
    end
  end

   describe "#touch_out" do

    it "should change the #in_jorney? for false" do
      subject.touch_in
      subject.touch_out
      expect(subject.in_jorney?).to eq false
    end

  end

end