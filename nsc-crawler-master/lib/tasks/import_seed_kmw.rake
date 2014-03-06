# encoding: UTF-8

desc "import seed kmw"
task :import_seed_kmw => :environment do
	if Kmw.count == 0
		Kmw.create({name: '台灣', tag: 'taiwan'})
	end
end