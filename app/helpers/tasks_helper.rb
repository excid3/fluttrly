module TasksHelper
  def create_links(content)
    content.gsub!(/#([^\s]+)/) do |match|
      link_to "##{h($1)}", "/#{$1}"
    end

    return content.html_safe
  end
end
