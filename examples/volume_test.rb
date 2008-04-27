#!/usr/bin/ruby
#
# Script to test getting/setting the playback volume of the media player.
#
# Author::    Nicholas J Humfrey  (mailto:njh@aelius.com)
# Copyright:: Copyright (c) 2008 Nicholas J Humfrey
# License::   Distributes under the same terms as Ruby
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'


mpris = MPRIS.new

# Test to set and get the playback volume of the media player
for vol_in in 0..150
  mpris.player.volume = vol_in
  vol_out = mpris.player.volume
  puts "Setting volume to: #{vol_in}, got back: #{vol_out}."
end
