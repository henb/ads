require 'spec_helper'

describe Image do

  describe 'connections' do
    it { expect(subject).to belong_to(:myad) }
  end

end
