require 'yaml'

module Fj
  class ::Hash
    def deep_merge(second)
      merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
      self.merge(second, &merger)
    end
  end

  # fix ARGV when used as fj subcommand
  def self.fixargv
    if ENV['_SUB_COMMAND_ROOT']
      fj = {
        :root   => ENV['_SUB_COMMAND_ROOT'],
        :subcmd => ENV['_SUB_COMMAND_FILE'],
        :vars   => ENV['_SUB_COMMAND_VARS'],
      }

      fj[:cmd] = File.basename(fj[:root]).gsub(/^fj-/, '')
      fj[:params] = fj[:vars].split(' ')
      fj[:params].delete(fj[:cmd])
      fj[:params].delete(fj[:subcmd])

      while ARGV[0] == fj[:subcmd]
        ARGV.shift
      end

      ARGV
    end
  end

  # manage config file for fj
  def self.config
    cfgdef = File.join(ENV['_FJ_ROOT'], 'share', 'ruby', 'config', 'defaults.yaml')
    cfgusr = File.join(ENV['HOME'], '.fj-config.yaml')

    # loading defaults
    defaults = {}
    if File.exists?(cfgdef)
      defaults = YAML::load(File.open(cfgdef))
    end

    # loading custom settings
    config = {}
    if File.exists?(cfgusr)
      config = YAML::load(File.open(cfgusr))
    end

    # overwrite defaults with user specific config
    config = defaults.deep_merge(config)
    config
  end
end
