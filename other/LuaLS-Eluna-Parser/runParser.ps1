# Define the paths to the parser script and the parent directory containing Eluna API HTML files
$parserScriptPath = "C:\Path\To\parser.py"
$htmlParentDirectory = "C:\Path\To\ElunaLuaEngine.github.io-master"

# Define the output directory for the LuaLS workspace
$outputDirectory = "C:\Path\To\LuaLS\Workspace"

# Define the list of subdirectories to process
$subdirectories = @("Aura", "BattleGround", "Corpse", "Creature", "ElunaQuery", "GameObject", "Group", "Guild", "Global", "Item", "Map", "Object", "Player", "Quest", "Spell", "Unit", "Vehicle", "WorldObject", "WorldPacket")

# Iterate over each subdirectory
foreach ($subdir in $subdirectories) {
    $htmlDirectory = Join-Path -Path $htmlParentDirectory -ChildPath $subdir
    python $parserScriptPath $htmlDirectory $outputDirectory
}