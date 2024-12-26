# LuaLS-Eluna-Parser
Parser to generate Eluna LSP definitions for LuaLS.

## Table of Contents
- [Overview](#overview)
- [Generate Definitions](#generate-definitions)
- [Installation](#installation)
- [Usage](#usage)

## Overview
LuaLS-Eluna-Parser is a tool designed to generate Language Server Protocol (LSP) definitions for the Lua Language Server (LuaLS) from the Eluna API documentation. This enhances the development experience by providing intelligent suggestions and autocompletion for methods and properties of Eluna objects.

## Generate Definitions
1. **Download Eluna API Documentation**: Obtain a copy of the [Eluna API documentation](https://github.com/ElunaLuaEngine/ElunaLuaEngine.github.io) files.
2. **Run the Parser**: Execute the parser on the documentation HTML files. An example of this process can be seen in the PowerShell or Bash script included in this repository.
3. **Completion**: Once the parser runs successfully, the generated definitions will be ready to use.

**OR**

Download the latest generated definitions from the build workflow action, alternatively from [this](https://nightly.link/Foereaper/LuaLS-Eluna-Parser/workflows/build/main/definitions.zip) link (provided by nightly).

## Installation
1. **Install LuaLS**: Follow the [LuaLS installation instructions](https://luals.github.io/#vscode-install).
2. **Configure Your Workspace**: Point your workspace/LSP configuration to the location of the generated definitions.
3. **Enable parameter inference**: In the LuaLS configuration, enable Lua.type.inferParamType, this is required for callback parameters to function properly.

## Usage
1. Install Python 3, Pip, and dependencies:
    - [Python](https://www.python.org/)
    - [Pip](https://pip.pypa.io/en/stable/installation/)
    - [BeautifulSoup](https://pypi.org/project/beautifulsoup4/)
2. Generate LSP definitions:\
The `parser.py` script will generate definitions for every method documentation HTML file in a specified directory. To make it easier to generate stubs for all method subdirectories in one go, I provide a couple helper scripts. The inputs are the same for both the powershell and the bash script. Expected inputs are:
    - Path to parser.py
    - Input directory (path to ElunaLuaEngine.github.io repository)
    - Output directory (where the stubs will be created)
    - Debug flag, optional, default false (provides some additional logging in the console)
    - **Example**:\
    `runParser.ps1 c:\path\to\parser.py c:\path\to\ElunaLuaEngine.github.io\repo c:\outputDirectory [debug(default false)]`
4. Configure your workspace/LSP to point to the location of your generated definitions.
