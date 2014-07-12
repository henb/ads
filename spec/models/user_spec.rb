require 'spec_helper'

describe User do

  it '.new' do
    User.new
  end

  describe 'Enumerize' do
    it { expect(subject).to enumerize(:role).in(:guest, :user, :admin) }
    it { expect(subject).to enumerize(:role).in(:guest, :user, :admin)
                                            .with_default(:guest) }
  end

  describe 'Connections' do
    it { expect(subject).to have_many(:myads).dependent(:destroy) }
  end

  describe 'User attributes' do
    subject { User.new }

    it '#id' do
      expect(subject).to respond_to(:id)
    end

    it '#first_name' do
      expect(subject).to respond_to(:first_name)
    end

    it '#last_name' do
      expect(subject).to respond_to(:last_name)
    end

    it '#email' do
      expect(subject).to respond_to(:email)
    end

    it '#password' do
      expect(subject).to respond_to(:password)
    end

    it '#role' do
      expect(subject).to respond_to(:role)
    end

  end

  describe 'guest' do
    subject { build :guest_user }

    it 'verification role' do
      expect(subject.guest?).to be
    end

    it 'verification role after create' do
      expect(subject.save)
      expect(subject.user?).to be
    end
  end

  describe 'user' do
    subject { create :user_user }

    it 'verification role' do
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
