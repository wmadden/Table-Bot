require "spec_helper"
require "table_bot/simulator"

describe TableBot::Simulator do
  
  its(:width)  { should == 5 }
  its(:height) { should == 5 }
  
  let(:simulator) { TableBot::Simulator.new }
  
  describe '#place' do
    let(:orientation) { :east }
    
    subject { lambda { simulator.place(location, orientation) } }
    
    context 'when location is inside world' do
      let(:location) { [3,3] }
      
      subject { simulator }
      
      before :each do
        simulator.place(location, orientation)
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
  
  describe '#move' do
    
    let(:location) { [3,3] }
    
    subject { simulator.move }
    
    before do
      simulator.stub(:robot_orientation).and_return( orientation )
      simulator.stub(:robot_location).and_return( location )
    end
    
    context 'when the robot is facing north' do
      let(:orientation) { :north }
      
      it 'should place the robot one space to the north' do
        simulator.should_receive(:place).with([3,4], :north)
        subject
      end
    end
    
    context 'when the robot is facing south' do
      let(:orientation) { :south }
      
      it 'should place the robot one space to the south' do
        simulator.should_receive(:place).with([3,2], :south)
        subject
      end
    end
    
    context 'when the robot is facing east' do
      let(:orientation) { :east }
      
      it 'should place the robot one space to the east' do
        simulator.should_receive(:place).with([4,3], :east)
        subject
      end
    end
    
    context 'when the robot is facing west' do
      let(:orientation) { :west }
      
      it 'should place the robot one space to the west' do
        simulator.should_receive(:place).with([2,3], :west)
        subject
      end
    end
    
  end
  
  describe '#turn' do
    
    subject { simulator }
    
    before do
      simulator.place( [0,0], orientation )
      simulator.turn( direction )
    end
    
    context 'left' do
      let(:direction) { :left }
      
      context 'when facing north' do
        let(:orientation) { :north }
        its(:robot_orientation) { should == :west }
      end
      
      context 'when facing south' do
        let(:orientation) { :south }
        its(:robot_orientation) { should == :east }
      end
      
      context 'when facing east' do
        let(:orientation) { :east }
        its(:robot_orientation) { should == :north }
      end
      
      context 'when facing west' do
        let(:orientation) { :west }
        its(:robot_orientation) { should == :south }
      end
    end
    
    context 'right' do
      let(:direction) { :right }
      
      context 'when facing north' do
        let(:orientation) { :north }
        its(:robot_orientation) { should == :east }
      end
      
      context 'when facing south' do
        let(:orientation) { :south }
        its(:robot_orientation) { should == :west }
      end
      
      context 'when facing east' do
        let(:orientation) { :east }
        its(:robot_orientation) { should == :south }
      end
      
      context 'when facing west' do
        let(:orientation) { :west }
        its(:robot_orientation) { should == :north }
      end
    end
    
  end
  
end