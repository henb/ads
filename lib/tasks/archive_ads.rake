namespace :db do
  task :archive => :environment do
    count = Myad.updete_published
    puts "#{count} #{'record'.pluralize(count)} added to the archive!"
  end
end
