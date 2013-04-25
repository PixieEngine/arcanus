require "thor"
require "thor/group"

module Arcanus
  class Template < ::Thor::Group
    include Thor::Actions

    source_root File.join(File.dirname(__FILE__), "templates")

    argument :location, :type => :string

    def generate_files!
      # Copy project template
      directory "project", location

      %w[
        Gemfile
      ].each do |file|
        template file, File.join(location, file)
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

    # TODO Generate static docs
  end
end
