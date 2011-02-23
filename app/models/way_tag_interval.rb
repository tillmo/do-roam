class WayTagInterval < ActiveRecord::Base
  belongs_to :way_tag
  belongs_to :interval
end
