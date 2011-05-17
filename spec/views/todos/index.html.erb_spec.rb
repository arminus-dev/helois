require 'spec_helper'

describe "todos/index.html.erb" do
  before(:each) do
    assign(:todos, [
      stub_model(Todo),
      stub_model(Todo)
    ])
  end

  it "renders a list of todos" do
    render
  end
end
