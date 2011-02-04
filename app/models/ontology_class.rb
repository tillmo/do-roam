class OntologyClass < ActiveRecord::Base
  # all classes of all ontologies are stored here
  # database fields  
  # name: name of class
  # ontology_id: the ontology to which the class belongs
  # iconfile: how to display the class
  
  belongs_to :ontology
  has_many :ontology_subclasses, :foreign_key => :superclass_id
  has_many :subclasses, :through => :ontology_subclasses, :source => :ontology_class
#  has_many :ontology_superclasses, :foreign_key => :subclass_id, :source => :ontology_subclasses, :class_name => :ontology_subclasses

  # are we a root class of the ontology?
  def isroot?
    self.superclasses.empty?
  end
  
  # get all superlcasses
  def superclasses
    OntologySubclass.find(:all,:conditions=>["subclass_id = ?",self.id]).map{|sc| sc.super_class}
  end
  
  # get an iconfile, even if there is none in the database
  def safe_iconfile
    if self.iconfile.nil? or self.iconfile.empty?
      return "question-mark.png"
    else
      return self.iconfile
    end
  end

  # is the class interesting w.r.t. an ontology mapping?
  def interesting(om)
    (!self.iconfile.nil? and !self.iconfile.empty? and !om.nodetags(self).empty?) \
    or \
    self.subclasses.map{|c| c.interesting(om)}.any?
  end

  # get all descendants (e.g. subclasses, subclasses of subclasses, etc.)
  def descendants
    self.subclasses.map(&:descendants).flatten << self
  end
end
