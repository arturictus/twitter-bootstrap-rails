require "spec_helper"
require 'action_view'
require_relative '../../../app/helpers/bootstrap_helper'

include ActionView::Helpers
include ActionView::Context
include BootstrapHelper

describe "links for components" do
  it "one path outputs primary" do
    input = "path"
    out = links_for_components(input)
    expect(out).to eq("<a class=\"btn btn-primary\" href=\"path\">show</a>")
  end
  
  it "array no given class prints primary" do
    input = [["#", "path"]]
    out = links_for_components(input)
    expect(out).to eq("<a class=\"btn btn-primary\" href=\"path\">#</a>")
  end
  
  it "array of links first primary, rest default" do
    input = [
      ["#", "path"],
      ["#", "path"],
      ["#", "path"]
    ]
    out = links_for_components(input)
    expected =  '<a class="btn btn-primary" href="path">#</a><a class="btn btn-default" href="path">#</a><a class="btn btn-default" href="path">#</a>'
    expect(out).to eq(expected)
  end
  it "classes can be overriden" do
    input = [
      ["#", "path"],
      ["#", "path", "btn btn-danger"],
      ["#", "path"]
    ]
    out = links_for_components(input)
    expected =   "<a class=\"btn btn-primary\" href=\"path\">#</a><a class=\"btn btn-danger\" href=\"path\">#</a><a class=\"btn btn-default\" href=\"path\">#</a>"
    expect(out).to eq(expected)
  end
  it "it accepts hash like link_to rails helper" do
    input = [
      ["#", "path"],
      ["#", "path", "btn btn-wanning"],
      {:label => "hello", 
        :url => "/path_to",
        :html => {class: "btn btn-danger",
               method: :delete,
               data: { confirm: 'are you shure?' }, 
               title: 'Destroy'}
       }
    ]
    out = links_for_components(input)
    expected = "<a class=\"btn btn-primary\" href=\"path\">#</a><a class=\"btn btn-wanning\" href=\"path\">#</a><a class=\"btn btn-danger\" data-confirm=\"are you shure?\" data-method=\"delete\" href=\"/path_to\" rel=\"nofollow\" title=\"Destroy\">hello</a>"
    expect(out).to eq(expected)
  end
end