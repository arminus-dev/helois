require 'spec_helper'

describe "todos/new.html.erb" do
  before(:each) do
    assign(:todo, stub_model(Todo).as_new_record)
  end

  it "renders new todo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => todos_path, :method => "post" do
    end
  end
end
