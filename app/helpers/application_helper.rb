module ApplicationHelper

  def label_state(index)
  	array = ["default","primary","warning","info","success","archive","danger"]
  	array[index]
  end

end
