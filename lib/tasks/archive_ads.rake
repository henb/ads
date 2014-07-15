namespace :ads do
  task :archive => :environment do
    count = Myad.updete_published
    puts "#{count} #{'record'.pluralize(count)} added to the archive!"
  end

  task :publish => :environment do
    count = Myad.update_ads
    puts "#{count} #{'record'.pluralize(count)} published!"
  end
end
