module Arcanus
  module Tasks
    extend Rake::DSL

    def self.install
      desc "Remove compiled assets"
      task :clean do
        `rm -r build`
      end
    end
  end
end

Arcanus::Tasks.install
