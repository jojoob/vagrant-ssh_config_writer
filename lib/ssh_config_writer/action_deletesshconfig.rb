require "log4r"

module VagrantPlugins
  module SshConfigWriter
    class ActionDeleteSSHConfig

      def initialize(app, env)
        @app    = app
        @logger = Log4r::Logger.new("vagrant::ssh_config_writer")
      end

      def call(env)
        sshconfigfile = "#{env[:root_path]}/ssh_config"
        if File.exist?(sshconfigfile)
          @logger.info("Delete ssh_config file (#{sshconfigfile})")
          File.delete(sshconfigfile)
        else
          @logger.warn("ssh_config file (#{sshconfigfile}) does not exist. Skip deleting it.")
        end
      end
    end
  end
end
