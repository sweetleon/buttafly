module Buttafly
  module ApplicationHelper

    def nav_link_to(text, path)
      class_name = current_page?(path) ? 'active' : ''

      content_tag(:li, class: "#{class_name}") do
        link_to text, path
      end
    end

    def active_element?(i)
      "active" if i == 0
    end

    def mapping_select_tag(header, m)
      choices = field_choices(m)
      selected = m.legend_data.to_h[header.to_s]
      options = options_for_select(choices, selected)
      input = "mapping[data][#{header}]"
      select_tag(input, options)
    end

    def field_choices(mapping)
      mapping.targetable_field_choices
    end

    def tab_active?(aasm_state)
      aasm_state.to_s == "uploaded" ? "active" : "inactive"
    end

    def available_events(file)
      file.aasm.events.map(&:name) - mapping_events
    end 

    def mapping_events
      [:target, :map]
    end

    def map_legend_button(mapping)
      mapping.legend_data.nil? ? "write legend" : "(re)write legend"
    end

    def event_button(event)
      content_tag(
        :span, submit_tag( 
          event, controller: "contents", action: event, class: "button tiny #{event_color(event)}" 
        ), 
        class: "has-tip", 
          :'aria-haspopup' => true, "data-tooltip" => "", 
          :title => "#{event_description(event.to_s)}" 
      )
    end

    def event_color(event)

      case event
      
      when "remove file"
        "alert"
      end
    end

    def event_description(event)

      case event
      
      when "import"
        "Save a json representation of the csv data in the spreadsheet model."
      when "target"
        "Select the root model, and we will figure out which models it belongs to."
      when "archive"
        "Archive spreadsheet."
      when "write legend" 
        "After selecting the model and attribute you wish to map each of the headers at to, save the legend."
      when "remove file"
        "Removes the file from the server. Does NOT remove replicated objects." 
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
