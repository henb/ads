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

  describe 'connections' do
    it { expect(subject).to have_many(:images).dependent(:destroy) }
    it { expect(subject).to belong_to(:typead) }
    it { expect(subject).to belong_to(:user) }
  end

  describe 'validates' do
    it { expect(subject).to validate_presence_of(:title) }
    it { expect(subject).to validate_presence_of(:typead_id) }
    it { expect(subject).to validate_presence_of(:user_id) }
    it { expect(subject).to validate_presence_of(:description) }

    it { expect(subject).to ensure_length_of(:title).is_at_least(10).is_at_most(100) }
    it { expect(subject).to ensure_length_of(:description).is_at_most(500) }

    it { expect(subject).to accept_nested_attributes_for(:images).allow_destroy(true) }
  end

  describe 'scopes' do
    it { expect(Myad.scoped.to_sql).to eq Myad.order("updated_at DESC").to_sql }
  end

  describe 'testing state_machine' do
    subject { @myad }

    it { expect(subject.drafting?).to be }
    it { expect(subject.freshing?).not_to be }
    it { expect(subject.rejected?).not_to be }
    it { expect(subject.approved?).not_to be }
    it { expect(subject.published?).not_to be }
    it { expect(subject.archives?).not_to be }
    it { expect(subject.banned?).not_to be }

    it '#events' do
      expect(subject.state_paths.events.size).to eq 7
    end

    it '#state' do
      expect(subject.state_paths.to_states.size).to eq 7
    end
  end

  describe 'class methods' do
    subject { Myad }

    it '.admin_events' do
      expect(subject).to respond_to(:admin_events)
      expect(subject.admin_events).to eq [:reject, :approve, :ban]
    end

    it '.user_events' do
      expect(subject).to respond_to(:user_events)
      expect(subject.user_events).to eq [:draft, :fresh]
    end

    it '.admin_state' do
      expect(subject).to respond_to(:admin_state)
      expect(subject.admin_state).to eq [1, 2, 3, 4, 6]
    end

    it '.update_ads' do
      expect(subject).to respond_to(:update_ads)
    end

    it '.updete_published' do
      expect(subject).to respond_to(:updete_published)
    end

  end

end
