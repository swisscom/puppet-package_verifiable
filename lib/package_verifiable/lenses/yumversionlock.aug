module YumVersionlock =

  autoload xfm

  let epoch = label "epoch" . store /[0-9]+/ . del ":" ":"
  let name = key /[A-Za-z0-9_+.-]+/ 
  let version = label "version" . store /[A-Za-z0-9_+.]+-[A-Za-z0-9_+.]+/
  let dash = del "-" "-"
  let wildcard = del /(\.\*)?/ ".*"
  let entry = [ [ epoch ]? . name . dash . [ version ] . wildcard . Util.eol ]
  let lns = ( Util.empty | Util.comment | entry )*

  let filter = incl "/etc/yum/pluginconf.d/versionlock.list" . Util.stdexcl
  let xfm = transform lns filter
