require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability){ Ability.new(user) }
  let(:user) { nil }

  context 'when is a guest' do
    it 'read Typead' do
      expect(ability).to be_able_to :read, Typead
    end

    it 'read Myad publised' do
      expect(ability).to be_able_to :read, Myad.new(state: 4)
    end
  end

  context 'when is a user' do
    let(:user) { create :user }

    it 'read User' do
      expect(ability).to be_able_to :read, User.new
    end

    it 'read Typead' do
      expect(ability).to be_able_to :read, Typead.new
    end

    it 'read Myad publised' do
      expect(ability).to be_able_to :read, Myad.new(state: 4)
    end

    it 'create Myad' do
      expect(ability).to be_able_to :create, Myad.new
    end

    it 'edit Myad drafting' do
      expect(ability).to be_able_to :update, Myad.new
    end

    it 'destroy Myad belong to user' do
      expect(ability).to be_able_to :destroy, Myad.new(user: user)
    end

    it 'cannot destroy Myad [:banned, :rejected]' do
      expect(ability).not_to be_able_to :destroy, Myad.new(user: user, state:2)
      expect(ability).not_to be_able_to :destroy, Myad.new(user: user, state:6)
    end

    it 'destroy Myad belong to user' do
      expect(ability).to be_able_to :destroy, Myad.new(user_id: user.id)
    end

    it 'update_all_state Myad' do
      expect(ability).to be_able_to :update_all_state, Myad
    end
  end

  context 'when is a admin' do
    let(:user) { create :admin_user }

    it 'update_all_state Myad' do
      expect(ability).to be_able_to :update_all_state, Myad
    end

    it 'manage User and Typead' do
      expect(ability).to be_able_to :manage, User.new
      expect(ability).to be_able_to :manage, Typead.new
    end

    it 'destroy :all' do
      expect(ability).to be_able_to :destroy, :all
    end

    it 'cannot [:create, :update], Myad' do
      expect(ability).not_to be_able_to :create, Myad.new
      expect(ability).not_to be_able_to :update, Myad.new
    end
  end
end
