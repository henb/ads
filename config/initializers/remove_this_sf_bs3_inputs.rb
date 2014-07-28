inputs = %w(
  CollectionSelectInput
  DateTimeInput
  FileInput
  GroupedCollectionSelectInput
  NumericInput
  PasswordInput
  RangeInput
  StringInput
)

inputs.each do |input_type|
  superclass = "SimpleForm::Inputs::#{input_type}".constantize

  new_class = Class.new(superclass) do
    def input_html_classes
      super.push('form-control')
    end
  end

  Object.const_set(input_type, new_class)
end

# add wysihtml5
textarea = Class.new(SimpleForm::Inputs::TextInput) do
  def input_html_classes
    super.push('form-control wysihtml5')
  end
end

Object.const_set('TextInput', textarea)
