namespace :radiant do
  namespace :extensions do
    namespace :reader_shop do
      
      desc "Runs the migration of the Reader Shop extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          ReaderShopExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          ReaderShopExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Reader Shop to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        puts "Copying assets from ReaderShopExtension"
        Dir[ReaderShopExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(ReaderShopExtension.root, '')
          directory = File.dirname(path)
          mkdir_p RAILS_ROOT + directory, :verbose => false
          cp file, RAILS_ROOT + path, :verbose => false
        end
      end  
    end
  end
end
