#!/usr/bin/ruby
#
# Script to test the repeat/loop/random getters and setters.
#
# Author::    Nicholas J Humfrey  (mailto:njh@aelius.com)
# Copyright:: Copyright (c) 2008 Nicholas J Humfrey
# License::   Distributes under the same terms as Ruby
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'


mpris = MPRIS.new


puts "Enabling looping."
mpris.tracklist.loop = true
puts " Looping status: #{mpris.tracklist.loop}"

puts "Disabling looping."
mpris.tracklist.loop = false
puts " Looping status: #{mpris.tracklist.loop}"

puts "Enabling random."
mpris.tracklist.random = true
puts " Random status: #{mpris.tracklist.random}"

puts "Disabling random."
mpris.tracklist.random = false
puts " Random status: #{mpris.tracklist.random}"

puts "Enabling repeating."
mpris.player.repeat = true
puts " Looping status: #{mpris.player.repeat}"

puts "Disabling repeating."
mpris.player.repeat = false
puts " Looping status: #{mpris.player.repeat}"


puts "Stopping playback..."
mpris.player.stop
puts " MPRIS::Player::STOPPED: #{MPRIS::Player::STOPPED}"
puts " Playback status: #{mpris.player.status}"

puts "Starting playback..."
mpris.player.play
puts " MPRIS::Player::PLAYING: #{MPRIS::Player::PLAYING}"
puts " Playback status: #{mpris.player.status}"

# Current crashes VLC:
#puts "Pausing playback..."
#mpris.player.pause
#puts " MPRIS::Player::PAUSED: #{MPRIS::Player::PAUSED}"
#puts " Playback status: #{mpris.player.status}"
