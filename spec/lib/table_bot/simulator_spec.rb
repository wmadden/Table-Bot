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
      simulator.robot_orientation = orientation
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
  
  describe '#robot_orientation' do
    
    subject { simulator.robot_orientation }
    
    before do
      simulator.instance_variable_set( :@robot_orientation, orientation )
    end
    
    context 'when its orientation is -90' do
      let(:orientation) { -90 }
      it { should == :south }
    end
    
    context 'when its orientation is 0' do
      let(:orientation) { 0 }
      it { should == :east }
    end
    
    context 'when its orientation is 90' do
      let(:orientation) { 90 }
      it { should == :north }
    end
    
    context 'when its orientation is 180' do
      let(:orientation) { 180 }
      it { should == :west }
    end
    
    context 'when its orientation is 270' do
      let(:orientation) { 270 }
      it { should == :south }
    end
    
    context 'when its orientation is 360' do
      let(:orientation) { 360 }
      it { should == :east }
    end
    
  end
  
  describe '#robot_orientation=' do
    
    subject { simulator.instance_variable_get(:@robot_orientation) }
    
    before do
      simulator.instance_variable_set( :@robot_orientation, 0 )
      simulator.robot_orientation = new_orientation
    end
    
    context 'east' do
      let(:new_orientation) { :east }
      it { should == 0 }
    end
    
    context 'north' do
      let(:new_orientation) { :north }
      it { should == 90 }
    end
    
    context 'west' do
      let(:new_orientation) { :west }
      it { should == 180 }
    end
    
    context 'south' do
      let(:new_orientation) { :south }
      it { should == 270 }
    end
    
  end
  
end