require "spec_helper"
require "table_bot/simulator"

describe(TableBot::Simulator) do
  
  its(:width)  { should == 5 }
  its(:height) { should == 5 }
  
  describe('#place') do
    context 'when location is inside world' do
      it "should place the robot at the given location"
      it "should give the robot the specified orientation"
    end
    
    context 'when location is over north boundary' do
      it "should fail"
    end
    
    context 'when location is over south boundary' do
      it "should fail"
    end
    
    context 'when location is over east boundary' do
      it "should fail"
    end
    
    context 'when location is over west boundary' do
      it "should fail"
    end
  end
  
end