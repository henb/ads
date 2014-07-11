require 'spec_helper'

describe Myad do
  before :all do
    @typead = create :typead
    @user   = create :user
    @myad = build :myad
  end

  it 'create Myad' do
    @myad.typead = @typead
    @myad.user = @user
    expect(@myad.save).to be
  end

  describe 'testing state_machine' do
    subject { @myad }

    it '#drafting' do
      expect(subject.drafting?).to be
    end

    it '#events' do
      expect(subject.state_paths.events.size).to eq 7
    end

    it '#state' do
      expect(subject.state_paths.to_states.size).to eq 7
    end
  end

  describe 'testing class methods' do
    subject { Myad }

    it '.admin_events' do
      expect(subject).to respond_to(:admin_events)
    end

    it '.user_events' do
      expect(subject).to respond_to(:user_events)
    end

    it '.admin_state' do
      expect(subject).to respond_to(:admin_state)
    end

    it '.update_ads' do
      expect(subject).to respond_to(:update_ads)
    end

    it '.updete_published' do
      expect(subject).to respond_to(:updete_published)
    end

  end

end
