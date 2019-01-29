# osm-schools
Scripts to filter out schools from OpenStreetMaps data.

## Overview
### download-osm-data.sh
Download open street map data for very countries in *countries.txt* into a `.pbf`.

### extract-school-data.sh
- For every line in *countries.txt*, extract the country's name.
- Use the country name to get the country code in *countries.json*.
- Use Osmosis to extract school data from the downloaded `.pbf` files in the script above into `.osm` files.
- Finally, run *port-data-to-csv.sh*.

### port-data-to-csv.sh
- Extract school attributes like name, number of students for all the schools in a country.
- Use these attributes to build the columns for the csv file.

## Run
```
 - bash download-osm-data.sh
 - bash extract-school-data.sh
```

## Developer Background
- Bash
- [Osmosis](https://wiki.openstreetmap.org/wiki/Osmosis)
- [Osmosis to CSV](https://wiki.openstreetmap.org/wiki/Osmconvert)
