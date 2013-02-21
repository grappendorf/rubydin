rubydin_dir = [File.expand_path('rubydin')]
optional_dirs = Dir['rubydin-optional/*'].map {|f| File.expand_path f}
addon_dirs = Dir['rubydin-addons/*'].map {|f| File.expand_path f}

desc 'Build and install all Rubydin Gems'
task :install do
	(rubydin_dir + optional_dirs + addon_dirs).each do |dir|
		cd dir
		system "rake install sudo=#{ENV['sudo']}"
	end
end

desc 'Uninstall all Rubydin Gems'
task :uninstall do
	(optional_dirs + addon_dirs + rubydin_dir).each do |dir|
		cd dir
		system "rake uninstall sudo=#{ENV['sudo']}"
	end
end

desc 'Upload all Rubydin Gems to Local Repository'
task :release do
	(optional_dirs + addon_dirs + rubydin_dir).each do |dir|
		cd dir
		system 'rake release'
	end
end

desc 'Delete all Build Artifacts'
task :clobber do
	(rubydin_dir + optional_dirs + addon_dirs).each do |dir|
		cd dir
		system 'rake clobber'
	end
end