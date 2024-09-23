#!/bin/bash

# Define the paths to the parser script and the parent directory containing Eluna API HTML files
parserScriptPath="./parser.py"
htmlParentDirectory="/path/to/ElunaLuaEngine.github.io-master"

# Define the output directory for the LuaLS workspace
outputDirectory="/path/to/LuaLS/Workspace"

# Define the list of subdirectories to process
subdirectories=("Aura" "BattleGround" "Corpse" "Creature" "ElunaQuery" "GameObject" "Group" "Guild" "Global" "Item" "Map" "Object" "Player" "Quest" "Spell" "Unit" "Vehicle" "WorldObject" "WorldPacket")

# Iterate over each subdirectory
for subdir in "${subdirectories[@]}"; do
    htmlDirectory="${htmlParentDirectory}/${subdir}"
    python3 "$parserScriptPath" "$htmlDirectory" "$outputDirectory"
done
