#!/usr/bin/ruby
#
# Script to display the metadata hash for the currently playing track.
#
# Author::    Nicholas J Humfrey  (mailto:njh@aelius.com)
# Copyright:: Copyright (c) 2008 Nicholas J Humfrey
# License::   Distributes under the same terms as Ruby
#

$:.unshift File.dirname(__FILE__)+'/../lib'

require 'mpris'
require 'pp'

mpris = Mpris.new
pp mpris.player.metadata
