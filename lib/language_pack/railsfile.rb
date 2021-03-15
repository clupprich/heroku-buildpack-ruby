require 'securerandom'
require "language_pack"
require "language_pack/rails5"

class LanguagePack::Railsfile < LanguagePack::Ruby
  # @return [Boolean] true if it's a Railsfile
  def self.use?
    instrument "railsfile.use" do
      File.file?("app.rb")
    end
  end

  def name
    "Ruby/Railsfile"
  end

  def default_config_vars
    instrument "railsfile.default_config_vars" do
      super.merge({
        "RACK_ENV" => env("RACK_ENV") || "production",
        "RAILS_ENV" => env("RAILS_ENV") || "production"
      })
    end
  end

  def default_process_types
    {
      "web" => "ruby app.rb"
    }
  end

  def compile
    instrument "railsfile.compile" do
      # no-op
    end
  end
end
