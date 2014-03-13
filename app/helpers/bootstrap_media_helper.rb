module BootstrapMediaHelper
  def media_object(image_options = {}, body_options = {})
    media = Media.new(image_options, body_options)
    media.wrapper
  end


  class Media
    
    include ActionView::Helpers
    
    attr_accessor :image, :body
    
    def initialize(image_options = {}, body_options = {})
      @image = image_options
      @body = body_options
    end
  
    def pull_left
      html = ""
      if @image[:url].present?
       html += link_to raw(media_object),"#",:class => "pull-left" 
      elsif @image[:content].present?
        html += content_tag(:div, @image[:content], :class => "pull-left"  )
      end
      raw(html)
    end
  
    def media_object
      image_tag(@image[:url], :class => "media-object")
    end
  
    def media_body
      content_tag(:div, raw(media_heading + media_content + media_content_link), :class => "media-body")
    end
  
    def media_content
      html = ""
      if @body[:content].present?
       html += content_tag(:p, @body[:content]) 
      else
       html+= ""
      end
      raw(html)
    end
    
    def media_content_link
      object = @body
      html = ""
      if object[:link].present?
        if object[:link].is_a?(Array)
          object[:link].each_with_index do |l, i|
            if l.is_a?(Hash)
              html += link_to(l[:label],l[:url], l[:html])
            else
              html += link_to(l[0], l[1], :class => (l[2] ? l[2] : (i == 0 ? "btn btn-primary" : "btn btn-default")))
            end
          end
        else
          html +=  link_to "ver", object[:link], :class => "btn btn-primary"
        end
      end
      raw(html)
    end
  
    def media_heading
      if @body[:heading].present?
        content_tag(:h4, raw(@body[:heading]),:class => "media-heading")
      else
        ""
      end
    end
  
    def wrapper
      content_tag(:div, raw(pull_left + media_body) , :class => "media") 
    end
    
  end
end