# nvim-editconfig

This is Neovim plugin that automates some of the common tasks I perform for maintaining my Neovim
configuration.

This plugin is not generic. It is unlikely that anyone other than me will derive value from it.

-   ,cf => Configuration File - opens a selection list of configuration files.
-   gf  => In the `plugins.vim` file, this is overridden to navigate to included files.
-   ,ca => In the `plugins.vim` file, this is configured to add a new include, create the new file
    to include, and to open the new include file.

## Installation

### vim-plug

An example of how to load this plugin using vim-plug:

```VimL
Plug 'jacobsimpson/nvim-editconfig'
```

After running `:PlugInstall`, the files should appear in your `~/.config/nvim/plugged` directory (or
whatever path you have configured for plugins).

