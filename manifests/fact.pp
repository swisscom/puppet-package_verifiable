#
define package_verifiable::fact (
  $package = $title,
  $version = $package_verifiable::version,
) {
  $escaped_name = downcase(regsubst($package,'-','_', 'G'))

  file_line {"${package}_version_fact":
    line  => "package_${escaped_name}_version=${version}",
    match => "^package_${escaped_name}_version=",
    path  => $package_verifiable::base::file_path,
  }
}
