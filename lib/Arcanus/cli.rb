require "thor"
require "arcanus/template"

module Arcanus
  class CLI < ::Thor
    desc "version", "Show version"
    def version
      say "Arcanus #{Arcanus::VERSION}"
    end

    desc "create NAME", "Create a project"
    def create(name)
      say "Creating #{name}"

      ::Arcanus::Template.new([name]).invoke_all
    end
  end
end
