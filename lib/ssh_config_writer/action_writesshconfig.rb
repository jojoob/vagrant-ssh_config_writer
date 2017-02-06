require "log4r"

module VagrantPlugins
  module SshConfigWriter
    class ActionWriteSSHConfig

      def initialize(app, env)
        @app    = app
        @logger = Log4r::Logger.new("vagrant::ssh_config_writer")
      end

      def call(env)
        ssh_info = env[:machine].ssh_info
        raise Vagrant::Errors::SSHNotReady if ssh_info.nil?

        variables = {
          host_key: env[:machine].name || "vagrant",
          ssh_host: ssh_info[:host],
          ssh_port: ssh_info[:port],
          ssh_user: ssh_info[:username],
          keys_only: ssh_info[:keys_only],
          paranoid: ssh_info[:paranoid],
          private_key_path: ssh_info[:private_key_path],
          log_level: ssh_info[:log_level],
          forward_agent: ssh_info[:forward_agent],
          forward_x11:   ssh_info[:forward_x11],
          proxy_command: ssh_info[:proxy_command],
          ssh_command:   ssh_info[:ssh_command],
          forward_env:   ssh_info[:forward_env],
        }

        # Render the template and output directly to STDOUT
        template = "commands/ssh_config/config"
        config   = Vagrant::Util::TemplateRenderer.render(template, variables)
        env[:machine].ui.machine("ssh-config", config)

        sshconfigfile = "#{env[:root_path]}/ssh_config"
        @logger.info("Write ssh_config file to #{sshconfigfile}")
        File.open(sshconfigfile, 'w') do |file|
          file.write(config)
        end
      end
    end
  end
end
