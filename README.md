# OpenCode Portable (Windows)

Self-contained portable launcher for **[OpenCode AI](https://github.com/anomalyco/opencode)** on Windows.  
No system-wide Node.js installation required.

## Requirements
- Windows 10 / 11
- PowerShell available (default on Windows)

## Usage

1. Clone the repository to your machine:

   git clone https://github.com/sardukar/opencode-portable.git

2. Change into the repository directory:

   cd opencode-portable

3. Launch OpenCode by running:

   start-opencode.cmd

## Running from any project directory

You can use this launcher in two convenient ways.

### Option 1: Add to PATH (recommended)

You can add the folder containing `start-opencode.cmd` to your system `PATH`.
After that, OpenCode can be launched from **any project directory** by simply running:

```bat
start-opencode
```

In this case, OpenCode will start using the current working directory as the project directory.
This is the most convenient option if you use OpenCode frequently across multiple projects.

### Option 2: Run via full path to the script

Alternatively, you can run the script by specifying its full path while being inside your project directory, for example:

```bat
C:\tools\opencode-portable\start-opencode.cmd
```

This allows you to keep the launcher in a central location without modifying PATH.
In both cases, OpenCode will operate relative to the directory from which the command was executed.

## Optional: opencode.json

An optional `opencode.json` is included for configuring OpenCode with local Ollama models.
Replace the example models with the ones available on your system.

