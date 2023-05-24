desc "Import restaurants, menus, and menu items from a JSON file"
task :import, [:file_path] => :environment do |_, args|
  Importer.new(args[:file_path]).import
end
