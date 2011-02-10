module SiteHelper
  
  def diplay_class_menu(c)
    checkbox = check_box_tag("class[" + c.id.to_s + "]")
    out = "<li><a>#{checkbox} #{c.name}"
    if !c.subclasses.empty? then
      out += "&nbsp;"
      out += image_tag("right-arrow.png")
    end
    if !c.subclasses.empty?
      out += "</a><ul>"
      c.subclasses.each do |sub|
        out += diplay_class_menu(sub)
      end
      out += "</ul>"
    end
    out += "</li>"
    return out
  end
end
