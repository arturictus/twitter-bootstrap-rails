require "spec_helper"
require 'action_view'
require_relative '../../../app/helpers/bootstrap_media_helper'

include ActionView::Helpers
include ActionView::Context
include BootstrapMediaHelper

describe BootstrapMediaHelper do
  before(:all) do
    @image_hash = {:url =>"image_src"}
    @content_hash = {:heading => "title", 
                     :content => "<h1>content title</h1><p>content paragraph</p>", 
                     :link => [["show","/path"]]}
  end
  it "works" do
    output = media_object(@image_hash, @content_hash)
    expected = "<div class=\"media\"><a class=\"pull-left\" href=\"#\"><img alt=\"Image src\" class=\"media-object\" src=\"/images/image_src\" /></a><div class=\"media-body\"><h4 class=\"media-heading\">title</h4><p>&lt;h1&gt;content title&lt;/h1&gt;&lt;p&gt;content paragraph&lt;/p&gt;</p><a class=\"btn btn-primary\" href=\"/path\">show</a></div></div>"
    expect(output).to eq(expected)
  end
  it "accepts block" do
    output = media_object(@image_hash) do
      link_to "show", "#"
    end
    expected = "<div class=\"media\"><a class=\"pull-left\" href=\"#\"><img alt=\"Image src\" class=\"media-object\" src=\"/images/image_src\" /></a><div class=\"media-body\"><a href=\"#\">show</a></div></div>"
    expect(output).to eq(expected)
  end
end