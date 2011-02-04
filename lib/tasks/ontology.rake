namespace :ontology do
  desc 'Read in OSM ontologies'
  task :read => :environment do
    # delete old stuff and read in ontologies
    Ontology.all.each do |o| o.destroy end
    OntologyMapping.all.each do |o| o.destroy end
    puts "Reading ../MappingFiles/activity.owl"
    s = Ontology.read_ontology("../MappingFiles/activity.owl","activities")
    puts "Reading ../MappingFiles/tags.owl"
    t = Ontology.read_ontology("../MappingFiles/tags.owl","tags")
    puts "Reading ../MappingFiles/activities2tags.view"
   OntologyMapping.read_mapping("../MappingFiles/activities2tags.view","activities2tags",s,t)
    # s = Ontology.read_ontology("../MappingFiles/activity-eng.owl","activities-eng")
  end
  desc 'Read in icon files'
  task :read_icons => :environment do
    icon("Bank","bank.png")
    icon("Restaurants","restaurant.png")
    icon("Hochschule","bildungseinrichtungen.png")
    icon("Schule","schule.png")
    icon("Universitaet","bildungseinrichtungen.png")
    icon("VHS","bildungseinrichtungen.png")
    icon("Kino","kino.png")
    icon("Museum", "museum.png")
    icon("Oper","oper.png")
    icon("Parkanlage","park.png")
    icon("Schwimmbad","swimming.png")
    icon("Theater","theater.png")
    icon("Wellness","fitness.png")
    icon("Cafés","cafe.png")
    icon("FastfoodAndImbiss","fastfood.png")
    icon("Arabisch","gastronomie.png")
    icon("Chinesisch","gastronomie.png")
    icon("Deutsch","gastronomie.png")
    icon("Franzoesisch","gastronomie.png")
    icon("Griechisch","gastronomie.png")
    icon("Indisch","gastronomie.png")
    icon("Italienisch","gastronomie.png")
    icon("Spanisch","gastronomie.png")
    icon("Thailaendisch","gastronomie.png")
    icon("Geldautomat","geldautomat.png")
    icon("Aerzte","aerzte.png")
    icon("Apotheke","apotheke.png")
    icon("Krankenhaus","hospital.png")
    icon("Kinderbetreuung","childcare.png")
    icon("Bahnhaltstelle","trainstop.png")
    icon("Bahnhof","trainstation.png")
    icon("Bushaltestelle","busstop.png")
    icon("Car-Sharing_Punkt","carshare.png")
    icon("Fahrradverleih","bicyclerent.png")
    icon("Parkplatz","parking.png")
    icon("U-Bahn","ubahn.png")
    icon("Blumen","flower.png")
    icon("Drogeriemarkt","drogerie.png")
    icon("Elektronik","electronic.png")
    icon("Baeckerei","bakery.png")
    icon("Feinkostgeschaeft","delicacy.png")
    icon("Fisch","fish.png")
    icon("Metzgerei","butcher.png")
    icon("Mall","mall.png")
    icon("Schuhe","shoes.png")
    icon("Supermarkt","mall.png")
    icon("Textilien","texttile.png")
    icon("Strom_aus_nicht_regenerativen_Energien","fuel.png")
    icon("Strom_aus_regenerativen_Energien","fuelpump.png")
  end
end

namespace :map do
  desc 'Read in OSM data for Bremen'
  task :read_bremen => :environment do
    system "wget http://download.geofabrik.de/osm/europe/germany/bremen.osm.bz2"
    system 'osmosis --read-xml-0.6 file="bremen.osm.bz2" --write-apidb-0.6 populateCurrentTables=yes host="localhost" database="openstreetmap" user="openstreetmap" password="openstreetmap" validateSchemaVersion=no'
  end
end  

  def self.icon(cname,file)
    c=OntologyClass.find_by_name(cname)
    if !c.nil?
      c.iconfile = file
      c.save
    end  
  end  