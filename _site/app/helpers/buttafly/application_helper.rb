module Buttafly
  module ApplicationHelper

    def nav_link_to(text, path)
      class_name = current_page?(path) ? 'active' : ''

      content_tag(:li, class: "#{class_name}") do
        link_to text, path
      end
    end

    def status_description(status)
      
      case status
      
      when "not_imported"
        "This file is present on the server and a record has been created, but it has not yet been imported."
      when "imported"
        "This file has been imported into the database and its contents converted to json."
      when "processed" 
        "This file's purchase data has successfully generated transactions."
      end
    end
  end
end
