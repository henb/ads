require 'spec_helper'

describe MyadsController do
  describe 'resources' do
    describe 'member' do
      it '#draft' do
        expect(get: '/myads/1/draft').to route_to(
          controller: 'myads', action: 'draft', id: '1')
      end
      it '#fresh' do
        expect(get: '/myads/1/fresh').to route_to(
          controller: 'myads', action: 'fresh', id: '1')
      end
      it '#reject' do
        expect(get: '/myads/1/reject').to route_to(
          controller: 'myads', action: 'reject', id: '1')
      end
      it '#approve' do
        expect(get: '/myads/1/approve').to route_to(
          controller: 'myads', action: 'approve', id: '1')
      end
      it '#publish' do
        expect(get: '/myads/1/publish').to route_to(
          controller: 'myads', action: 'publish', id: '1')
      end
      it '#archive' do
        expect(get: '/myads/1/archive').to route_to(
          controller: 'myads', action: 'archive', id: '1')
      end
      it '#ban' do
        expect(get: '/myads/1/ban').to route_to(
          controller: 'myads', action: 'ban', id: '1')
      end
    end

    describe 'collection' do
      it '#published' do
        expect(get: '/myads/published').to route_to(
          controller: 'myads', action: 'published')
      end

      it '#update_all_state' do
        expect(post: '/myads/update_all_state').to route_to(
          controller: 'myads', action: 'update_all_state')
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
