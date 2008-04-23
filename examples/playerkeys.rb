#!/usr/bin/ruby
#
# Copyright (C) 2008 by Nicholas J Humfrey
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'rubygems'
require 'highline'
require 'mpris'


mpris = Mpris.new

puts "p:play space:pause s:stop [:prev ]:next x:exit"

begin
  c = HighLine::SystemExtensions::get_character

  case c
    when 112 then
      puts "Play"
      mpris.player.play
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
  end
    
end until (c == 120)
