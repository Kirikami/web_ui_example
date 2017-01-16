require 'yaml'

#all methods in here are singleton methods
class Configuration
  PROFILE ||= ENV['CUCUMBER_ENV'] ? ENV['CUCUMBER_ENV'] : 'default'

  def self.[] (key)
    if config.has_key? key
      config[key]
    else
      cur = config
      key.split('.').each do |key_part|
        if cur.has_key? key_part
          cur = cur[key_part]
        else
          return nil
        end
      end
      cur
    end
  end

  def self.name
    @name ||= ''
  end

  def self.config (name='local')
    file = File.expand_path(File.dirname(__FILE__) + '/../../config/config.yml')
    @config ||= YAML.load(ERB.new(File.read(file)).result)[name]
  end

  def self.load (name)

    return unless (self.name == '' || self.name== name)

    #main config file

    raise "Could not locate a configuration named \"#{name}\"" unless config(name)

    #override with env parameters (probably provided on command line)
    if ENV['CUCUMBER_CONFIG']
      ENV['CUCUMBER_CONFIG'].split(';').each do |option|
        key, value = option.split(':', 2)
        value.strip!
        if value.start_with?(':')
          value[0] = ''
          value = value.to_sym
        end
        value = false if value =~ /^(false|no|n)$/i
        value = true if value =~ /^(true|yes|y)$/i
        self.[]= key, value
      end
    end
  end

  def self.[]= (key, value)
    cur = config
    key_parts = key.split('.')
    key_parts[0..-2].each do |key_part|
      if (!cur.has_key? key_part) || cur[key_part].nil?
        cur[key_part] = {}
      end
      cur = cur[key_part]
    end
    cur[key_parts.last] = value
  end

  def self.has_key? (key)
    if config.has_key? key
      true
    else
      cur = config
      key.split('.').each do |key_part|
        if cur && (cur.has_key? key_part)
          cur = cur[key_part]
        else
          return false
        end
      end
      return true
    end
  end

  def self.fetch (key, default=0)
    if self.has_key? key
      self.[] key
    else
      default
    end
  end

  def self.merge! (config_hash)
    config_hash.each_pair do |k, v|
      self._deep_merge! k, v
    end
  end

  protected

  def self._deep_merge! (key, value)
    if value.is_a?(Hash)
      value.each_pair do |k, v|
        self._deep_merge! "#{key}.#{k}", v
      end
    else
      self.[]= key, value
    end
  end


end

Configuration.load(ENV['CUCUMBER_ENV'] ? ENV['CUCUMBER_ENV'] : 'local')
