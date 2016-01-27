require 'oystercard'

describe Oystercard do

  subject(:oystercard){ described_class.new }
  let(:start_journey){double :start_journey}
  let(:end_journey){double :end_journey}
  let(:journey){ {start_journey: start_journey, end_journey: end_journey} }


  describe "#initialize" do

    it "should have balance 0" do
      expect(subject.balance).to eq 0
    end

    it "should #in_journey? return false" do
      expect(subject.in_journey?).to eq false
    end

    it "should have an empty array as journey_list" do
      expect(subject.journey_list).to match_array []
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
      subject.touch_in(journey[start_journey])
    end


    it "should change the #in_jorney? for true" do
      expect(subject.in_journey?).to eq true
    end

    it "shoud raise error when balance is less then #{Oystercard::MIN_LIMIT}" do
      subject.touch_out journey[end_journey]
      expect{subject.touch_in(journey[start_journey])}.to raise_error "Not enough money!"
    end

    it "should remember the entry station" do
      expect(subject.journey_list.last[:start_st]).to eq journey[start_journey]
    end
  end

   describe "#touch_out" do

    before(:each) do
      subject.top_up Oystercard::MIN_LIMIT
      subject.touch_in(journey[start_journey])
    end

    it "should deduct fare amount from card" do
      expect{subject.touch_out(journey[end_journey])}.to change{subject.balance}.by -Oystercard::MIN_LIMIT
    end

    xit "should change the #in_journey? for false" do
      subject.touch_out(journey[end_journey])
      expect(subject.in_journey?).to eq false
    end

    it "should remember the exit station" do
      subject.touch_out(journey[end_journey])
      expect(subject.journey_list.last[:end_st]).to eq journey[end_journey]
    end

  end

end