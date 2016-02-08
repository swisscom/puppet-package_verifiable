# install a package in a certain version
# and provide a fact to verify its version
define package::verifiable(
  $manage_package = true,
  $version = 'installed',
  $epoch = '',
){
  require package::base
  $escaped_name = downcase(regsubst($name,'-','_', 'G'))
  if $manage_package {
    package{$name:
      ensure => $version,
    }
  }

  Package<| title == $name |> -> File_line["${name}_version_fact"]

  file_line{
    "${name}_version_fact":
      line  => "package_${escaped_name}_version=${version}",
      match => "^package_${escaped_name}_version=",
      path  => $package::base::file_path,
  }
  package::yum::versionlock{
    $name:
      ensure => $version,
      epoch  => $epoch
  }
}
