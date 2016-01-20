#!/bin/bash

build()
{
	for F in $(ls "$1"); do
		if [ -d "$1/$F" ]; then
			mkdir -p "$2/$F"
			build "$1/$F" "$2/$F"
		else
			html=$(sed 's/\.md$/.html/' <<< "$F")
			cmark < "$1/$F" > "$2/$html"
		fi
	done
}

echo "Building..."
postcss --use autoprefixer --use precss --use postcss-nesting -o theme/css/style.css theme/postcss/style.css
rm -r input
build "raw" "input"

housecat .
echo "Done."
