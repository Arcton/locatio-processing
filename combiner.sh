#!/usr/bin/env sh

mkdir -p combined-datasets
unset area
unset file
# sort files by their basename
find processed-datasets/ -type f | perl -e 'print sort{($p=$a)=~s!.*/!!;($q=$b)=~s!.*/!!;$p cmp$q}<>' | while read path; do
    _area=$(basename $path)
    if [[ "$_area" != "$area" ]]; then
        area=$_area
        if [[ "$file" != "" ]]; then
            echo "}" >&3
        fi
        file=combined-datasets/$area
        exec 3<> $file
        echo "{" >&3
    else
        echo "," >&3
    fi
    dataset=$(basename $(dirname $path))
    echo '"'$dataset'": ' >&3
    cat $path >&3
done
