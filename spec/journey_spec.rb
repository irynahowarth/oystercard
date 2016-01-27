require 'journey'

describe Journey do

  subject(:journey) {described_class.new}

    it 'should have a start if was passed one'do
      journey[:start_st] = "London"
      expect(journey.start_st).to eq "London"
    end

    it 'should have a start eq nil if was not passed one' do
      expect(journey.start_st).to eq nil
    end

    it 'should have a end if was passed one'do
      journey[:end_st] = "London"
      expect(journey.end_st).to eq "London"
    end

    it 'should have a start eq nil if was not passed one' do
      expect(journey.end_st).to eq nil
    end

    it "should #complete be true if there is start_st and end_st" do
      journey[:start_st] = "London"
      journey[:end_st] = "Brighton"
      expect(journey.complete?).to eq true
    end

    it "should #complete be false if there is start_st only" do
      journey[:start_st] = "London"
      expect(journey.complete?).to eq false
    end

    it "should #complete be false if there is end_st only" do
      journey[:end_st] = "London"
      expect(journey.complete?).to eq false
    end

    it{ is_expected.to respond_to(:fare) }

end