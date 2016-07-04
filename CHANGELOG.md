# Changelog

## 2.0.1 (2016-02-17)
* Add ordering Versionlock -> Package
* Sort manifest, formatting & Tests

## 2.0.0 (2016-02-08)
* Do the package -> file_line dependency by resource collection. This allows to install a package only once and from then on only the versionlock and the fact will be managed by puppet. A useful case is ie. ScaleIO where we absolutly don't want an upgrade by Puppet, as this would break the ScaleIO cluster and end in data loss. Example:

```puppet
package_verifiable{'myPackage':
  version        => '1.32.4',
  manage_package => !$package_mypackage_version,
}
```
