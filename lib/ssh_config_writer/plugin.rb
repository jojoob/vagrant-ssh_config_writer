require "vagrant"

module VagrantPlugins
  module SshConfigWriter
    class Plugin < Vagrant.plugin("2")
      name "ssh_config_writer"
      description <<-EOF
      The SSH config writer writes the ssh config of the current machine to a file in the Vagrantfile location.
      EOF
      
      action_hook("write_ssh_config", :machine_action_up) do |hook|
        require_relative "action_writesshconfig"
        hook.append(ActionWriteSSHConfig)
      end

      action_hook("delete_ssh_config", :machine_action_halt) do |hook|
        require_relative "action_deletesshconfig"
        hook.append(ActionDeleteSSHConfig)
      end
    end
  end
end
