module Features
  module MyadHelper
    def check_sorting_ling(text, select='#sort_list')
      within(select) do
        click_link(text)
      end
    end
  end
end
