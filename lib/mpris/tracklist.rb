#!/usr/bin/ruby
#
# Copyright (C) 2008 by Nicholas J Humfrey
#

class Mpris

  # Note that if Player::has_tracklist? is false, the methods described below
  # will be implemented as no-ops, except metadata (which is valid only if given 
  # argument is 0), current_track (which always returns 0), 
  # length (which will return 0 or 1), and add_track
  class TrackList
  
    def initialize( service )
      @service = service
    
      # Check the service implements the MediaPlayer interface
      object = @service.object("/TrackList")
      object.introspect
      unless object.has_iface? Mpris::MPRIS_INTERFACE
        raise(Mpris::InterfaceNotImplementedException, 
          "#{service_name} does not implement the MediaPlayer interface on /.")
      end
      @interface = object[Mpris::MPRIS_INTERFACE]
   
    end
    
    # Gives all meta data available for item at given position in the TrackList, counting from 0.
    # 
    # Metadata is returned as key,values pairs in a Hash
    #
    # The pos argument is the position in the TrackList of the item of which the metadata is requested.
    def metadata(pos)
      return @interface.GetMetadata(pos)
    end
  
    # Return the position of current URI in the TrackList The return value is zero-based, 
    # so the position of the first URI in the TrackList is 0. The behavior of this method is 
    # unspecified if there are zero items in the TrackList.
    def current_track
      return @interface.GetCurrentTrack
    end
  
    # Returns the number of items in the TrackList.
    def length
      return @interface.GetLength.first
    end
  
    # Appends an URI in the TrackList.
    #
    # Returns 0 if successful 
    def add_track(uri,play_immediately=false)
    end
  
    # Removes an URI from the TrackList.
    #
    # pos is the position in the tracklist of the item to remove.
    def del_track(pos)
    end
  
    # Toggle playlist loop. true to loop, false to stop looping.
    def loop=(bool)
    end
  
    # Toggle playlist shuffle / random. It may or may not play tracks only once.
    # true to play randomly / shuffle playlist, false to play normally / reorder playlist.
    def random=(bool)
    end
    
  end

end