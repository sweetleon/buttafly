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

    def event_button_to(event, originable_id, options = {})
      options[:action]      ||= event
      options[:method]      ||= "put"
      options[:orientation] ||= "tip-top"
      content_tag(:span, button_to( 
        event, { 
          action: options[:action], id: originable_id 
        }, 
        method: options[:method], 
        class: "button tiny #{event_color(event.to_s)}" 
      ), 
      class: "has-tip #{ options[:orientation] }",
        :'data-tooltiip aria-haspopup' => true, "data-tooltip" => "",
        :title => event_description(event.to_s)
    )  
    end

    # def event_button(event, originable_id, orientation="top")
    #   content_tag(
    #     :span, submit_tag( 
    #       event, controller: "contents", action: event, id: originable_id, 
    #       class: "button tiny #{event_color(event)}" 
    #     ), 
    #     class: "has-tip #{orientation}", 
    #       :'aria-haspopup' => true, "data-tooltip" => "", 
    #       :title => "#{event_description(event.to_s)}" 
    #   )
    # end

    def event_color(event)

      case event
      
      when "remove file"
        "alert"
      # when "archive"
      #   "default"
      # when "import"
      #   "success"
      when "replicate"
        "warning"

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
      when "replicate"
        "replicates spreadsheet rows as objects in database"
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
