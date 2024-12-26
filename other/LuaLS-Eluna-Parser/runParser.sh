#!/bin/bash

# Check if the required number of arguments is provided
if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <parserScriptPath> <htmlParentDirectory> <outputDirectory>"
    exit 1
fi

# Assign input arguments to variables
parserScriptPath="$1"        # Path to parser.py
htmlParentDirectory="$2"     # Path to ElunaLuaEngine.github.io repository
outputDirectory="$3"         # Path to output directory
debug="${4:-false}"

# Define the list of subdirectories to process
subdirectories=("Aura" "BattleGround" "Corpse" "Creature" "ElunaQuery" "GameObject" "Group" "Guild" "Global" "Item" "Map" "Object" "Player" "Quest" "Spell" "Unit" "Vehicle" "WorldObject" "WorldPacket")

# Iterate over each subdirectory
for subdir in "${subdirectories[@]}"; do
    htmlDirectory="${htmlParentDirectory}/${subdir}"
    python3 "$parserScriptPath" "$htmlDirectory" "$outputDirectory" "$debug"
done
