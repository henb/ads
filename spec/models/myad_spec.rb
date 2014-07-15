require 'spec_helper'

describe Myad do

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

  describe 'testing state_machine' do
    subject { build :myad }

    describe 'default state for myad' do
      it { expect(subject.drafting?).to be }
    end
    describe '#events' do
      it 'returns all events for myad' do
        expect(subject.state_paths.events).to include(:fresh,
                                                      :reject, :draft, :approve, :publish, :archive, :ban)
      end
    end

    describe '#state' do
      it 'returns all states for myad' do
        expect(subject.state_paths.to_states).to include(:freshing,
                                                         :rejected, :drafting, :approved, :published, :archives, :banned)
      end
    end
  end

  describe 'class methods' do
    subject { Myad }

    describe '.admin_events' do
      it 'returns events available for admin' do
        expect(subject.admin_events).to include(:reject, :approve, :ban)
      end

      it "doesn't return user's events" do
        expect(subject.admin_events).not_to include(:draft, :fresh)
      end
    end

    describe '.user_events' do
      it 'returns events available for user' do
        expect(subject.user_events).to include(:draft, :fresh)
      end

      it "doesn't return admin's events" do
        expect(subject.user_events).not_to include(:reject, :approve, :ban)
      end
    end

    it '.admin_state' do
      expect(subject.admin_state).to eq [1, 2, 3, 4, 6]
    end

  end

end
