require 'spec_helper'

feature 'Typead functional' do
  let(:admin) { create :admin_user }
  let(:typead) { create :typead }

  context 'Create/Read/Delete(CRD)' do
    before { sign_in_with(admin.email, admin.password) }

    scenario 'Adding new typead' do
      visit new_typead_path
      fill_in 'Name', with: 'Test_type_for_ads'
      fill_in 'Description', with: 'Test_Description'
      page.find('input.btn').click

      expect(page).to have_content 'Test_type_for_ads'
    end

    scenario 'Deleting typead if myads no empty' do
      type = create :typead
      create :myad, typead: type
      visit typead_path(type)
      click_link('Destroy')

      expect(page).to have_content type.name
      expect(page).to have_content 'Typead not empty!'
    end

    scenario 'Deleting typead' do
      visit typead_path(typead)
      click_link('Destroy')

      expect(page).to have_content 'Listing type for ads'
    end
  end
end
