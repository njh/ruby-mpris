#!/usr/bin/ruby
#
# Script to display name of the media player and supported MPRIS API version.
#
# Author::    Nicholas J Humfrey  (mailto:njh@aelius.com)
# Copyright:: Copyright (c) 2008 Nicholas J Humfrey
# License::   Distributes under the same terms as Ruby
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'


mpris = MPRIS.new
puts "Identity: #{mpris.identity}"
puts "MPRIS API Version: #{mpris.mpris_version}"
