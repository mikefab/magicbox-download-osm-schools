file=countries.txt

while IFS="" read -r filename_path; do
    filename=$(echo ${filename_path} | cut -d '/' -f 2)
    country=$(echo ${filename} | cut -d '.' -f 1 | rev | cut -d '-' -f 2- |\
                rev  | sed -e 's/\b\(.\)/\u\1/g' | sed -e 's/And/and/g')
    if [[ $country != 'Guinea-Bissau' ]]; then
        if [[ $country == 'Congo-Brazzaville' ]]; then
            country='Congo'
        elif [[ $country == 'Congo-Democratic-Republic' ]]; then
            country='Congo (Democratic Republic of the)'
        elif [[ $country == 'Tanzania' ]]; then
            country='Tanzania, United Republic of'
        elif [[ $country == 'Ivory-Coast' ]]; then
            country="Côte d'Ivoire"
        elif [[ $country == 'Cape-Verde' ]]; then
            country='Cabo Verde'
        elif [[ $country == 'Saint-Helena-Ascension-and-Tristan-Da-Cunha' ]]; then
            country='Saint Helena, Ascension and Tristan da Cunha'
        else
            country=$(echo $country | sed 's/-/ /g')
        fi
    fi

    echo "Extracting $country school data"
    if [[ ! -e "schools/osm/pbf/$filename" ]]; then
        echo "schools/osm/pbf/$filename file does not exist"
        exit 1
    fi
    country_code=$(jq --arg COUNTRY "${country}" '.[] | select(.name == $COUNTRY) | ."alpha-3"' countries.json)
    country_code=$(echo ${country_code} | sed -e 's/"//g')
    osmosis --rbf schools/osm/pbf/$filename --nkv keyValueList="amenity.school" --wx schools/osm/osm/$country_code.osm

    ./port-data-to-csv.sh $country_code
done < "$file"