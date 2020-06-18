# package_verifiable

[![Build Status](https://travis-ci.org/swisscom/puppet-package_verifiable.svg?branch=master)](https://travis-ci.org/swisscom/puppet-package_verifiable)

This is the package_verifiable module.

The idea is that we have a way to check within the catalog whether a package
currently installed matches the one we want to install.

For that we place a custom fact that records the installed version and then we
can use a function to verify whether there will be a change.


## Table of contents

1. [Parameters](#parameters)
1. [Usage](#usage)
1. [Support](#support)


## Parameters

### Main class (package_verifiable)

**package_verifiable::version** (Optional)
* Description: Set the package version
* Type: String
* Default value: `installed`

**package_verifiable::epoch** (Optional)
* Description: Set the package epoch
* Type: String
* Default value: ` `

**package_verifiable::manage_package** (Optional)
* Description: Wether to ensure the package version with Puppet
* Type: Boolean
* Default value: `true`

**package_verifiable::manage_dependency** (Optional)
* Description: Wether to manage the package dependencies too
* Type: Boolean
* Default value: `true`

### Yum versionlock class (package_verifiable::yum::versionlock)

**package_verifiable::yum::versionlock::ensure** (Mandatory)
* Description: Wether to ensure the versionlock or not
* Type: String
* Default value: `n/a`

**package_verifiable::yum::versionlock::epoch** (Optional)
* Description: Package epoch to ensure
* Type: String
* Default value: ` `


## Usage

```puppet
$pkg_version = lookup('some_package_version','1.0-1')

package_verifiable {'some-package':
  version => $pkg_version,
}

if $package_some_package_version and !verify_package_versions('some-package',$pkg_version) {
  exec {'systemctl stop some-service && rm -rf /opt/my_package/service':
    before => Package['some-package'],
  }
}
```
If the current deployed package does not match the version on the system the
exec will be included into the catalog and hence triggered. By playing with
before/require you will be able to add pre-/post-hooks to the package
management.
Note: The fact is `undef` if the package is not yet installed.

If the package itself is managed in another module that should not be using the
package module, we can simply add the wrapper here, without managing the
package itself:
```puppet
$pkg_version = lookup('some_package_version','1.0-1')

package_verifiable {'some-package':
  version        => $pkg_version,
  manage_package => false,
}
```

You can manage multiple packages if they share the same version.
```puppet
$packages = ['myapp', 'myapp-common', 'myapp-libs']

package_verifiable {$packages:
  version => $pkg_version,
}
```

## Support

Please log tickets and issues at our
[Projects site](https://github.com/swisscom/puppet-package_verifiable/issues)

MIT license, see [LICENSE.md](LICENSE.md)
