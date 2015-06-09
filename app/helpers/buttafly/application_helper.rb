module Buttafly
  module ApplicationHelper

    def nav_link_to(text, path)
      class_name = current_page?(path) ? 'active' : ''

      content_tag(:li, class: "#{class_name}") do
        link_to text, path
      end
    end

    def tab_active?(aasm_state)
      aasm_state.to_s == "uploaded" ? "active" : "inactive"
    end

    def event_button(event)
      content_tag(
        :span, submit_tag( 
          event, class: "button small expand" 
        ), 
        class: "has-tip tip-left", 
          :'aria-haspopup' => true, "data-tooltip" => "", 
          :title => "#{event_description(event.to_s)}" 
      )
    end



    def event_description(event)

      case event
      
      when "import"
        "Save a json representation of the csv data in the spreadsheet model."
      when "target"
        "blah"
      end
    end

    def parent_dependency_notice(array_of_models)
      size = array_of_models.size
      case
      when size == 0
        "No parent dependencies"
      when size == 1
        "#{array_of_models.first.to_s.classify} must be created first"
      when size > 1
        a = array_of_models.map { |i| i.to_s.classify }
        "#{a.split("").join(" and ")} records must be created first."
      end

    end

    def status_description(status)
      
      case status
      
      when "uploaded"
        "This file is present on the server and a record has been created, but nothing else has been done."
      when "imported"
        "This file has been imported into the database and its contents converted to json."
      when "processed" 
        "This file's purchase data has successfully generated transactions."
      end
    end
  end
end
