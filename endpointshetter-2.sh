#!/bin/bash
# --- Configuratie ---
SOURCE_FILE="/mnt/efs/rds-endpoint"        # bestand met RDS endpoint
TARGET_FILE="src/Web/appsettings.json"
TARGET_FILE1="src/PublicApi/appsettings.json"
SEARCH_PATTERN="<RDS-ENDPOINT>"

# Lees endpoint uit
STRING_TO_INSERT=$(head -n 1 "$SOURCE_FILE")

# Controleer of het endpoint bestaat
if [[ -z "$STRING_TO_INSERT" ]]; then
  echo " Fout: RDS endpoint niet gevonden in $SOURCE_FILE"
  exit 1
fi

# Controleer of de appsettings-bestanden bestaan
if [[ ! -f "$TARGET_FILE" ]]; then
  echo " Fout: Doelbestand $TARGET_FILE bestaat niet"
  exit 1
fi

# Vervang placeholder in beide appsettings.json-bestanden
sed -i "s|$SEARCH_PATTERN|$STRING_TO_INSERT|g" "$TARGET_FILE"
sed -i "s|$SEARCH_PATTERN|$STRING_TO_INSERT|g" "$TARGET_FILE1"

