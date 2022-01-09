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

local function add_plugin()
    vim.api.nvim_put({ '', [[call SourceConfig("plugins/xyz.vim")]], '', '' }, "", false, true)
    vim.api.nvim_command('edit ' .. baseDir .. 'plugins/xyz.vim')
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
