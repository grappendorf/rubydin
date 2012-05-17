rubydin_dir = [File.expand_path('rubydin')]
addon_dirs = [File.expand_path('rubydin-optional')]
addon_dirs += Dir.glob('rubydin-addons/*').map {|f| File.expand_path f}

desc 'Build and install all Rubydin gems'
task :install do
	(rubydin_dir + addon_dirs).each do |dir|
		cd dir
		system 'rake install'
	end
end

desc 'Uninstall install all Rubydin gems'
task :uninstall do
	(addon_dirs + rubydin_dir).each do |dir|
		cd dir
		system 'rake uninstall'
	end
end

desc 'Delete all build artifacts'
task :clobber do
	(rubydin_dir + addon_dirs).each do |dir|
		cd dir
		system 'rake clobber'
	end
end