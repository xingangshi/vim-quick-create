# Quick Create Vim Plugin

Quick Create is a Vim plugin that provides convenient commands and mappings for quickly creating files and directories.

## Features

- Create files and directories with a single command
- Automatically create parent directories if they don't exist
- Create files in the current directory with a simplified command
- Keyboard shortcuts for quick access to file and directory creation

## Installation

### Using a Plugin Manager (recommended)

If you use a plugin manager like [vim-plug](https://github.com/junegunn/vim-plug), add the following line to your `~/.vimrc`:

vim

Plugin 'xingangshi/vim-quick-create.vim'


Then run `:PlugInstall` in Vim.

### Verifying Installation

After installation, you can verify that the plugin is working correctly by:

1. Opening Vim and running `:help vim-quick-create`. This should open the plugin's help file.
2. Trying one of the commands, such as `:CreateHere test.txt`. This should create a new file in the current directory.

## Usage

Quick Create provides three main commands:

- `:CreateFile {path}`: Create a new file at the specified path
- `:CreateDir {path}`: Create a new directory at the specified path
- `:CreateHere {filename}`: Create a new file in the directory of the current buffer

### Default Mappings

- `<Leader>cf`: Prompt to create a new file
- `<Leader>cd`: Prompt to create a new directory
- `<Leader>ch`: Prompt to create a new file in the current directory

Note: `<Leader>` is usually the `\` key. See `:help mapleader` for more information.

## Examples

### Create a new file

```
:CreateFile ~/projects/new_project/src/main.js
Or press `<Leader>cf` and type the path.
```

### Create a new directory

```
:CreateDir ~/projects/new_project/config
Or press `<Leader>cd` and type the path.
```

### Create a new file in the current directory

```
:CreateHere styles.css
Or press `<Leader>ch` and type the filename.
```
### Create a file in a new directory
```
:CreateFile ~/projects/new_project/tests/unit/testCase1.js

```
This will create both the `tests/unit` directory (if it doesn't exist) and the `testCase1.js` file.

## Customization

To change the default mappings, add lines like these to your `~/.vimrc`:

```
nmap <Leader>nf <Plug>QuickCreateFile
nmap <Leader>nd <Plug>QuickCreateDir
nmap <Leader>nh <Plug>QuickCreateHere
```


## Documentation

For full documentation, run `:help vim-quick-create` in Vim after installing the plugin. This will provide detailed information on all commands, mappings, and customization options.

## License

This plugin is distributed under the same terms as Vim itself. See `:help license` for more details.

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

