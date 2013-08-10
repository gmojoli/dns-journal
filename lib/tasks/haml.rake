namespace :haml do
  desc "Utility for haml"
  task :convert do
    system "ruby #{Rails.root.join("bin", "to_haml.rb")}"
  end

  desc "remove(find) the old erb files"
  task :purge_erb do
    system "find . -name *.erb" # -exec rm {} \;
  end
end
