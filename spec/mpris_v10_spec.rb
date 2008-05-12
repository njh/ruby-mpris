#
# This is an rspec file for testing a media player
# against the MPRIS version 1.0 specification
#
# It doesn't not use the MPRIS ruby gem at all.
#
# Author: Nicholas J Humfrey <njh@aelius.com>
#
# Requirements:
#  rspec: http://rspec.info/
#  ruby-dbus: https://trac.luon.net/ruby-dbus/
# 
# Start your media player (eg 'vlc --control dbus') then run:
#   spec -f html mpris_v10_spec.rb > rspec_results.html
# for an HTML report.
#
# The Media Player tracklist should be empty when starting the tests.
#
#
# TODO:
# - position getting/setting
# - capability tests
# - make other tests obey the capabilities of the player
# - signal tests
# - test random/repeat/loop properly
#

require 'dbus'

# Set at least three test audio files here
TEST_FILES = [
  'file:///home/njh/Music/001160.mp3',
  'file:///home/njh/Music/003820.mp3',
  'file:///home/njh/Music/003548.mp3'
]  

# Set your d-bus here
DBUS = DBus::SessionBus.instance



# MPRIS specification constants
MPRIS_SERVICE_PREFIX = 'org.mpris'
MPRIS_INTERFACE = 'org.freedesktop.MediaPlayer'

MPRIS_STATE_PLAYING = 0
MPRIS_STATE_PAUSED = 1
MPRIS_STATE_STOPPED = 2


describe 'MPRIS version 1.0' do

  def get_service
    service_name = nil
    service_names = DBUS.proxy.ListNames.first
    service_names.each { |n|
      if (n =~ /^org.mpris/)
        service_name = n
        break
      end
    }
    
    return DBUS.service(service_name)
  end
  
  
  def get_interface(object_name)
    object = @service.object(object_name)
    object.introspect
    return object[MPRIS_INTERFACE]
  end
  
  
  describe 'service' do
    before :all do
      @service = get_service
    end
    
    it "should have a service name starting 'org.mpris'" do
      @service.name.should match(/^org.mpris/)
    end
  
    it 'should have an object at /' do
      @service.object("/").should_not be_nil
    end
    
    it 'should have an object at /Player' do
      @service.object("/Player").should_not be_nil
    end
    
    it 'should have an object at /TrackList' do
      @service.object("/TrackList").should_not be_nil
    end
    
    it 'should implement the MediaPlayer interface on /' do
      root_object = @service.object("/")
      root_object.introspect
      root_object.should have_iface(MPRIS_INTERFACE)
    end
    
    it 'should implement the MediaPlayer interface on /Player' do
      player_object = @service.object("/Player")
      player_object.introspect
      player_object.should have_iface(MPRIS_INTERFACE)
    end
  
    it 'should implement the MediaPlayer interface on /TrackList' do
      tracklist_object = @service.object("/TrackList")
      tracklist_object.introspect
      tracklist_object.should have_iface(MPRIS_INTERFACE)
    end
    
  end
  
  describe 'service root object' do
    before :all do
      @service = get_service
      @root = get_interface('/')
    end
    
    it 'should implement a method called "Identity"' do
      @root.methods.keys.should include("Identity")
    end
    
    it 'should implement a method called "Identity" that returns a string' do
      @root.Identity.first.should be_an_instance_of(String)
    end

  
    it 'should implement a method called "Quit"' do
      @root.methods.keys.should include("Quit")
    end
  
    it 'should implement a method called "MprisVersion"' do
      @root.methods.keys.should include("MprisVersion")
    end
    
    it 'should implement a method called "MprisVersion" that returns two integers' do
      @root.MprisVersion.first.should be_an_instance_of(Array)
      @root.MprisVersion.first.size.should == 2
      @root.MprisVersion.first[0].should be_an_instance_of(Fixnum)
      @root.MprisVersion.first[1].should be_an_instance_of(Fixnum)
    end

    it 'should implement a method called "MprisVersion" that returns [1,0]' do
      @root.MprisVersion.first[0].should == 1
      @root.MprisVersion.first[1].should == 0
    end
  end
  
  describe 'service /Player object' do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
    end
  
    it 'should implement a method called "Next"' do
      @player.methods.keys.should include("Next")
    end

    it 'should implement a method called "Prev"' do
      @player.methods.keys.should include("Prev")
    end

    it 'should implement a method called "Pause"' do
      @player.methods.keys.should include("Pause")
    end

    it 'should implement a method called "Stop"' do
      @player.methods.keys.should include("Stop")
    end

    it 'should implement a method called "Play"' do
      @player.methods.keys.should include("Play")
    end

    it 'should implement a method called "Repeat"' do
      @player.methods.keys.should include("Repeat")
    end

    it 'should implement a method called "GetStatus"' do
      @player.methods.keys.should include("GetStatus")
    end

    it 'should implement a method called "GetStatus" that returns four integers' do
      @player.GetStatus.first.should be_an_instance_of(Array)
      @player.GetStatus.first.size.should == 4
      @player.GetStatus.first[0].should be_an_instance_of(Fixnum)
      @player.GetStatus.first[1].should be_an_instance_of(Fixnum)
      @player.GetStatus.first[2].should be_an_instance_of(Fixnum)
      @player.GetStatus.first[3].should be_an_instance_of(Fixnum)
    end
    
    it 'should implement a method called "GetMetadata"' do
      @player.methods.keys.should include("GetMetadata")
    end
    
    it 'should implement a method called "GetCaps"' do
      @player.methods.keys.should include("GetCaps")
    end

    it 'should implement a method called "GetCaps" that returns an integer' do
      @player.GetCaps.first.should be_an_instance_of(Fixnum)
    end

    it 'should implement a method called "VolumeSet"' do
      @player.methods.keys.should include("VolumeSet")
    end

    it 'should implement a method called "VolumeGet"' do
      @player.methods.keys.should include("VolumeGet")
    end

    it 'should implement a method called "VolumeGet" that returns an integer' do
      @player.VolumeGet.first.should be_an_instance_of(Fixnum)
    end

    it 'should implement a method called "PositionSet"' do
      @player.methods.keys.should include("PositionSet")
    end

    it 'should implement a method called "PositionGet"' do
      @player.methods.keys.should include("PositionGet")
    end

    it 'should implement a method called "PositionGet" that returns an integer' do
      @player.PositionGet.first.should be_an_instance_of(Fixnum)
    end

  end
  
  
  
  describe 'service /TrackList object' do
    before :all do
      @service = get_service
      @tracklist = get_interface('/TrackList')
    end
    
  
    it 'should implement a method called "GetMetadata"' do
      @tracklist.methods.keys.should include("GetMetadata")
    end

    it 'should implement a method called "GetCurrentTrack"' do
      @tracklist.methods.keys.should include("GetCurrentTrack")
    end

    it 'should implement a method called "GetCurrentTrack" that returns an integer' do
      @tracklist.GetCurrentTrack.first.should be_an_instance_of(Fixnum)
    end

    it 'should implement a method called "GetLength"' do
      @tracklist.methods.keys.should include("GetLength")
    end

    it 'should implement a method called "GetLength" that returns an integer' do
      @tracklist.GetLength.first.should be_an_instance_of(Fixnum)
    end

    it 'should implement a method called "AddTrack"' do
      @tracklist.methods.keys.should include("AddTrack")
    end

    it 'should implement a method called "DelTrack"' do
      @tracklist.methods.keys.should include("DelTrack")
    end

    it 'should implement a method called "SetLoop"' do
      @tracklist.methods.keys.should include("SetLoop")
    end

    it 'should implement a method called "SetRandom"' do
      @tracklist.methods.keys.should include("SetRandom")
    end
  end
  
#   describe 'service setting the Player volume' do
#     before :all do
#       @service = get_service
#       @player = get_interface('/Player')
#     end
#   
#     it "should not return -1 when the volume is set to -1" do
#       @player.VolumeSet(-1)
#       sleep 0.5
#       @player.VolumeGet.first.should_not == -1
#     end
#   
#     it "should return 0 when the volume is set to 0" do
#       @player.VolumeSet(0)
#       sleep 0.5
#       @player.VolumeGet.first.should == 0
#     end
#   
#     it "should return 100 when the volume is set to 100" do
#       @player.VolumeSet(100)
#       sleep 0.5
#       @player.VolumeGet.first.should == 100
#     end
#   
#     it "should not return 101 when the volume is set to 101" do
#       @player.VolumeSet(101)
#       sleep 0.5
#       @player.VolumeGet.first.should_not == 101
#     end
#   
#     it "should not return 200 when the volume is set to 200" do
#       @player.VolumeSet(200)
#       sleep 0.5
#       @player.VolumeGet.first.should_not == 200
#     end
#   
#     it "should return 16 when the volume is set to 16" do
#       @player.VolumeSet(16)
#       sleep 0.5
#       @player.VolumeGet.first.should == 16
#     end
#   end


  describe 'service when adding a track to the TrackList' do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
      @tracklist = get_interface('/TrackList')
    end
  
    it "should return 0 to indicate success" do
      @tracklist.AddTrack( TEST_FILES[0], false ).first.should == 0
    end

    it "should increment the tracklist length by one" do
      len = @tracklist.GetLength.first
      @tracklist.AddTrack( TEST_FILES[1], false )
      @tracklist.GetLength.first.should == (len+1)
    end

    it "should cause the state to change to Playing (when immediate is set)" do
      @tracklist.AddTrack( TEST_FILES[2], true )
      sleep 0.5
      @player.GetStatus.first[0].should == MPRIS_STATE_PLAYING
    end

    it "should not change the state (when immediate is not set)" do
      @player.Stop
      @tracklist.AddTrack( TEST_FILES[2], false )
      sleep 0.5
      @player.GetStatus.first[0].should == MPRIS_STATE_STOPPED
    end
    
  end

  describe 'service starting/stopping/pausing playback' do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
    end
  
    it "should change state to playing when calling Play method" do
      @player.Play
      sleep 0.5
      @player.GetStatus.first[0].should == MPRIS_STATE_PLAYING
    end

    it "should restart playback when calling Play method twice" do
      @player.Play
      sleep 0.5
      @player.Play
      sleep 0.5
      @player.GetStatus.first[0].should == MPRIS_STATE_PLAYING
    end
  
    it "should change state to Stopped when calling Stop method" do
      @player.Stop
      sleep 0.5
      @player.GetStatus.first[0].should == MPRIS_STATE_STOPPED
    end
  
    it "should change state to Paused when calling Pause method" do
      @player.Play
      sleep 0.5
      @player.Pause
      sleep 0.5
      @player.GetStatus.first[0].should == MPRIS_STATE_PAUSED
    end
  
    it "should change state to Playing when calling Pause method twice" do
      @player.Stop
      sleep 0.5
      @player.Play
      sleep 0.5
      @player.Pause
      sleep 0.5
      @player.Pause
      sleep 0.5
      @player.GetStatus.first[0].should == MPRIS_STATE_PLAYING
    end
  
  end


  describe 'service when changing track' do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
      @tracklist = get_interface('/TrackList')
      # FIXME: we rely on the previous examples adding some tracks
    end

    it "should decrement the current track counter when going previous" do
      # FIXME: this test isn't valid if the player doesn't support tracklists
      @player.Play
      sleep 0.5
      this = @tracklist.GetCurrentTrack.first
      @player.Prev
      sleep 0.5
      @tracklist.GetCurrentTrack.first.should == this-1
    end

    it "should increment the current track counter when going next" do
      # FIXME: this test isn't valid if the player doesn't support tracklists
      @player.Play
      sleep 0.5
      this = @tracklist.GetCurrentTrack.first
      @player.Next
      sleep 0.5
      @tracklist.GetCurrentTrack.first.should == this+1
    end
  end

  describe "service when getting the current track's metadata" do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
      # FIXME: we rely on the previous examples adding some tracks
      @player.Play
      @metadata = @player.GetMetadata.first
    end

    it "should define a method called GetMetadata that returns a dictionary" do
      @metadata.should be_an_instance_of(Hash)
    end

    it "should define a method called GetMetadata that returns a non-empty dictionary" do
      @metadata.should_not be_empty
    end

    it "should define 'location' in the dictionary returned by GetMetadata" do
      @metadata.keys.should include('location')
    end

    it "should return a URL starting file:// in the 'location' field returned by GetMetadata" do
      @metadata['location'].should match(%r[^file://])
    end
  end


  describe "service when getting the metadata for a track on the tracklist" do
    before :all do
      @service = get_service
      @tracklist = get_interface('/TrackList')
      # Add a track to the tracklist, so that we know what it should be
      @tracklist.AddTrack( TEST_FILES[0], false )
      index = @tracklist.GetLength.first - 1
      @metadata = @tracklist.GetMetadata(index).first
    end

    it "should define a method called GetMetadata that returns a dictionary" do
      @metadata.should be_an_instance_of(Hash)
    end

    it "should define a method called GetMetadata that returns a non-empty dictionary" do
      @metadata.should_not be_empty
    end

    it "should define 'location' in the dictionary returned by GetMetadata" do
      @metadata.keys.should include('location')
    end

    it "should return the URL of the file in the 'location' returned by GetMetadata" do
      @metadata['location'].should == TEST_FILES[0]
    end
  end
  
  describe "service when getting/setting repeat" do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
    end

    it "should set 'repeat' item of status to 1, when repeat is enabled" do
      @player.Repeat(true)
      @player.GetStatus.first[2].should == 1
    end

    it "should set 'repeat' item of status to 0, when repeat is disabled" do
      @player.Repeat(false)
      @player.GetStatus.first[2].should == 0
    end
    
    # FIXME: work out how to test that the player is repeating correctly
  end

  describe "service when getting/setting loop" do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
      @tracklist = get_interface('/TrackList')
    end

    it "should set 'loop' item of status to 1, when looping is enabled" do
      @tracklist.SetLoop(true)
      @player.GetStatus.first[3].should == 1
    end

    it "should set 'loop' item of status to 0, when looping is disabled" do
      @tracklist.SetLoop(false)
      @player.GetStatus.first[3].should == 0
    end
    
    # FIXME: work out how to test that the player is looping correctly
  end

  describe "service when getting/setting random" do
    before :all do
      @service = get_service
      @player = get_interface('/Player')
      @tracklist = get_interface('/TrackList')
    end

    it "should set 'random' item of status to 1, when looping is enabled" do
      @tracklist.SetRandom(true)
      @player.GetStatus.first[1].should == 1
    end

    it "should set 'random' item of status to 0, when looping is disabled" do
      @tracklist.SetRandom(false)
      @player.GetStatus.first[1].should == 0
    end
    
    # FIXME: work out how to test that the player is randomising correctly
  end

  describe "service when removing a track from the tracklist" do
    before :all do
      @service = get_service
      @tracklist = get_interface('/TrackList')
    end

    it "should decrement the number of tracks on the tracklist when removing the first item" do
      len = @tracklist.GetLength.first
      @tracklist.DelTrack( 0 )
      @tracklist.GetLength.first.should == (len-1)
    end

    it "should decrement the number of tracks on the tracklist when removing the last item" do
      len = @tracklist.GetLength.first
      @tracklist.DelTrack( len-1 )
      @tracklist.GetLength.first.should == (len-1)
    end
  end

  after :all do
    @service = get_service
    @player = get_interface('/Player')
    # Ok, be quiet now
    @player.Stop
  end
  
end
