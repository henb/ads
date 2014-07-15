require 'spec_helper'

describe Typead do

  describe 'connections' do
    it { expect(subject).to have_many(:myads).dependent(:restrict_with_error) }
  end

  describe 'validates' do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:description) }

    it { expect(subject).to ensure_length_of(:name).is_at_least(10).is_at_most(100) }
    it { expect(subject).to ensure_length_of(:description).is_at_most(500) }
  end
end
