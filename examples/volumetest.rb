#!/usr/bin/ruby
#
# Copyright (C) 2008 by Nicholas J Humfrey
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'


mpris = Mpris.new

# Test to set and get the playback volume of the media player
for vol_in in 0..150
  mpris.player.volume = vol_in
  vol_out = mpris.player.volume
  p [vol_in, vol_out]
end
