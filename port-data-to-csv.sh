xml_file=CMR.osm
declare -A attributes

echo "Extracting school attributes names for csv file..."
while IFS="\>" read -d \< tag; do
    key=$(echo $tag | awk -F'k="' '{print $2}' | cut -d '"' -f 1)
    if [[ $key != '' ]]; then
        attributes["$key"]="$key"
        # echo $key
    fi
done < "$xml_file"
echo "Done."

columns_str=""
for key in "${attributes[@]}"; do
    if [[ $key == 'lat' ]]; then
        columns_str="${columns_str}@${key} "
    else
        columns_str="${columns_str}${key} "
    fi
done
echo $columns_str