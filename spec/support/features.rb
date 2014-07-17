RSpec.configure do |config|
  config.include Features::SessionHelper, type: :feature
  config.include Features::StateHelper, type: :feature
  config.include Features::MyadHelper, type: :feature
end
