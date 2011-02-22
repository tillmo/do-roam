module SiteHelper
  
  def diplay_class_menu(c)
    if !c.interesting
      return ""
    end
    checkbox = check_box_tag("class[" + c.id.to_s + "]") 
    out = "<li><a> <label for=\"class_#{c.id.to_s}\"> #{checkbox} #{c.name} </label>"
    if !c.subclasses.empty? and c.subclasses.map{|x| x.interesting}.any? then
      out += "&nbsp;"
      out += image_tag("right-arrow.png")
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
