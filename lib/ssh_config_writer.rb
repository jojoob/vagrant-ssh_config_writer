begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant NFS Guest plugin must be run within Vagrant."
end

require 'ssh_config_writer/version'
require 'ssh_config_writer/plugin'
