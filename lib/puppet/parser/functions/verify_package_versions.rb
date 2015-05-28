#
# verify_package_versions
#
#
module Puppet::Parser::Functions
  newfunction(:verify_package_versions, :type => :rvalue, :doc => <<-EOS
    Verifies a package & version or a hash of packages & versions against a set of installed versions.
    It returns true if all are the same or false if one of them does not match.
    EOS
  ) do |args|
    a = args.to_a
    if a.size == 2
      packages = { a[0] => a[1] }
    elsif a.size == 1
      packages = a.first
      raise(Puppet::ParseError, "verify_package_versions(): Argument is not a hash") unless packages.is_a?(Hash)
    else
      raise(Puppet::ParseError, "verify_package_versions(): Wrong number of arguments " +
        "given (#{a.size} for 1 or 2)")
    end

    result = true
    packages.each do |package, version|
      curr_version = lookupvar("package_#{package.gsub('-','_')}_version".downcase)
      result = false if curr_version != version
    end
    result
  end
end

# vim: set ts=2 sw=2 et :
