#!/bin/bash

# --- Configuratie ---
SOURCE_FILE="connectionstring.txt"
TARGET_FILE="src/Web/appsettings.json"
SEARCH_PATTERN="<RDS-ENDPOINT>"

STRING_TO_INSERT=$(head -n 1 "$SOURCE_FILE")

sed -i "s|$SEARCH_PATTERN|$STRING_TO_INSERT|g" "$TARGET_FILE"

# Amazon linux
# sed -i "" "s|$SEARCH_PATTERN|$STRING_TO_INSERT|g" "$TARGET_FILE"

echo "Vervanging voltooid: '$SEARCH_PATTERN' → '$STRING_TO_INSERT' in $TARGET_FILE"
