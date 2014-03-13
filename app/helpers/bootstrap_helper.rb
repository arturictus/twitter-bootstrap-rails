module BootstrapHelper
    
    # def button_group(ary)
#       html = ""
#       unless ary.empty?
#         html += '<div class="btn-group">'
#         html += links_for_components(ary)
#         # ary.each do |l|
# #           html += link_to l[0], l[1], :class => "btn btn-default" 
# #         end
#         html += '</div>'
#       end
#       raw(html)
#     end
#     
    def button_group(ary = nil, &block)
      
      if block_given?
        content_tag(:div, capture(&block), :class =>"btn-group")
      elsif ary
        html = ""
        unless ary.empty?
          html += '<div class="btn-group">'
          html += links_for_components(ary)
          # ary.each do |l|
  #           html += link_to l[0], l[1], :class => "btn btn-default" 
  #         end
          html += '</div>'
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
    def panel(options = {} ,&block)
      html = ""
      if options[:class].present? and !options[:class].blank?
        html += '<div class="panel panel-'+options[:class]+'">'
      else
        html += '<div class="panel panel-default">'
      end
      html += '<div class="panel-heading">'+options[:title]+'</div>' if options[:title].present? and !options[:title].blank?
      html += '<div class="panel-body">'
      html += options[:content] if options[:content].present? and !options[:content].blank?
      html +=  capture(&block) if block
      html += '</div></div>'
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
    # def three_columns(array, &block)
#       html = '<div class="row">'
#         array.each_with_index do |item, i|
#           if i%4 == 0 and item.id != array.last.id
#             html += '</div>'+
#             '<div class="row">'
#           end
#           html +='<div class="col-sm-6 col-md-4 col-lg-3">'
#           html += capture(&block) if block
#           html += '</div>'
#         end
#       html += '</div>'
#       raw(html)
#     end
    
   
end