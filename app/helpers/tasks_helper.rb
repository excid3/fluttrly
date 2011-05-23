module TasksHelper
  def create_links(content)
    h(content).gsub(/#([^\s]+)/) { |match| link_to "##{$1}", "/#{$1}" }
  end
end
