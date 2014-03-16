require "spec_helper"
require 'action_view'
require_relative '../../../app/helpers/bootstrap_thumbnail_helper'

include ActionView::Helpers
include ActionView::Context
include BootstrapThumbnailHelper

describe BootstrapThumbnailHelper do
  before(:all) do
    @image_hash = {:url =>"image_src"}
    @content_hash = {:heading => "title", 
                         :content => "content paragraph", 
                         :link => [["show","/path"]]}
    @content_no_heading = {:content => "content paragraph", 
                     :link => [["show","/path"]]}
  end
  it "works" do
    output = thumbnail(@image_hash, @content_hash)
    expected = "<div class=\"thumbnail\"><img alt=\"Image src\" src=\"/images/image_src\" /><div class=\"caption\"><h3>title</h3><p>content paragraph</p><p><a class=\"btn btn-primary\" href=\"/path\">show</a></p></div></div>"
    expect(output).to eq(expected)
  end
  
  it "no title given" do
    output = thumbnail(@image_hash, @content_no_heading)
    expected = "<div class=\"thumbnail\"><img alt=\"Image src\" src=\"/images/image_src\" /><div class=\"caption\"><p>content paragraph</p><p><a class=\"btn btn-primary\" href=\"/path\">show</a></p></div></div>"
    expect(output).to eq(expected)
  end
  
  it "accepts block" do
    output = thumbnail(@image_hash) do
      link_to "link", "#"
    end
    expected = "<div class=\"thumbnail\"><img alt=\"Image src\" src=\"/images/image_src\" /><div class=\"caption\"><a href=\"#\">link</a></div></div>"
    expect(output).to eq(expected)
  end
end