#!/bin/bash
# --- Configuratie ---
SOURCE_FILE="/mnt/efs/rds-endpoint"  # bestand met RDS endpoint (één regel)
TARGET_FILE="src/Web/appsettings.json"
TARGET_FILE1="src/PublicApi/appsettings.json"
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
sed -i "s|$SEARCH_PATTERN|$STRING_TO_INSERT|g" "$TARGET_FILE1"

# Vervang ook in docker-stack.yml als het bestaat
if [[ -f "docker-stack.yml" ]]; then
  sed -i "s|$SEARCH_PATTERN|$STRING_TO_INSERT|g" "docker-stack.yml"
  echo "Vervanging voltooid in docker-stack.yml"
fi

# --- ACCOUNT ID VERVANGING ---
ACCOUNT_PLACEHOLDER="<ACCOUNT-ID>"

if [[ -n "$AWS_ACCOUNT_ID" ]]; then
  sed -i "s|$ACCOUNT_PLACEHOLDER|$AWS_ACCOUNT_ID|g" "docker-stack.yml"
  echo "Vervanging voltooid: '$ACCOUNT_PLACEHOLDER' → '$AWS_ACCOUNT_ID' in docker-stack.yml"
else
  echo "Waarschuwing: AWS_ACCOUNT_ID niet ingesteld, skipping account-ID vervanging."
fi

echo "Vervanging voltooid: '$SEARCH_PATTERN' → '$STRING_TO_INSERT' in $TARGET_FILE"
