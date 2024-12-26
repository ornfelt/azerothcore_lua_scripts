# Check if the required number of arguments is provided
if ($Args.Count -lt 3) {
    Write-Host "Usage: runParser.ps1 <parserScriptPath> <htmlParentDirectory> <outputDirectory> [debug(false)]"
    exit 1
}

$parserScriptPath = $Args[0]        # Path to parser.py
$htmlParentDirectory = $Args[1]     # Path to ElunaLuaEngine.github.io repository
$outputDirectory = $Args[2]         # Path to output directory
$debug = $false                     # Default debug value

if ($Args.Count -ge 4) {
    $debug = [bool]$Args[3]
}

# Define the list of subdirectories to process
$subdirectories = @("Aura", "BattleGround", "Corpse", "Creature", "ElunaQuery", "GameObject", "Group", "Guild", "Global", "Item", "Map", "Object", "Player", "Quest", "Spell", "Unit", "Vehicle", "WorldObject", "WorldPacket")

# Iterate over each subdirectory
foreach ($subdir in $subdirectories) {
    $htmlDirectory = Join-Path -Path $htmlParentDirectory -ChildPath $subdir
    python $parserScriptPath $htmlDirectory $outputDirectory $debug
}
