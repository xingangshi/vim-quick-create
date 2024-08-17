# Quick Create Vim Plugin

Quick Create is a Vim plugin that provides convenient commands and mappings for quickly creating files and directories, as well as additional file management features.

## Features

- Create files and directories with a single command
- Automatically create parent directories if they don't exist
- Create files in the current directory with a simplified command
- Delete files and directories
- Rename files and directories
- Toggle file explorer
- Quick menu for easy access to all functionalities
- Keyboard shortcuts for quick access to all features

## Installation

### Using a Plugin Manager (recommended)

If you use a plugin manager like vim-plug, add the following line to your ~/.vimrc:

Plug 'yourusername/vim-quick-create'

Then run :PlugInstall in Vim.

### Verifying Installation

After installation, you can verify that the plugin is working correctly by:

1. Opening Vim and running :help vim-quick-create. This should open the plugin's help file.
2. Trying one of the commands, such as :CreateHere test.txt. This should create a new file in the current directory.

## Usage

Quick Create provides the following main commands:

- :CreateFile {path}: Create a new file at the specified path
- :CreateDir {path}: Create a new directory at the specified path
- :CreateHere {filename}: Create a new file in the directory of the current buffer
- :ToggleExplorer: Toggle the file explorer
- :DeletePath {path}: Delete a file or directory
- :DeleteCurrent: Delete the current file
- :RenameFile: Rename a file or directory
- :QuickMenu: Open the Quick Create Menu

### Default Mappings

- <Leader>cf: Prompt to create a new file
- <Leader>cd: Prompt to create a new directory
- <Leader>ch: Prompt to create a new file in the current directory
- <Leader>te: Toggle file explorer
- <Leader>dp: Delete a file or directory
- <Leader>dc: Delete the current file
- <Leader>rf: Rename a file
- <Leader>qm: Open the Quick Create Menu

Note: <Leader> is usually the \ key. See :help mapleader for more information.

### Quick Menu

Access all functionalities through an easy-to-use menu:

1. Create File
2. Create Directory
3. Create File Here
4. Toggle Explorer
5. Delete Path
6. Delete Last Opened File
7. Rename File
8. Rename Current File

Use number keys or <CR> to select an option, 'q' to close the menu.

## Examples

### Create a new file

:CreateFile ~/projects/new_project/src/main.js

Or press <Leader>cf and type the path.

### Create a new directory

:CreateDir ~/projects/new_project/config

Or press <Leader>cd and type the path.

### Create a new file in the current directory

:CreateHere styles.css

Or press <Leader>ch and type the filename.

### Create a file in a new directory

:CreateFile ~/projects/new_project/tests/unit/testCase1.js

This will create both the tests/unit directory (if it doesn't exist) and the testCase1.js file.

## Customization

To change the default mappings, add lines like these to your ~/.vimrc:

nmap <Leader>nf <Plug>QuickCreateFile
nmap <Leader>nd <Plug>QuickCreateDir
nmap <Leader>nh <Plug>QuickCreateHere
nmap <Leader>ne <Plug>ToggleExplorer
nmap <Leader>np <Plug>DeletePath
nmap <Leader>nc <Plug>DeleteCurrent
nmap <Leader>nr <Plug>RenameFile
nmap <Leader>nm <Plug>QuickMenu

To set the width of the file explorer window:

let g:netrw_winsize = 25

## Documentation

For full documentation, run :help vim-quick-create in Vim after installing the plugin. This will provide detailed information on all commands, mappings, and customization options.

## License

This plugin is distributed under the same terms as Vim itself. See :help license for more details.

## Contributing

Contributions are welcome! If you'd like to contribute, please:

1. Fork the repository
2. Create a new branch for your feature
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request

Please ensure your code adheres to the existing style and includes appropriate documentation and tests.

## Issues

If you encounter any problems or have suggestions for improvements, please open an issue on the GitHub repository. When reporting issues, please include:

- Your Vim version
- Your operating system
- Steps to reproduce the issue
- Any relevant error messages or unexpected behavior

## Changelog

- v1.0.0 (2024-08-16): Initial release
- v1.1.0 (2024-09-01): Added file deletion, renaming, and Quick Menu features