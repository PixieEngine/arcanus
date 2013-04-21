module Arcanus
  module Tasks
    extend Rake::DSL

    def self.install
      desc "Remove compiled assets"
      task :clean do
        `rm -r build`
      end

      desc "Compile files to create a build"
      task :build do
        main_file = "src/main.coffee"
        src_files = (Dir["src/**/*.coffee"] - [main_file]) + [main_file]

        sh "mkdir -p build"
        sh "coffee", "-bcj", "build/src.js", *src_files
        sh "cat lib/*.js build/src.js > game.js"
      end

      desc "Run the live server"
      task :server do
        exec "script/server"
      end

      # TODO Use thor for windows file stuff
      namespace :package do
        task :chrome_webstore => :dist do
          sh "mkdir -p #{dist_dir}/webstore && cp -r webstore/* #{dist_dir}/webstore"
          sh "cp manifest.json #{dist_dir}"

          # Remove old zip
          `rm build/#{dist_name}.zip`
          # Zip
          sh "cd #{dist_dir} && zip -r #{dist_name}.zip . && mv #{dist_name}.zip ../chrome-webstore.zip"
        end

        # Package for direct download
        task :download do
          `rm build/#{dist_name}.zip`
          sh "cd #{dist_dir} && zip -r #{dist_name}.zip . && mv #{dist_name}.zip .."
        end

        task :dist => [:build] do
          `rm -r #{dist_dir}`
          sh "mkdir -p #{dist_dir}"
          sh "cp run.html #{dist_dir}/index.html"

          %w[images music stylesheets sounds].each do |dir|
            sh "cp -R #{dir} #{dist_dir}/#{dir}"
          end

          # Remove larger source images
          sh "find #{dist_dir}/images -name '*@[248]x.png' -delete"

          %w[jquery.min.js game.js].each do |file|
            sh "cp #{file} #{dist_dir}/#{file}"
          end
        end
      end
    end
  end
end

Arcanus::Tasks.install
