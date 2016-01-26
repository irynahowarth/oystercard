require 'oystercard'

describe Oystercard do

  subject(:oystercard){ described_class.new }
  let(:station){double :station}

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

  describe "#touch_in" do

    before(:each) do
      subject.top_up Oystercard::MIN_LIMIT
      subject.touch_in(station)
    end


    it "should change the #in_jorney? for true" do
      expect(subject.in_jorney?).to eq true
    end

    it "shoud raise error when balance is less then #{Oystercard::MIN_LIMIT}" do
      subject.touch_out
      expect{subject.touch_in(station)}.to raise_error "Not enough money!"
    end

    it "should remember the entry station" do
      expect(subject.entry_station).to eq station
    end
  end

   describe "#touch_out" do

    before(:each) do
      subject.top_up Oystercard::MIN_LIMIT
      subject.touch_in(station)
    end

    it "should change the #in_jorney? for false" do
      expect{subject.touch_out}.to change{subject.in_jorney?}.to false
    end

    it "should deduct fare amount from card" do
      expect{subject.touch_out}.to change{subject.balance}.by -Oystercard::MIN_LIMIT
    end

  end

end