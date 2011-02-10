namespace :ontology do
  desc 'Read in OSM ontologies'
  task :read => :environment do
    # delete old stuff and read in ontologies
    Ontology.all.each do |o| o.destroy end
    OntologyMapping.all.each do |o| o.destroy end
    puts "Reading ../MappingFiles/activity-eng.owl"
    s = Ontology.read_ontology("../MappingFiles/activity-eng.owl","activities")
    puts "Reading ../MappingFiles/tags.owl"
    t = Ontology.read_ontology("../MappingFiles/tags.owl","tags")
    puts "Reading ../MappingFiles/map.view"
    om = OntologyMapping.read_mapping("../MappingFiles/map.view","activities2tags",s,t)

  
  
   
#    icon("Strom_aus_nicht_regenerativen_Energien","fuel.png")
#    icon("Strom_aus_regenerativen_Energien","fuelpump.png")

  icon("Education","bildungseinrichtungen.png")
  icon("Bookstore","mall.png")
  icon("Drugstore","mall.png")
  icon("Flowers","flower.png")
  icon("Delicatessen","delicacy.png")
  icon("Camping","hotel.png")
  icon("Guestroom","hotel.png")
  icon("YouthHostel","hotel.png")
  icon("Minigolf",".png")
  icon("Churches","christian.png")
  icon("Mosques","muslim.png")
  icon("Synagogues","jewish.png")
  icon("Kindergarten","childcare.png")
  icon("Wellness","fitness.png")
  icon("ChargingStation","battery.png")
  icon("supermarket","mall.png")
  icon("BicycleRental","bicyclerent.png")
  icon("Electronics","electronics.png")
  icon("PostOffice","post_office.png")
  icon("Furniture","mall.png")
  icon("CarSharing","carshare.png")
  icon("Stationery","mall.png")
  icon("Pharmacy","apotheke.png")
  icon("Hospital","hospital.png")
  icon("College","education.png")
  icon("Library","library.png")
  icon("FastFood","fastfood.png")
  icon("BusStop","busstop.png")
  icon("Parking","parking.png")
  icon("Police","police.png")
  icon("Subway","ubahn.png")
  icon("Opera","oper.png")
  icon("Hairdressers","hairdresser.png")
  icon("Mall","mall.png")
  icon("Toys","mall.png")
  icon("Restaurants","restaurant.png")
  icon("Tram","busstop.png")
  icon("ATM","geldautomat.png")
  icon("Hostels","hotel.png")
  icon("Motels","hotel.png")
  icon("Hotels","hotel.png")
  icon("Cafes","cafe.png")
  icon("Universities","education.png")
  icon("Shopping","mall.png")
  icon("Clothing","texttile.png")
  icon("SwimmingPool","swimming.png")
  icon("American","restaurant.png")
  icon("Japanese","restaurant.png")
  icon("Cuisine","restaurant.png")
  icon("Theatre","theatre.png")
  icon("Mexican","restaurant.png")
  icon("Turkish","restaurant.png")
  icon("Doctors","aerzte.png")
  icon("Italian","restaurant.png")
  icon("Chinese","restaurant.png")
  icon("Spanish","restaurant.png")
  icon("Cinema","kino.png")
  icon("Museum","museum.png")
  icon("German","restaurant.png")
  icon("French","restaurant.png")
  icon("Indian","restaurant.png")
  icon("Sushi","restaurant.png")
  icon("Pizza","restaurant.png")
  icon("Sauna","restaurant.png")
  icon("Park","park.png")
  icon("Thai","restaurant.png")
  icon("Fish","fish.png")
  icon("Bank","bank.png")
  icon("Shoes","shoes.png")
  icon("Butchers","butcher.png")
  
  icon("Ruins",".png")
  icon("Leisure",".png")
  icon("Landscape",".png")
  icon("Health",".png")
  icon("PublicTransport",".png")
  icon("SportAndFitness",".png")
  icon("Vegetarian",".png")
  icon("Forests",".png")
  icon("Climbing",".png")
  icon("Computer",".png")
  icon("Tourism",".png")
  icon("Massage",".png")
  icon("Soccer",".png")
  icon("Hiking",".png")
  icon("Bakery",".png")
  icon("PlacesOfWorship",".png")
  icon("Greek",".png")
  icon("Dance",".png")
  icon("GolfCourses",".png")
  icon("Opticians",".png")
  icon("Valleys",".png")
  icon("Castles",".png")
  icon("Rivers",".png")
  icon("Finance",".png")
  icon("TravelAgencies",".png")
  icon("FitnessStudio",".png")
  icon("InformationService",".png")
  icon("Bowling",".png")

# not needed
  icon("Address",".png")
  icon("OpeningHours",".png")

    # mark mapped classes that have an icon as interesting
    om.ontology_mapping_elements.each do |m|
      c = m.source
      if !c.iconfile.nil? and !c.iconfile.empty?
        c.mark_interesting
      end
    end
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
    else
      puts "#{cname} not found"
    end  
  end  
  
