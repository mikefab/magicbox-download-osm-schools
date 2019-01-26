file=countries.txt

while IFS="" read -r country; do
    echo ""
    echo "Downloading $country OSM data..."
    wget "https://download.geofabrik.de/$country" -P schools/osm/pbf
    sleep 5
done < "$file"
