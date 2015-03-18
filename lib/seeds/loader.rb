require 'csv'

module Seeds
  class Loader
    def initialize(klass, path)
      @klass = klass
      @path = path
      puts "Loading #{@klass} from #{@path}"
      @field_fetchers = {}
    end

    def load
      CSV.open(@path, "r", :headers => true) do |csv|
        csv.each do |row|
          attributes = row.to_hash
          record = @klass.new
          attributes.each do |key, value|
            attributes[key] = self.value_from_spreadsheet(key.to_sym, value)
          end
          
          attributes.each do |key, value|
            record.send("#{key}=", value) unless (value != record.value && value == "Translation missing")
          end
          begin
            record.save!
          rescue => e
            puts "Error with row #{row.inspect}"
            raise e
          end
        end
      end
    end

    def foreign_key(name, field_name)
      begin
        self.value_for_field("#{name}_id".to_sym) do |value|
          value.blank? ? nil : name.to_s.classify.constantize.where(field_name => value).first.id rescue nil
        end
      rescue
        puts $!
      end
    end

    def value_for_field(name, &block)
      @field_fetchers[name] = block
    end

    def value_from_spreadsheet(key, value)
      fetcher = @field_fetchers[key]
      if fetcher
        result = fetcher.call(value)
        result
      else
        value
      end
    end

    def self.script_directory
      @script_directory
    end

    def self.load(klass, path=nil, &block)
      path ||= klass.name.underscore.pluralize
      loader = self.new(klass, File.join(script_directory, path + '.csv'))
      if block_given?
        loader.instance_eval(&block)
      end
      loader.load
    end

    def self.seed(script_path, &block)
      @script_directory = File.dirname(script_path)
      ActiveRecord::Base.transaction do
        self.instance_eval(&block)
     end
    end
  end
end