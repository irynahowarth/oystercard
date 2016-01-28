require 'journeylog'

describe JourneyLog do

  describe "on #initialize" do
    it "receive @journey_klass" do
      subject.one_journey = subject.journey_klass.new 'start','end'
      expect(subject.one_journey.start_st).to eq 'start'
    end
    it "make @journeys as an empty array" do
      expect(subject.journeys).to eq []
    end
  end

  describe "#start_journey" do
    it "starts a new journey" do
      expect(subject).to respond_to(:start_journey).with(1)
    end
    it "starts new journey with starting station" do
      subject.start_journey('start')
      expect(subject.one_journey.start_st).to eq 'start'
    end
  end

  describe "#current_journey" do
    it "create a new journey if previous was completed" do
      subject.start_journey('start')
      subject.one_journey[:end_st] = "end"
      subject.current_journey
      expect(subject.one_journey).to eq Journey.new
    end
    it "return an incomplete journey if there is one" do
      subject.start_journey('start')
      expect(subject.current_journey).to eq subject.one_journey
    end
  end

  it "#exit_journey ends a current journey" do
    expect(subject).to respond_to(:exit_journey)
  end
end