# Guide is here
#--------------
http://bost.ocks.org/mike/map/

# Create places.json
#-------------------
cd C:\Users\joren\Downloads\ne_10m_populated_places
ogr2ogr -f GeoJSON places.json ne_10m_populated_places.shp

# Create subunits.json
#---------------------
cd C:\Users\joren\Downloads\ne_10m_admin_0_map_subunits
ogr2ogr -f GeoJSON subunits.json ne_10m_admin_0_map_subunits.shp

# Merge places.json and subunits.json
#------------------------------------
cd /c/Users/joren/Documents/GitHub/protego/vendor
topojson -o world.json --id-property SU_A3 --properties name=NAME -- subunits.json places.json