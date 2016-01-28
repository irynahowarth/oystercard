require "journey"
require "oystercard"
describe Journey do

  subject(:journey) {described_class.new}


    it "should have a start eq nil if was not passed one" do
      expect(journey.start_st).to eq nil
    end

    it "should have a start eq nil if was not passed one" do
      expect(journey.end_st).to eq nil
    end

    it{ is_expected.to respond_to(:fare) }

    context "given start station" do
      before do
        journey[:start_st] = "London"
      end

      it "should have a start station" do
        expect(journey.start_st).to eq "London"
      end

      it "should #complete be false if there is start_st only" do
        expect(journey.complete?).to eq false
      end

      it "should charge a penalty fare when customers haven't correctly touched in" do
        journey[:start_st] = "end"
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end

    context "given end station" do
      before do
        journey[:end_st] = "London"
      end

      it "should have a end if was passed one" do
        expect(journey.end_st).to eq "London"
      end

      it "should #complete be false if there is end_st only" do
        expect(journey.complete?).to eq false
      end
      it "should charge a penalty fare when customers haven't correctly touched out" do
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end

    context "given start and end station" do
      before do
        journey[:start_st] = "London"
        journey[:end_st] = "Brighton"
      end

      it "should #complete be true if there is start_st and end_st" do
        expect(journey.complete?).to eq true
      end

      it "should charge a minimum fare when a journey has been completed" do
        expect(journey.fare).to eq Oystercard::MIN_LIMIT
      end

      it "should know that journey is completed" do
        expect(journey.complete?).to be true
      end
    end

end
