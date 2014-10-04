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
      when "modified"
        "This file's source file on the server has been modified."
      when "ignored"
        "This file's has been ignored, and its transactions deleted."
      when "removed"
        "This file's source file is not on the server."
      end
    end
  end
end
