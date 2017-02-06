vagrant-ssh_config_writer
=========================

Vagrant plugin that writes the SSH config of a machine to a file.

Currently the plugin has no configuration options. If installed it writes the ssh config which can also be retrieved by the *vagrant ssh-config* command to a file called ssh_config at the Vagrantfile location (`root_path`) on *vagrant up*.
On *vagrant halt* The file will be  deleted.

This is usefull because establishing the SSH connection to the machien via `ssh -L ssh_config` is much faster than `vagrant ssh`
