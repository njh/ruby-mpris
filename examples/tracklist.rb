#!/usr/bin/ruby
#
# Copyright (C) 2008 by Nicholas J Humfrey
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'

mpris = Mpris.new

# Get the number of tracks on the tracklist
len = mpris.tracklist.length
current = mpris.tracklist.current_track

i=0
while (i<len) do

  # Print asterisk next to currently playing track
  if (i==current)
    print "* "
  else
    print "  "
  end
  
  # There is a bug in VLC, which makes tracklist start at 1
  meta = mpris.tracklist.metadata(i+1)
  puts "#{i}: #{meta['URI']} (#{meta['artist']} - #{meta['title']})"
  i+=1
end
