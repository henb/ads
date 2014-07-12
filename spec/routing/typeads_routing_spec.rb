require 'spec_helper'

describe TypeadsController do
  describe 'resources' do
    it '#index' do
      expect(get: '/typeads').to route_to(
          controller: 'typeads', action: 'index')
    end

    it '#new' do
      expect(get: '/typeads/new').to route_to(
          controller: 'typeads', action: 'new')
    end

    it '#show' do
      expect(get: '/typeads/1').to route_to(
          controller: 'typeads', action: 'show', id: '1')
    end

    it '#edit' do
      expect(get: '/typeads/1/edit').not_to route_to(
          controller: 'typeads', action: 'edit', id: '1')
    end

    it '#create' do
      expect(post: '/typeads').to route_to(
          controller: 'typeads', action: 'create')
    end

    it '#update' do
      expect(put: '/typeads/1').not_to route_to(
          controller: 'typeads', action: 'update', id: '1')
    end

    it '#destroy' do
      expect(delete: '/typeads/1').to route_to(
          controller: 'typeads', action: 'destroy', id: '1')
    end
  end
end
