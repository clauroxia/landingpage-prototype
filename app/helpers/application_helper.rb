module ApplicationHelper
  def errors_for(record, attribute)
    errors = record.errors.messages_for(attribute).map do |message|
      content_tag(:div, "Error: " + message, class: "input__error-message")
    end

    safe_join(errors)
  end
end