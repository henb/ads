module Features
  module StateHelper
    def check_event(ad, event, state)
      visit myad_path(ad)
      click_link(event)

      expect(page).to have_content state
    end
  end
end
