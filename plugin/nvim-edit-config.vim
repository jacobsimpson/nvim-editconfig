
" The VimL/VimScript code is included in this file to demonstrate that the
" file is being loaded. It is not required for the Lua code to execute and can
" be deleted.

echo "nvim-edit-config.vim: VimL code executing."

function LuaDoItVimL()
    echo "nvim-edit-config.vim LuaDoItVimL(): hello"
endfunction

" Neovim knows about finding VimL files in the `plugin` directory, but it
" won't find Lua files in the same location. So, you need to bootstrap your
" Lua code using a VimL file. There are two possibilities:

" 1. Lua code can be embedded in a VimL file by using a lua block.
lua <<EOF
    function lua_do_it_lua()
        print("nvim-edit-config.vim lua_do_it_lua(): hello")
    end

    print "nvim-edit-config.vim: Lua code executing."
EOF

" 2. Lua code can be built in a pure Lua file and imported as a module from
" the VimL file. `editconfig` is a directory in the `lua` folder. Because
" only the `editconfig` directory is specified, Neovim will look for a
" `lua.lua` file, then an `init.lua` file in that directory. In this case, it
" will find the `lua\editconfig\init.lua` file.
lua editconfig = require("editconfig")

" Once the `require` statement completes, the `global_lua_function` Lua
" function defined in `lua\editconfig\init.lua` will be available without
" qualification.
lua global_lua_function()

" Once the `require` statement completes, the `local_lua_function` Lua
" function defined in `lua\editconfig\init.lua` will be available when
" qualified with the module name.
lua editconfig.local_lua_function()

" A Lua function can be mapped to a key. Here, Alt-Ctrl-G will echo a message.
" This is a mapping to the function that wasn't carefully scoped in the Lua
" file. Since this function was exported globally, that symbol is available
" everywhere, once the module has been loaded. (See the `require` statement
" above.)
nmap <M-C-G> :lua global_lua_function()<CR>

" A local Lua function can be mapped to a key, if it was exported from the
" module. Here, Alt-Ctrl-L will echo a message.  This is a mapping to the
" function that was qualified with `local`, so it is only available outside
" the module when qualified with the module name.  (See the `require`
" statement above.)
nmap <M-C-L> :lua editconfig.local_lua_function()<CR>

" Lua code can be defined in other files, rather than just `lua.lua` or
" `init.lua`. Here, Lua code is defined in `lua\editconfig\definestuff.lua`.
lua require("editconfig.definestuff").show_stuff()
