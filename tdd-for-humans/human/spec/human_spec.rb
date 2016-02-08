# spec/human_spec.rb
require "./human.rb"

describe Human do
  context "Before breakfast" do
    before(:each) do
      @human = Human.new
    end
    it "is hungry" do
      expect(@human.tummy).to eq("hungry")
    end
    it "is sleepy" do
      expect(@human.state).to eq("sleepy")
    end
  end

  context "After coffee" do
    before(:all) do
      @human = Human.new
      @human.get_coffee
    end
    it "is awake after drinking coffee" do
      expect(@human.state).to eq("awake")
    end
    it "is not hungry after drinking coffee" do
      expect(@human.tummy).to_not eq("hungry")
    end
  end
end
