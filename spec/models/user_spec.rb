require 'spec_helper'

describe User do

  context 'Enumerize' do
    it { expect(subject).to enumerize(:role).in(:user, :admin) }
  end

  context 'Connections' do
    it { expect(subject).to have_many(:myads).dependent(:destroy) }
  end

  context 'guest & user roles' do
    subject { build :guest_user }

    it 'verification role' do
      expect(subject.user?).not_to be
    end

    it 'verification role after create' do
      expect(subject.save).to be
      expect(subject.user?).to be
    end
  end

  context 'admin role' do
    subject { build :admin_user }

    it 'verification role' do
      expect(subject.user?).not_to be
    end
  end
end
