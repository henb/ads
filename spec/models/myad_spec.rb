require "spec_helper"

describe Myad do
  before :all do
    @typead = create :typead
    @user   = create :user
    @myad = build :myad
  end

  it "create Myad" do 
    @myad.typead = @typead
    @myad.user   = @user
    @myad.save.should be
  end

  describe "testing state_machine" do
      subject{ @myad }

      it "drafting" do
        subject.drafting?.should be
      end

      it "events" do
        subject.state_paths.events.size.should == 7
      end

      it "state" do
        subject.state_paths.to_states.size.should == 7
      end
  end

  describe "testing self methods" do
      subject{ Myad }

    it "define self.admin_events" do
      subject.should respond_to(:admin_events)
    end

    it "define self.user_events" do
      subject.should respond_to(:user_events)
    end

    it "define self.admin_state" do
      subject.should respond_to(:admin_state)
    end

    it "define self.update_ads" do
      subject.should respond_to(:update_ads)
    end

    it "define self.updete_published" do
      subject.should respond_to(:updete_published)
    end


  end


end 