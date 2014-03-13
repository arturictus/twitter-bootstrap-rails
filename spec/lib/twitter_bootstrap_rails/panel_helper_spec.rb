require "spec_helper"
require 'action_view'
require_relative '../../../app/helpers/bootstrap_helper'

include ActionView::Helpers
include ActionView::Context
include BootstrapHelper

describe "panel" do
  before(:all) do
    @content = content_tag(:p, "hello panel")
  end
  it "no given class outputs default" do
    output = panel do
      @content
    end
    expected = "<div class=\"panel panel-default\"><div class=\"panel-body\"><p>hello panel</p></div></div>"
    expect(output).to eq(expected)
  end
  it "class can be override" do
    output = panel(:class => "primary") do
      @content
    end
    expected = "<div class=\"panel panel-primary\"><div class=\"panel-body\"><p>hello panel</p></div></div>"
    expect(output).to eq(expected)
  end
  
  it "content can be as a parameter" do
    output = panel(:class => "primary", :content => @content ) 
    expected = "<div class=\"panel panel-primary\"><div class=\"panel-body\"><p>hello panel</p></div></div>"
    expect(output).to eq(expected)
  end
  it "content and block are accepted" do
    output = panel(:class => "primary", :content => @content ) do
      @content
    end
    expected = "<div class=\"panel panel-primary\"><div class=\"panel-body\"><p>hello panel</p><p>hello panel</p></div></div>"
    expect(output).to eq(expected)
  end
  
  it "title for the panel" do
    output = panel(:class => "primary", :content => @content, :title => "my beautiful title" ) do
      @content
    end
    expected = "<div class=\"panel panel-primary\"><div class=\"panel-heading\">my beautiful title</div><div class=\"panel-body\"><p>hello panel</p><p>hello panel</p></div></div>"
    expect(output).to eq(expected)
  end
end