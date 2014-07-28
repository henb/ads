require 'spec_helper'

describe Image do

  context 'connections' do
    it { expect(subject).to belong_to(:myad) }
  end

end
