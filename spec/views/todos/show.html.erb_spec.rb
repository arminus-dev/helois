require 'spec_helper'

describe "todos/show.html.erb" do
  before(:each) do
    @todo = assign(:todo, stub_model(Todo))
  end

  it "renders attributes in <p>" do
    render
  end
end
