every 1.day, at: '0:00 am' do
  # every 1.minutes do
  runner 'Myad.update_ads' # , environment: 'development'
end

every 1.day, at: '11:50 pm' do
  # every 1.minutes do
  runner 'Myad.updete_published' # , environment: 'development'
end
