#!/usr/bin/ruby

require 'dbus'

MPRIS_SERVICE_PREFIX = 'org.mpris'
MPRIS_INTERFACE = 'org.freedesktop.MediaPlayer'


class Mpris
  attr_reader :dbus, :service, :root_iface
  
  def initialize( dbus_address=nil, service_name=nil )

    if dbus_address.nil?
      # Use the default session bus
       @dbus = DBus::SessionBus.new
    else
      @dbus = DBus::Connection.new(dbus_address)
      @dbus.connect
      #self.send_hello
    end
    
    # Look for service name, if one isn't given
    if service_name.nil?
      service_names = @dbus.proxy.ListNames[0]
      service_names.each { |n|
        if (n =~ /^org.mpris/)
          service_name = n
          break
        end
      }
      
      # Did we find one?
      if service_name.nil?
        raise "No MPRIS service found on D-Bus"
      end
    end
    
    # Get the service
    @service = @dbus.service(service_name)
    
    # Check the service implements the MediaPlayer interface
    root_object = @service.object("/")
    root_object.introspect
    unless root_object.has_iface? MPRIS_INTERFACE
      raise "#{service_name} does not implement the MediaPlayer interface."
    end
    @root_iface = root_object[MPRIS_INTERFACE]
    
  end


  def identity
    return @root_iface.Identity
  end
  
  def quit
    @root_iface.Quit
  end
  
  def mpris_version
    return @root_iface.MprisVersion
  end
  

end
