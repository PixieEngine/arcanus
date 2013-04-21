require "thor"
require "thor/group"

module Arcanus
  class Template < ::Thor::Group
    include Thor::Actions

    source_root File.join(File.dirname(__FILE__), "templates")

    argument :location, :type => :string

    # TODO Put html/js/css into directory for Sinatra

    def generate_files!
      # Copy project template
      directory "project", location

      %w[
        Gemfile
      ].each do |file|
        template file, File.join(location, file)
      end

      # Make scripts executable
      # TODO: Why doesn't directory copy keep executable bit?
      # TODO: Why doesn't chmod "*" work?
      script_dir = File.join(location, "script")
      inside(script_dir) do
        chmod "server", 0755
      end
    end

    def setup!
      inside(location) do
        fn = -> { run('bundle install') }

        if defined? Bundler
          Bundler.with_clean_env(&fn)
        else
          fn.call
        end
      end
    end
  end
end
