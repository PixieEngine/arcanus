require "thor"
require "thor/group"

module Arcanus
  class Template < ::Thor::Group
    include Thor::Actions

    source_root File.join(File.dirname(__FILE__), "templates")

    argument :location, :type => :string

    def generate_files!
      %w[
        Gemfile
        Rakefile
      ].each do |file|
        template file, File.join(location, file)
      end
    end

    def setup!
      inside(location) do
        run('bundle install')
      end
    end
  end
end
