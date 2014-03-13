module BootstrapThumbnailHelper
  
  def thumbnail(image_options = {}, body_options = {})
    media = Thumbnail.new(image_options, body_options)
    media.wrapper
  end


  class Thumbnail
    
    include ActionView::Helpers
    
    attr_accessor :image, :body
    
    def initialize(image_options = {}, body_options = {})
      @image = image_options
      @body = body_options
    end
    
    # def lasjdñfls
#         <<-HTML
#         <div class="thumbnail">
#               <img data-src="holder.js/300x200" alt="...">
#               <div class="caption">
#                 <h3>Thumbnail label</h3>
#                 <p>...</p>
#                 <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
#               </div>
#             </div>
#           </div>
#         HTML
#       end
#       def pull_left
#         link_to raw(media_object),"#",:class => "pull-left" 
#       end
#     
    def image
      image_tag(@image[:url])
    end
  
    def caption
      content_tag(:div, raw(caption_heading + caption_body), :class => "caption")
    end
    
    def buttons
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
  
    def caption_body
      if @body[:content].present?
        html = ""
        if @body[:content].is_a?(String)
          html += content_tag(:p, @body[:content])
        elsif @body[:content].is_a?(Array)
          @body[:content].each do |p|
           html += content_tag(:p, p)
          end
        else
          html = ""
        end 
      else
        html = ""
      end
      html += content_tag(:p, raw(buttons))
      raw(html)
    end
  
    def caption_heading
      if @body[:heading].present?
        content_tag(:h3, raw(@body[:heading]))
      else
        ""
      end
    end
  
    def wrapper
      content_tag(:div, raw(image + caption) , :class => "thumbnail") 
    end
  end
end