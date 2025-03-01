# DOS Assembly Game

Welcome to the DOS Assembly Game! This is a simple two-player game written in Assembly language that runs on DOS. The game involves two players controlling characters on the screen, and the objective is to avoid collisions while moving around.

## Table of Contents
- [Prerequisites](#prerequisites)
- [Building the Project](#building-the-project)
- [Running the Project](#running-the-project)
- [How to Play](#how-to-play)
- [Code Overview](#code-overview)
- [Language and Comments](#language-and-comments)


## Prerequisites

To build and run this project, you will need the following tools:

1. **DOSBox**: An x86 emulator with DOS that allows you to run DOS programs on modern operating systems.
2. **MASM (Microsoft Macro Assembler)**: An assembler for compiling Assembly code.
3. **LINK (Microsoft Linker)**: A linker for linking object files into an executable.

You can download DOSBox from [here](https://www.dosbox.com/). MASM and LINK are part of the Microsoft Macro Assembler package, which can be found online.

## Building the Project

1. **Set Up Your Environment**:
   - Install DOSBox and set up a directory where you will store your Assembly files.
   - Place the `MASM` and `LINK` executables in the same directory as your Assembly file.

2. **Assemble the Code**:
   - Open DOSBox and navigate to the directory containing your Assembly file (e.g., `game.asm`).
   - Use the following command to assemble the code:
     ```bash
     masm game.asm;
     ```
   - This will generate an object file (`game.obj`).

3. **Link the Object File**:
   - Use the following command to link the object file into an executable:
     ```bash
     link game.obj;
     ```
   - This will generate an executable file (`game.exe`).

## Easier Building with `b.bat`

To simplify the build process, a batch file (`b.bat`) is provided. This script automates the compilation and linking of the Assembly code using **MASM** and **LINK**. It also cleans up intermediate files and runs the resulting executable.

### How to Use `b.bat`

1. Place `b.bat` in the same directory as your Assembly file.
2. Open a command prompt or DOSBox and navigate to the directory.
3. Run the following command:
   ```bash
   b.bat tron
   ```

## Running the Project

1. **Run the Executable**:
   - In DOSBox, simply type the name of the executable to run the game:
     ```bash
     game.exe
     ```
   - The game should start, and you will be presented with a menu.

2. **Navigate the Menu**:
   - Use the `Enter` key to start the game.
   - Use the `Esc` key to exit the game.

## How to Play

- **Player 1** controls one character using the arrow keys:
  - **Up Arrow**: Move up.
  - **Down Arrow**: Move down.
  - **Left Arrow**: Move left.
  - **Right Arrow**: Move right.

- **Player 2** controls another character using the `W`, `A`, `S`, `D` keys:
  - **W**: Move up.
  - **S**: Move down.
  - **A**: Move left.
  - **D**: Move right.

- The objective is to avoid colliding with each other or the walls.
- The game will end if a collision occurs, and the winner will be declared.

## Code Overview

The code is divided into several sections:

- **Initialization**: The game starts by setting up the VGA graphics mode and initializing player positions.
- **Main Loop**: The game loop handles player input, updates player positions, and checks for collisions.
- **Rendering**: The game renders the players and the game field in VGA mode.
- **Collision Detection**: The game checks for collisions between players and the walls.

## Language and Comments

The source code for this project is written in **Assembly language** and includes comments and variables in **Hungarian**. The comments explain the functionality of the code, making it easier to understand for developers.
