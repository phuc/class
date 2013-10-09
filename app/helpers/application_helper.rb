module ApplicationHelper
  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end
    
  def menu_active(key, css="active")
    @menu = controller_name if @menu.nil?
    return css if key == @menu
  end
  
  def current_page_active(path, css="active")    
    return css if current_page?(path)
  end
  
  def tool_directory_path(run_tool)    
    send("#{run_tool.tool.downcase}_path", run_tool.id)
  end
end
