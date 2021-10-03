module ApplicationHelper
  include Pagy::Frontend
    def nav_item_blank(name, path, fa)
        if current_page?(path)
          @title = name
        end
        content_tag('li', :class=>(current_page?(path) ? 'active nav-item' : 'nav-item') ){
          link_to path, :class => ('nav-link'), :target => '_blank' do
            i_class = "fas fa-fw #{fa}"
          "#{content_tag :i,'', :class => i_class } #{content_tag :span, name}".html_safe
        end
        }
      end
     
      def nav_item(name, path, fa)
       if current_page?(path)
         @title = name
       end
       content_tag('li', :class=>(current_page?(path) ? 'active nav-item' : 'nav-item') ){
         link_to path, :class => ('nav-link') do
           i_class = "fas fa-fw #{fa}"
         "#{content_tag :h3,'', :class => i_class } #{content_tag :span, name}".html_safe
       end
       }
     end
     
     
      def collapse_item(name, path)
        if current_page?(path)
          @title = name
        end
        link_to name, path, :class => (current_page?(path) ? 'active collapse-item' : 'collapse-item')
       end
end
