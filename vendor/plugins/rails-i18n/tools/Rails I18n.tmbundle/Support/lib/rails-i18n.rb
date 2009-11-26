require ENV['TM_SUPPORT_PATH'] + '/lib/ui.rb'
require File.join(File.dirname(__FILE__), 'dictionary')
require File.join(File.dirname(__FILE__), 'yaml_waml')
require 'pstore'

class Hash
  def deep_merge(other)
    # deep_merge by Stefan Rusterholz, see http://www.ruby-forum.com/topic/142809
    merger = proc { |key, v1, v2| (Hash === v1 && Hash === v2) ? v1.merge(v2, &merger) : v2 }
    merge(other, &merger)
  end

  def set(keys, value)
    key = keys.shift
    if keys.empty?
      self[key] = value
    else
      self[key] ||= {}
      self[key].set keys, value
    end
  end

  # copy of ruby's to_yaml method, prepending sort.
  # before each so we get an ordered yaml file
  def to_yaml( opts = {} )
    YAML::quick_emit( self, opts ) do |out|
      out.map( taguri, to_yaml_style ) do |map|
        sort.each do |k, v| #<- Adding sort.
          map.add( k, v )
        end
      end
    end
  end
end

class Object
  def blank?
    self.nil? || self == false || (self.is_a?(String) && self.gsub(/\s/, '').empty?)
  end
end

PREFS_FILE = "~/Library/Preferences/com.macromates.textmate.rails_i18n.pstore"

class Translate

  @@prefs = PStore.new(File.expand_path(PREFS_FILE))
  @@project_dir = ENV['TM_PROJECT_DIRECTORY']
  @@t_path_plain = File.join(@@project_dir, 'log', 'translations')
  @@t_path_yaml = File.join(@@project_dir, 'log', 'translations.yml')
  @@original_text = ENV['TM_SELECTED_TEXT']

  def self.execute
    return if @@original_text.nil?

    key = self.get_key
    if key.blank?
      print @@original_text
      return
    end

    type = self.get_type
    if type.blank?
      print @@original_text
      return
    end

    case type
    when 'html'
      replacement = "<%=#{self.translation_method} '#{key}' %>"
    when 'string'
      replacement = "\#{#{self.translation_method}('#{key}')}"
    else
      replacement = "#{self.translation_method}('#{key}')"
    end

    translation = ENV['TM_SELECTED_TEXT'].gsub(/^\s*("|')|("|')\s*$/, '')
    if self.add_yaml_translation(key, translation)
      self.add_plain_translation(key, translation)
      print replacement
    else
      print @@original_text
    end
  end

  def self.get_key
    key = TextMate::UI.request_string :title => 'Key',
                                      :prompt => 'Key',
                                      :default => self.get_pref('last_used_key')
    self.set_pref('last_used_key', key) unless key.blank?
    key
  end

  def self.get_type
    type = TextMate::UI.request_string :title => 'Type',
                                       :prompt => 'html, string, or ruby',
                                       :default => self.get_pref('last_used_type')
    self.set_pref('last_used_type', type) unless type.blank?
    type
  end

  def self.add_plain_translation(key, text)
    log_file = File.open(@@t_path_plain, 'a+')
    log_file.puts "#{key}: #{text}"
  end

  def self.add_yaml_translation(key, text)
    keys = ['en'] + key.split('.')
    data = { 'en' => {} }
    data.set keys.dup, text
    if File.exists?(@@t_path_yaml)
      file_content = File.open(@@t_path_yaml, 'r') { |f| f.read }
      unless file_content.blank?
        parsed_yaml = YAML.load(file_content)
        return false unless self.confirm_if_key_already_in_use(keys, parsed_yaml, text)
        data = parsed_yaml.deep_merge(data)
      end
    end
    File.open(@@t_path_yaml, 'w+') { |f| f.write YAML.dump(data) }
    true
  end

  def self.confirm_if_key_already_in_use(keys, data, text)
    current_value = nil
    begin
      keys.each { |key| data = data[key] }
      current_value = data unless data.blank?
    rescue; end
    confirmed = true
    unless current_value.nil?
      confirmed = TextMate::UI.request_confirmation :button1 => 'Overwrite', :button2 => 'Cancel',
                                                    :title => 'You have already used this translation key',
                                                    :prompt => "This translation key is already in use.\n" +
                                                               "It's current value is:\n" +
                                                               "\t#{current_value}\n" +
                                                               "Would you like to overwrite it with the follow?\n" +
                                                               "\t#{text}"
    end
    confirmed
  end

  def self.translation_method
    current_file = ENV['TM_FILEPATH'].gsub(@@project_dir, '')
    translate_cmd = (current_file =~ /^\/app\/(controllers|helpers|views)\//) ? 't' : 'I18n.t'
  end

  def self.get_pref(key)
    pref = @@prefs.transaction { @@prefs[key] }
    (pref || '')
  end

  def self.set_pref(key, value)
    @@prefs.transaction { @@prefs[key] = value }
  end

end
