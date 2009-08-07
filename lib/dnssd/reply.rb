##
# DNSSD::Reply is used to return information

class DNSSD::Reply

  ##
  # The service domain

  attr_reader :domain

  ##
  # Flags describing the reply, see DNSSD::Flags

  attr_reader :flags

  ##
  # The interface on which the service is available

  attr_reader :interface

  ##
  # The service name

  attr_reader :name

  ##
  # The port for this service

  attr_reader :port

  ##
  # The service associated with the reply, see DNSSD::Service

  attr_reader :service

  ##
  # The hostname of the host provide the service

  attr_reader :target

  ##
  # The service's primary text record

  attr_reader :text_record

  ##
  # The service type

  attr_reader :type

  def self.from_service(service, flags)
    reply = new
    reply.instance_variable_set :@service, service
    reply.instance_variable_set :@flags, DNSSD::Flags.new(flags)
    reply
  end

  ##
  # The full service domain name, see DNSS::Service#fullname

  def fullname
    DNSSD::Service.fullname @name.gsub("\032", ' '), @type, @domain
  end

  def inspect
    "#<%s:0x%x %p type: %s domain: %s interface: %s flags: %s>" % [
      self.class, object_id, @name, @type, @domain, @interface, @flags
    ]
  end

  def set_fullname(fullname)
    fullname = fullname.scan(/(?:[^\\.]|\\\.)+/).map do |part|
      part.gsub "\\.", '.'
    end

    @name   = fullname[0]
    @type   = fullname[1,   2].join '.'
    @domain = fullname.last + '.'
  end

  def set_names(name, type, domain)
    set_fullname [name, type, domain].join('.')
  end

end
