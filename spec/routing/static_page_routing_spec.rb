require 'spec_helper'

describe 'StaticPageController' do
  it '/' do
    expect(get: '/').to route_to(controller: 'static_page', action: 'home')
  end

  it '#index' do
    expect(get: '/static_page/home').not_to route_to(controller: 'static_page', action: 'home')
  end
end
