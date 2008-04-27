#!/usr/bin/ruby
#
# Script to display the cababilites of the media player.
#
# Author::    Nicholas J Humfrey  (mailto:njh@aelius.com)
# Copyright:: Copyright (c) 2008 Nicholas J Humfrey
# License::   Distributes under the same terms as Ruby
#
  
$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'


mpris = MPRIS.new
puts "Checking capabilites:"
puts " can_go_next?: #{mpris.player.can_go_next?}"
puts " can_go_prev?: #{mpris.player.can_go_prev?}"
puts " can_pause?: #{mpris.player.can_pause?}"
puts " can_play?: #{mpris.player.can_play?}"
puts " can_seek?: #{mpris.player.can_seek?}"
puts " can_provide_metadata?: #{mpris.player.can_provide_metadata?}"
puts " has_tracklist?: #{mpris.player.has_tracklist?}"
