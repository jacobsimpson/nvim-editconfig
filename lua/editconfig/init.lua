local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local baseDir = "~/dotfiles/nvim/"

-- By convention, nvim Lua plugins include a setup function that takes a table
-- so that users of the plugin can configure it using this pattern:
--
-- require'editconfig'.setup({p1 = "value1"})
local function setup(parameters)
    -- Something weird. When this vim.cmd is used, the keymapping is made, and ,ec activates the
    -- telescope picker, but not results are visible in the floating window. However, when this
    -- exact mapping moved into a VimL file, it works correctly.
    --vim.cmd [[ map <silent> ,ec :lua require('editconfig').add_plugin()<CR> ]]
end

local function process_input(plugin_name)
    if plugin_name == nil or plugin_name == "" then
        return
    end

    local _, _, short_name = string.find(plugin_name, "/(.*)")
    local relative_path = string.format("plugins/%s.vim", short_name)

    -- plugin_name = 'jiangmiao/auto-pairs'
    vim.api.nvim_put({
        '',
        string.format([[call SourceConfig("%s")]], relative_path),
        '',
        ''
    }, "", false, true)
    vim.api.nvim_command(string.format('edit %s/%s', baseDir, relative_path))
    vim.api.nvim_put({
        '',
        string.format([[Plug '%s']], plugin_name),
        '',
        ''
    }, "", false, true)
end

local function add_plugin()
    vim.ui.input("Plugin to add: ", process_input)
end

local function go_file()
    local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_buf_get_lines(0, row-1, row, false)[1]
    local _, _, p = string.find(line, [[SourceConfig%("(.-)"%)]])

    if p ~= nil then
        vim.api.nvim_command('edit ' .. baseDir .. p)
    end
end

return {
    setup      = setup,
    add_plugin = add_plugin,
    go_file    = go_file,
}
