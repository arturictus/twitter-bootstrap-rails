require "spec_helper"
require 'action_view'
require_relative '../../../app/helpers/bootstrap_helper'

include ActionView::Helpers
include ActionView::Context
include BootstrapHelper

describe "button group" do
  
  it "accepts blocks" do
    group = button_group do
      link_to "example", "#", class: "btn btn-primary"
    end
    expect(group).to eq("<div class=\"btn-group\"><a class=\"btn btn-primary\" href=\"#\">example</a></div>")
  end
  it "accepts compexes inputs" do
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
    out = button_group(input)
    expected = "<div class=\"btn-group\"><a class=\"btn btn-primary\" href=\"path\">#</a><a class=\"btn btn-wanning\" href=\"path\">#</a><a class=\"btn btn-danger\" data-confirm=\"are you shure?\" data-method=\"delete\" href=\"/path_to\" rel=\"nofollow\" title=\"Destroy\">hello</a></div>"
    expect(out).to eq(expected)
  end
end