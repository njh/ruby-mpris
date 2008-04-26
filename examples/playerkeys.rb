#!/usr/bin/ruby
#
# Interactive console script to control the media player.
#
# Author::    Nicholas J Humfrey  (mailto:njh@aelius.com)
# Copyright:: Copyright (c) 2008 Nicholas J Humfrey
# License::   Distributes under the same terms as Ruby
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'rubygems'
require 'highline'
require 'mpris'


mpris = Mpris.new

puts "p:play space:pause s:stop [:prev ]:next q:quit"
puts "+:volume_up -:volume_down x:exit"

begin
  c = HighLine::SystemExtensions::get_character

  case c
    when 112 then
      puts "Play"
      mpris.player.play
    when 113 then
      puts "Quit"
      mpris.quit
    when 32 then
      puts "Pause"
      mpris.player.pause
    when 115 then
      puts "Stop"
      mpris.player.stop
    when 91 then
      puts "Previous"
      mpris.player.previous
    when 93 then
      puts "Next"
      mpris.player.next
    when 43 then
      vol = mpris.player.volume+5
      puts "Volume Up (#{vol})"
      mpris.player.volume = vol
    when 45 then
      vol = mpris.player.volume-5
      puts "Volume Down (#{vol})"
      mpris.player.volume = vol
    when 114 then
      repeat = !mpris.player.repeat
      puts "Repeat=#{repeat}"
      mpris.player.repeat = repeat
    else
      puts "Unhandled key press: #{c}"
   end
    
end until (c == 120)
