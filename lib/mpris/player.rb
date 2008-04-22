#!/usr/bin/ruby

class Mpris

  class Player
  
    PLAYING = 0
    PAUSED = 1
    STOPPED = 2
    
    
    # Goes to the next item in the TrackList
    def next
    end
    
    # Goes to the previous item in the TrackList
    def prev
    end
    
    # If playing : pause. If paused : unpause
    def pause
    end
    
    # Stop playback
    def stop
    end
    
    # If playing : rewind to the beginning of current track, else : start playing.
    def play
    end
    
    # Toggle the current track repeat.
    # true to repeat the current track, false to stop repeating.
    def repeat(bool)
    end
    
    # Return the playing status of "Media Player" 
    # Mpris::Player::PLAYING / Mpris::Player::PAUSED / Mpris::Player::STOPPED
    def status
    end
    
    # Gives all metadata available for the current item.
    # Metadata is returned as key,values pairs in a Hash.
    def metadata
    end
    
    # Check if there is a next track, or at least something that equals to it 
    # (that is, the remote can call the 'Next' method on the interface, and 
    # expect something to happen.
    def can_go_next?
    end
    
    # Check if there is a previous track
    def can_go_prev?
    end
    
    # Check if it is possible to pause. This might not always be possible, 
    # and is a hint for frontends as to what to indicate
    def can_pause?
    end
    
    # Whether playback can currently be started. This might not be the case 
    # if e.g. the playlist is empty in a player, or similar conditions.
    def can_play?
    end
    
    # Whether seeking is possible with the currently played stream.
    def can_seek?
    end
    
    # Whether metadata can be acquired for the currently played stream/source.
    def can_provide_metadata?
    end
    
    # Whether the media player can hold a list of several items.
    def has_tracklist?
    end
    
    # Sets the volume (argument must be in [0;100])
    def volume=(vol)
    end
    
    # Returns the current volume (must be in [0;100])
    def volume
    end
    
    # Sets the playing position (argument must be in [0;<track_length>] 
    # in milliseconds)
    def position=(time)
    end
    
    # Returns the playing position (will be [0;<track_length>] in milliseconds)
    def position
    end
  
  end

end