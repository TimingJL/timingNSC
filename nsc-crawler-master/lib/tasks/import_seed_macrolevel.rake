# encoding: UTF-8

desc "import seed macrolevel"
task :import_seed_macrolevel => :environment do
	if Macrolevel.count == 0
		Macrolevel.create({name: '頭條', tag: 'headline'})
		Macrolevel.create({name: '快報', tag: 'express'})
		Macrolevel.create({name: '宏觀', tag: 'MACRO'})
		Macrolevel.create({name: '指標', tag: 'INDEX'})
		Macrolevel.create({name: '時事', tag: 'EVENT'})
		Macrolevel.create({name: '深度', tag: 'deep'})
		Macrolevel.create({name: '台股', tag: 'tw_stock'})
		Macrolevel.create({name: '興櫃', tag: 'eme'})
		Macrolevel.create({name: '美股', tag: 'us_stock'})
		Macrolevel.create({name: 'A股', tag: 'sh_stock'})
		Macrolevel.create({name: '港股', tag: 'hk_stock'})
		Macrolevel.create({name: '國際股', tag: 'wd_stock'})
		Macrolevel.create({name: '外匯', tag: 'forex'})
		Macrolevel.create({name: '期貨', tag: 'future'})
		Macrolevel.create({name: '能源', tag: 'energry'})
		Macrolevel.create({name: '黃金', tag: 'gold'})
		Macrolevel.create({name: '基金', tag: 'fund'})
		Macrolevel.create({name: '房產', tag: 'cnyeshouse'})
		Macrolevel.create({name: '產業', tag: 'industry'})
	end
end