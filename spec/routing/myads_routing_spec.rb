require 'spec_helper'

describe MyadsController do
  describe 'resources' do
    describe 'member' do
      Myad.state_machine.events.map(&:name).each do |event|
        it "#{event}" do
          expect(get: "/myads/1/#{event}").to route_to(
            controller: 'myads', action: "#{event}", id: '1')
        end
      end
    end

    # describe 'collection' do
    # end

    it '#index' do
      expect(get: '/myads').to route_to(
          controller: 'myads', action: 'index')
    end

    it '#new' do
      expect(get: '/myads/new').to route_to(
          controller: 'myads', action: 'new')
    end

    it '#show' do
      expect(get: '/myads/1').to route_to(
          controller: 'myads', action: 'show', id: '1')
    end

    it '#edit' do
      expect(get: '/myads/1/edit').to route_to(
          controller: 'myads', action: 'edit', id: '1')
    end

    it '#create' do
      expect(post: '/myads').to route_to(
          controller: 'myads', action: 'create')
    end

    it '#update' do
      expect(put: '/myads/1').to route_to(
          controller: 'myads', action: 'update', id: '1')
    end

    it '#destroy' do
      expect(delete: '/myads/1').to route_to(
          controller: 'myads', action: 'destroy', id: '1')
    end
  end
end
