require "thor"
require "thor/group"

module Arcanus
  class Template < ::Thor::Group
    include Thor::Actions

    source_root File.join(File.dirname(__FILE__), "templates")

    argument :location, :type => :string

    # create Gemfile and bundle
    def generate_bundle!
      template "Gemfile", File.join(location, "Gemfile")

      inside(location) do
        run('bundle install')
      end
    end

    # create Rakefile
    def create_rakefile!
      template "Rakefile", File.join(location, "Rakefile")
    end
  end
end
