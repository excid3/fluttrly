module TasksHelper
  def create_links(content)
    content = h(content)
    content.gsub(/#([^\s]+)/) do |match|
      link_to "##{$1}", "/#{$1}"
    end
  end
end
