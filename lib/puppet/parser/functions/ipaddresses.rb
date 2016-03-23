module Puppet::Parser::Functions
    newfunction(:ipaddresses, :type => :rvalue, :doc => <<-EOS
Returns all ip addresses of network interfaces (except lo) found by facter.
EOS
    ) do |args|
        interfaces = function_getvar(['interfaces'])

        # In Puppet v2.7, lookupvar returns :undefined if the variable does
        # not exist.  In Puppet 3.x, it returns nil.
        # See http://docs.puppetlabs.com/guides/custom_functions.html
        return false if (interfaces.nil? || interfaces == :undefined)

        result = []
        if interfaces.count(',') > 0
            interfaces = interfaces.split(',')
            interfaces.each do |iface|
                if ! iface.include?('lo')
                    ipaddr = function_getvar(["ipaddress_#{iface}"])
                    ipaddr6 = function_getvar(["ipaddress6_#{iface}"])
                    if ipaddr and (ipaddr!= :undefined)
                        result << ipaddr
                    end
                    if ipaddr6 and (ipaddr6!= :undefined)
                        result << ipaddr6
                    end
                end
            end
        else
            if ! interfaces.include?('lo')
                ipaddr = function_getvar(["ipaddress_#{interfaces}"])
                ipaddr6 = function_getvar(["ipaddress6_#{interfaces}"])
                if ipaddr and (ipaddr!= :undefined)
                    result << ipaddr
                end
                if ipaddr6 and (ipaddr6!= :undefined)
                    result << ipaddr6
                end
            end
        end

        return result
    end
end
