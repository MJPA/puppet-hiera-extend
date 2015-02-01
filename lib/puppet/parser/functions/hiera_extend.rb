module Puppet::Parser::Functions
  newfunction(:hiera_extend, :type => :rvalue, :doc => <<-'ENDHEREDOC') do |args|
    A wrapper around hiera() to merge the value to the defaults if both are hashes.

    For example:

        $defaults = {'one' => 1, 'two', => 2}
        # Assume 'key' has a value of {'one' => 5}
        $merged_hash = hiera_extend('key', $defaults)
        # The resulting hash is equivalent to:
        # $merged_hash =  {'one' => 5, 'two' => 2}

    ENDHEREDOC

    if args.length < 2
      raise Puppet::ParseError, ("hiera_extend(): wrong number of arguments (#{args.length}; must be at least 2)")
    end

    # Do the normal hiera lookup
    Puppet::Parser::Functions.autoloader.loadall
    hiera_value = function_hiera(args)

    # Both returned value and default a hash?
    if hiera_value.is_a? Hash and args[1].is_a? Hash
      final_value = args[1]
      final_value.merge! hiera_value
    else
      final_value = hiera_value
    end

    # Return the final value
    final_value
  end
end
