#!/usr/bin/env sh

mkdir -p combined-datasets
for area in $(find processed-datasets/ -type f -printf '%f\n' | sort -u); do
    (
        echo '{'
        first=1
        for dataset in $(find processed-datasets/ -name "$area"); do
            if [[ $first -eq 1 ]]; then
                first=0
            else
                echo ","
            fi
            echo -n '"'$(basename $(dirname $dataset))'":'
            cat $dataset
        done
        echo
        echo '}'
    ) > combined-datasets/$area
done
