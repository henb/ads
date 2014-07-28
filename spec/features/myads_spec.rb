require 'spec_helper'

feature 'Myad functional' do
  let(:user) { create :user }
  let(:admin) { create :admin_user }

  context 'Status change' do

    context 'User states' do
      before { sign_in_with(user.email, user.password) }
      scenario 'Status change to Freshing' do
        ad = create :myad_drafting, user: user
        check_event ad, 'Fresh', 'Freshing'
      end

      context 'Status change to Drafting' do
        scenario 'Rejected to Drafting' do
          ad = create :myad_rejected, user: user
          check_event ad, 'Draft', 'Drafting'
        end

        scenario 'Archives to Drafting' do
          ad = create :myad_archives, user: user
          check_event ad, 'Draft', 'Drafting'
        end
      end
    end

    context 'Admin states' do

      before { sign_in_with(admin.email, admin.password) }
      scenario 'Rejected to Drafting' do
        ad = create :myad_freshing, user: user
        check_event ad, 'Reject', 'Rejected'
      end

      scenario 'Archives to Drafting' do
        ad = create :myad_freshing, user: user
        check_event ad, 'Approve', 'Approved'
      end

      scenario 'Rejected to Drafting' do
        ad = create :myad_freshing, user: user
        check_event ad, 'Ban', 'Banned'
      end
    end

  end

  context 'Ability to view' do
    context 'Admin states' do
      before { sign_in_with(admin.email, admin.password) }

      %w(freshing rejected approved published banned).each do |state|
        scenario "Sees Myad #{state}" do
          ad = create "myad_#{state}".to_sym
          visit myad_path(ad)
          expect(page.has_selector?('.alert')).not_to be
        end
      end

      %w(drafting archives).each do |state|
        scenario "Not sees Myad #{state}" do
          ad = create "myad_#{state}".to_sym
          visit myad_path(ad)
          expect(page.has_selector?('.alert')).to be
        end
      end
    end

    context 'User states' do
      before { sign_in_with(user.email, user.password) }

      %w(published).each do |state|
        scenario "Sees Myad #{state} other user" do
          ad = create "myad_#{state}".to_sym
          visit myad_path(ad)
          expect(page.has_selector?('.alert')).not_to be
        end
      end

      %w(drafting freshing rejected approved banned archives).each do |state|
        scenario "Not sees Myad #{state}  other user" do
          ad = create "myad_#{state}".to_sym
          visit myad_path(ad)
          expect(page.has_selector?('.alert')).to be
        end
      end
    end
  end

  context 'Sorting' do
    before { visit myads_path }
    before(:all) { @ad = create :myad_published, title: "A"*10 }

    context 'Updated at' do
      scenario 'descending' do
        check_sorting_ling 'Updated at'
        expect(page.has_selector?("#ad-id#{@ad.id}")).to be
      end

      scenario 'ascending' do
        2.times { check_sorting_ling 'Updated at' }
        expect(page.has_selector?("#ad-id#{@ad.id}")).not_to be
      end
    end

    context 'Title' do
      scenario 'descending' do
        check_sorting_ling 'Title'
        expect(page.has_selector?("#ad-id#{@ad.id}")).to be
      end

      scenario 'ascending' do
        ad = create :myad_published
        2.times { check_sorting_ling 'Title' }
        expect(page.has_selector?("#ad-id#{@ad.id}")).not_to be
      end
    end

  end

  context 'CRUD' do
    let(:myad) { create :myad, user: user }
    before { sign_in_with(user.email, user.password) }
    scenario 'Adding new myad' do
      typead = create :typead
      visit new_myad_path
      fill_in 'Title', with: 'test_myad_name'
      fill_in 'Description', with: 'test_description'
      select(typead.name, from: 'myad_typead_id')
      page.find('input.btn').click

      expect(page).to have_content 'test_myad_name'
    end

    scenario 'Editing myad' do
      visit edit_myad_path(myad)
      fill_in 'Title', with: 'test_myad_name1'
      page.find('input.btn').click

      expect(page).to have_content 'test_myad_name1'
    end

    scenario 'Deleting myad' do
      visit myad_path(myad)
      click_link('Delete')

      expect(page).to have_content 'Listing ads'
    end
  end
end
