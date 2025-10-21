#!/bin/bash
# --- Configuratie ---
SOURCE_FILE="/mnt/efs/rds-endpoint"  # bestand met RDS endpoint (één regel)
TARGET_FILE="src/Web/appsettings.json"
SEARCH_PATTERN="<RDS-ENDPOINT>"

# Lees endpoint uit
STRING_TO_INSERT=$(head -n 1 "$SOURCE_FILE")

# Controleer of bestand en string bestaan
if [[ -z "$STRING_TO_INSERT" ]]; then
  echo "Fout: RDS endpoint niet gevonden in $SOURCE_FILE"
  exit 1
fi
if [[ ! -f "$TARGET_FILE" ]]; then
  echo "Fout: Doelbestand $TARGET_FILE bestaat niet"
  exit 1
fi

# Vervang placeholder
sed -i "s|$SEARCH_PATTERN|$STRING_TO_INSERT|g" "$TARGET_FILE"

echo "Vervanging voltooid: '$SEARCH_PATTERN' → '$STRING_TO_INSERT' in $TARGET_FILE"
