xml_file="schools/osm/$1.osm"
declare -A attributes

echo "Extracting school attributes names for csv file..."
while IFS="\>" read -d \< tag; do
    key=$(echo $tag | awk -F'k="' '{print $2}' | cut -d '"' -f 1)
    if [[ $key != '' ]] && [[ $key != *" "* ]]; then
        attributes["$key"]="$key"
    fi
done < "$xml_file"
echo "Done."
echo ""

columns_str=""
for key in "${attributes[@]}"; do
    if [[ $key != 'lat' ]] && [[ $key != 'long' ]] && [[ $key != 'name' ]]; then
        columns_str="${columns_str}${key} "
    fi
done

osmconvert $xml_file --all-to-nodes --csv="@id @lon @lat name $columns_str"  --csv-headline --csv-separator=, >  "schools/osm/$1.csv"