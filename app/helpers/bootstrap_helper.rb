module BootstrapHelper
         
    def button_group(ary = nil, &block)
      if block_given?
        content_tag(:div, capture(&block), :class =>"btn-group")
      elsif ary
        html = ""
        unless ary.empty?
          html += content_tag(:div, links_for_components(ary), class: "btn-group" )
        end
        raw(html)
      end
    end
    
    # panel
    # it builds a boostrap markup for panel component
    # options:
    # title: [String] if given it builds the panel-heading with the given title
    # class: [string] if given changes panel-default for panel-#{class}
    #
    def panel(main_options ={}, options = {} ,&block)
      # variables
      heading = ""
      body_content = ""
      
      # main class
      if main_options[:class].present? and !main_options[:class].blank?
        main_class = 'panel-'+main_options[:class]
      else
        main_class = 'panel-default'
      end
      main_options.delete(:class)
      html_options = {:class => "panel "+main_class}
      html_options = html_options.merge(main_options) unless main_options.empty?
      
      # Heading
      heading += content_tag(:div, options[:title], class: "panel-heading") if options[:title].present? and !options[:title].blank?
      
      #
      # Body
      body_content += options[:content] if options[:content].present? and !options[:content].blank?
      body_content +=  capture(&block) if block
      
      body = content_tag(:div, raw(body_content), class: "panel-body")
      
      #
      # Wrap it all
      
      html = content_tag(:div, raw(heading+body), html_options)
      
      raw(html)     
    end
  
    def print_address(str)
      html ="<address>"
      scan = str.scan(", ")
      unless scan.empty?
        str.split(", ").each do |s|
          html += s+"<br/>" 
        end
      else
        html += str
      end
      html +="</address>"
      raw(html)
    end
    
    def links_for_components(object)
      html = ""
      if object.present?
        if object.is_a?(Array)
          object.each_with_index do |l, i|
            if l.is_a?(Hash)
              html += link_to(l[:label],l[:url], l[:html])
            else
              html += link_to(l[0], l[1], :class => (l[2] ? l[2] : (i == 0 ? "btn btn-primary" : "btn btn-default")))
            end
          end
        else
          html +=  link_to "show", object, :class => "btn btn-primary"
        end
      end
      raw(html)
    end
end