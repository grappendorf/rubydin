rubydin_dir = [File.expand_path('rubydin')]
optional_dirs = Dir['rubydin-optional/*'].map {|f| File.expand_path f}
addon_dirs = Dir['rubydin-addons/*'].map {|f| File.expand_path f}

desc 'Build and install all Rubydin gems'
task :install do
	(rubydin_dir + optional_dirs + addon_dirs).each do |dir|
		cd dir
		system "rake install sudo=#{ENV['sudo']}"
	end
end

desc 'Uninstall install all Rubydin gems'
task :uninstall do
	(optional_dirs + addon_dirs + rubydin_dir).each do |dir|
		cd dir
		system "rake uninstall sudo=#{ENV['sudo']}"
	end
end

desc 'Delete all build artifacts'
task :clobber do
	(rubydin_dir + optional_dirs + addon_dirs).each do |dir|
		cd dir
		system 'rake clobber'
	end
end