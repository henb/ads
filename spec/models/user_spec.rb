require 'spec_helper'

describe User do

  it 'create User' do
    User.new
  end

  describe 'User attributes' do
    subject { User.new }

    it 'attributes id' do
      subject.should respond_to(:id)
    end

    it 'attributes first_name' do
      subject.should respond_to(:first_name)
    end

    it 'attributes last_name' do
      subject.should respond_to(:last_name)
    end

    it 'attributes email' do
      subject.should respond_to(:email)
    end

    it 'attributes password' do
      subject.should respond_to(:password)
    end

    it 'attributes role' do
      subject.should respond_to(:role)
    end

  end

  describe 'guest' do
    subject { build :guest_user }

    it 'verification role' do
      subject.guest?.should be
    end

    it 'verification role after create' do
      subject.save
      subject.guest?.should be_false
    end
  end

  describe 'user' do
    subject { create :user_user }

    it 'verification role' do
      subject.user?.should be
    end

  end

  describe 'admin' do
    subject { create :admin_user }

  end
end
