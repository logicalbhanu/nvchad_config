---@type MappingsTable
local M = {}
M.disabled = {
  n = {
    -- disabling default workspace bindings
    ["<leader>wa"] = "",
    ["<leader>wl"] = "",
    ["<leader>wr"] = "",
    --disabling default which key info mappings
    ["<leader>wk"] = "",
    ["<leader>wK"] = "",
    ["<leader>th"] = "",
  },
}
M.general = {
  n = {
    -- nowait is good as it tells neovim not to wait for any other keybinds
    -- that have same starting key, but it can create unusability of that
    -- keybind so use with caution
    ["<leader>w"] = { "<cmd>w<cr>", "write file", opts = { nowait = true } },
    ["<leader>q"] = { "<cmd>confirm q<cr>", "quit file", opts = { nowait = true } },
    ["<S-t>"] = { ":b#<cr>", desc = "last used buffer" },

    -- changing deafault workspace MappingsTable
    ["<leader>sa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add work[S]pace folder",
    },

    ["<leader>sr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove work[S]pace folder",
    },

    ["<leader>sl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List work[S]pace folders",
    },

    -- better buffer navigation
    -- ["<S-h>"] = { ":bp<cr>", desc = "previous buffer" },
    -- ["<S-l>"] = { ":bn<cr>", desc = "Next buffer" },
    -- evidentily i found that the nvchad has tab and shift-tab set
    -- for buffer navigation, which is much better than this

    -- overiding nvimtreetoggle default keybinding
    ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    -- focus nvimtree,
    -- note that to focus back simply press 'o' and focus is back to
    -- buffer.
    ["<leader>o"] = {
      function()
        if vim.bo.filetype == "NvimTree" then
          vim.cmd.wincmd "p"
        else
          vim.cmd.NvimTreeFocus()
        end
      end,
      "Toggle nvimtree Focus",
    },
  },
  t = {

    -- shift-escape to exit terminal
    ["<S-Esc>"] = { "<C-\\><C-n>:q<cr>", desc = "Terminal quit" },
    -- Window movement from terminal and within the terminal(toggleterm is also a temrinal)
    ["<C-w>h"] = { "<C-\\><C-n><C-w>h", desc = "window left" },
    ["<C-w>j"] = { "<C-\\><C-n><C-w>j", desc = "window below" },
    ["<C-w>k"] = { "<C-\\><C-n><C-w>k", desc = "window above" },
    ["<C-w>l"] = { "<C-\\><C-n><C-w>l", desc = "window right" },
    -- to enable cycling between windows smooth in terminal(toggleterm)
    ["<C-w><C-w>"] = { "<C-\\><C-n><C-w><C-w>", desc = "cycle window" },

    ["<leader><ESC>"] = { "<C-\\><C-n>", desc = "Normal mode" },
  },
}

-- more keybinds!
-- search core.mappings for more info on defaults
-- keymaps
return M
