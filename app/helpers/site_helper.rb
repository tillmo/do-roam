module SiteHelper
  
  def diplay_class_menu(om,c)
    if !c.interesting(om) 
      return ""
    end
    checkbox = check_box_tag("class[" + c.id.to_s + "]")
    out = "<li><a>#{checkbox} #{c.name}"
    if !c.subclasses.empty? and c.subclasses.map{|x| x.interesting(om)}.any? then
      out += "&nbsp;"
      out += image_tag("right-arrow.png")
      out += "</a><ul>"
      c.subclasses.each do |sub|
        out += diplay_class_menu(om,sub)
      end
      out += "</ul>"
    end
    out += "</li>"
    return out
  end
end
