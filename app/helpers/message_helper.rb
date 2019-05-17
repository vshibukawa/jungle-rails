module MessageHelper

  def display_message_helper(message)
    if message.any?
      content_tag( :div, class: "alert alert-danger" ) do
        content_tag( :strong, "The following errors prevented saving:" )
        content_tag( :ul ) do
          message.each do |error|
            content_tag( :li, error )
          end
        end
      end
    end
  end
end