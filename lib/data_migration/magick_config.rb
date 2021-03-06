# Magick %)
module DataMigration
  module MagickConfig
    class << self
      def read_configuration
        config_file = Rails.root.join("config", "mongoid.yml")
        config = YAML.load(ERB.new(File.read(config_file)).result)[Rails.env] if config_file.file?
        return config if config

        if ENV['HEROKU'] || ENV['USE_ENV']
          # No mongoid.yml file. Use ENV variable to define your MongoDB
          # configuration
          if mongo = ENV['MONGOLAB_URI'] || ENV['MONGOHQ_URL'] || ENV['MONGODB_URL']
            settings = URI.parse(mongo)
            database_name = settings.path.gsub(/^\//, '')
          else
            settings = OpenStruct.new({
                                          :host => ENV['MONGOID_HOST'],
                                          :port => ENV['MONGOID_PORT'],
                                          :user => ENV['MONGOID_USERNAME'],
                                          :password => ENV['MONGOID_PASSWORD']
                                      })
            database_name = ENV['MONGOID_DATABASE']
          end

          hash = {
              sessions: {
                  default: {
                      database: database_name,
                      hosts: [ "#{settings.host}:#{settings.port}" ]
                  }
              }
          }

          if settings.user && settings.password
            hash[:sessions][:default][:username] = settings.user
            hash[:sessions][:default][:password] = settings.password
          end

          return hash.stringify_keys
        end

        {}
      end
    end
  end
end
