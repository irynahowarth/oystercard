require 'station'
describe Station do
  subject(:station){described_class.new "London", 4}

  describe '#initialize'do
    it 'should have a name'do
      expect(subject.name).to eq "London"
    end
    it 'should have a zone'do
      expect(subject.zone).to eq 4
    end
  end
  
end
