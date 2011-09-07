require "spec_helper"
require "table_bot/simulator"

describe(TableBot::Simulator) do
  
  its(:width)  { should == 5 }
  its(:height) { should == 5 }
  
  let(:instance) { TableBot::Simulator.new }
  
  describe('#place') do
    let(:orientation) { :east }
    
    subject { lambda { instance.place(location, orientation) } }
    
    context 'when location is inside world' do
      let(:location)    { [3,3] }
      
      subject { instance }
      
      before :each do
        instance.place(location, orientation)
      end
      
      its(:robot_location) { should == location }
      its(:robot_orientation) { should == orientation }
    end
    
    context 'when location is over north boundary' do
      let(:location) { [3,6] }
      it { should raise_error }
    end
    
    context 'when location is over south boundary' do
      let(:location) { [3,-1] }
      it { should raise_error }
    end
    
    context 'when location is over east boundary' do
      let(:location) { [6,3] }
      it { should raise_error }
    end
    
    context 'when location is over west boundary' do
      let(:location) { [-1,3] }
      it { should raise_error }
    end
  end
  
end