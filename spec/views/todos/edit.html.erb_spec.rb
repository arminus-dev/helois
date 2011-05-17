require 'spec_helper'

describe "todos/edit.html.erb" do
  before(:each) do
    @todo = assign(:todo, stub_model(Todo))
  end

  it "renders the edit todo form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => todos_path(@todo), :method => "post" do
    end
  end
end
