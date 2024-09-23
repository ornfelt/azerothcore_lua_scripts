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

## Installation
1. **Install LuaLS**: Follow the [LuaLS installation instructions](https://luals.github.io/#vscode-install).
2. **Configure Your Workspace**: Point your workspace/LSP configuration to the location of the generated definitions.

## Usage
1. Install Python 3, Pip, and dependencies:
    - [Python](https://www.python.org/)
    - [Pip](https://pip.pypa.io/en/stable/installation/)
    - [BeautifulSoup](https://pypi.org/project/beautifulsoup4/)
2. Generate LSP definitions:
    - **Windows**:
        1. Edit lines 2, 3, and 6 in `runParser.ps1`.
        2. Run the script.
    - **Linux**:
        1. Edit lines 4, 5, and 8 in `runParser.sh`.
        2. Run the script.
3. Configure your workspace/LSP to point to the location of your generated definitions.
