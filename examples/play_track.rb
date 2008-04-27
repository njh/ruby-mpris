#!/usr/bin/ruby
#
# Script to immediately start playing a track in the media player.
#
# Author::    Nicholas J Humfrey  (mailto:njh@aelius.com)
# Copyright:: Copyright (c) 2008 Nicholas J Humfrey
# License::   Distributes under the same terms as Ruby
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'

raise "Usage: play_track.rb <filename>" unless (ARGV.size == 1)

mpris = MPRIS.new
mpris.tracklist.add_track( ARGV[0], true )
