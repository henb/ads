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

    describe 'collection' do

      it '#update_all_draft' do
        expect(post: '/myads/update_all_draft').to route_to(
          controller: 'myads', action: 'update_all_draft')
      end

      it '#update_all_fresh' do
        expect(post: '/myads/update_all_fresh').to route_to(
          controller: 'myads', action: 'update_all_fresh')
      end

      it '#update_all_reject' do
        expect(post: '/myads/update_all_reject').to route_to(
          controller: 'myads', action: 'update_all_reject')
      end

      it '#update_all_approve' do
        expect(post: '/myads/update_all_approve').to route_to(
          controller: 'myads', action: 'update_all_approve')
      end

      it '#update_all_publish' do
        expect(post: '/myads/update_all_publish').to route_to(
          controller: 'myads', action: 'update_all_publish')
      end

      it '#update_all_archive' do
        expect(post: '/myads/update_all_archive').to route_to(
          controller: 'myads', action: 'update_all_archive')
      end

      it '#update_all_ban' do
        expect(post: '/myads/update_all_ban').to route_to(
          controller: 'myads', action: 'update_all_ban')
      end

    end

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
