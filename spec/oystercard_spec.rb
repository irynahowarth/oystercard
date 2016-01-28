require 'oystercard'

describe Oystercard do

  subject(:oystercard){ described_class.new }
  let(:start_journey){double :start_journey}
  let(:end_journey){double :end_journey}
  let(:journey){ {start_journey: start_journey, end_journey: end_journey} }


  describe "#initialize" do

    it "should have balance 0" do
      expect(oystercard.balance).to eq 0
    end

    it "should have an empty array as journey_list" do
      expect(oystercard.journey_list).to match_array []
    end

  end

  describe "#top_up" do

    before(:each) { oystercard.top_up(Oystercard::MAX_LIMIT) }

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should return money when given 5" do
      expect(oystercard.balance).to eq Oystercard::MAX_LIMIT
    end

    it "should raise error when balance >= MAX_LIMIT" do
      message = "Balance will exceed maximum #{Oystercard::MAX_LIMIT}!"
      expect{oystercard.top_up(Oystercard::MAX_LIMIT+1)}.to raise_error message
    end

  end

  describe "#touch_in" do

    before(:each) do
      oystercard.top_up Oystercard::MIN_LIMIT
      oystercard.touch_in(journey[start_journey])
    end

    it "shoud raise error when balance is less then #{Oystercard::MIN_LIMIT}" do
      oystercard.touch_out journey[end_journey]
      expect{oystercard.touch_in(journey[start_journey])}.to raise_error "Not enough money!"
    end

    it "should remember the entry station" do
      expect(oystercard.journey_list.last[:start_st]).to eq journey[start_journey]
    end
  end

   describe "#touch_out" do

    before(:each) do
      oystercard.top_up Oystercard::MIN_LIMIT
      oystercard.touch_in("journey[start_journey]")
    end

    it "should deduct fare amount from card" do
      expect{oystercard.touch_out("journey[end_journey]")}.to change{oystercard.balance}.by -Oystercard::MIN_LIMIT
    end

    it "should remember the exit station" do
      oystercard.touch_out(journey[end_journey])
      expect(oystercard.journey_list.last[:end_st]).to eq journey[end_journey]
    end

  it "should charge penalty fare if you touch in twice in a row"do
    expect{oystercard.touch_in "start"}.to change{oystercard.balance}.by -Journey::PENALTY_FARE
  end

  end
  it "should charge a penalty fare if you touch out without touching in"do
    oystercard.top_up 50
    expect{oystercard.touch_out "end"}.to change{oystercard.balance}.by -Journey::PENALTY_FARE
end

end
