#!/usr/bin/ruby

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'


mpris = Mpris.new
puts "Identity: #{mpris.identity}"
puts "MPRIS API Version: #{mpris.mpris_version}"
