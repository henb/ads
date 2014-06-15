every 1.minute do
  #command "echo 'one' && echo 'two'"
  runner "Myad.update_ads", :environment => 'development'
end