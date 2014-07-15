require 'spec_helper'

describe User do

  describe 'Enumerize' do
    it { expect(subject).to enumerize(:role).in(:user, :admin) }
  end

  describe 'Connections' do
    it { expect(subject).to have_many(:myads).dependent(:destroy) }
  end

  describe 'guest & user' do
    subject { build :guest_user }

    it 'verification role' do
      expect(subject.user?).not_to be
    end

    it 'verification role after create' do
      expect(subject.save).to be
      expect(subject.user?).to be
    end
  end

  describe 'admin' do
    subject { create :admin_user }

    it 'verification role' do
      expect(subject.admin?).to be
    end
  end
end
