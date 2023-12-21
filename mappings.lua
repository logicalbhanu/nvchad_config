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
    ["<leader>Wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "[a]dd [W]orkspace folder",
    },

    ["<leader>Wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "[r]emove [W]orkspace folder",
    },

    ["<leader>Wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "[l]ist [W]orkspace folders",
    },

    -- this is to show sources in floating diagnostic, which is not
    -- available in the core config
    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded", source = true }
      end,
      "Floating diagnostic",
    },

    -- changing default which keymaps
    ["<leader>ka"] = {
      function()
        vim.cmd "WhichKey"
      end,
      "Which-key all keymaps",
    },
    ["<leader>kq"] = {
      function()
        local input = vim.fn.input "WhichKey: "
        vim.cmd("WhichKey " .. input)
      end,
      "Which-key query lookup",
    },
    -- changing default keybinding for toggling themes
    ["<leader>tt"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },
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

-- changing default keybindings of nvterm
M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<leader>th"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<leader>tf"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<leader>th"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<leader>tv"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}

M.spectacle = {
  n = {

    ["<leader>Sl"] = {
      function()
        require("spectacle").SpectacleTelescope()
      end,
      "[S]essions [l]ist",
    },
    ["<leader>Ss"] = {
      function()
        require("spectacle").SpectacleSave()
      end,
      "[S]essions [s]ave",
    },
    ["<leader>Sn"] = {
      function()
        require("spectacle").SpectacleSaveAs()
      end,
      "[S]essions save as [n]ew session",
    },
  },
}

M.project = {
  n = {

    ["<leader>fp"] = {
      function()
        require("telescope").extensions.projects.projects {}
      end,
      "[f]ind [p]rojects",
    },
  },
}
-- more keybinds!
-- search core.mappings for more info on defaults
-- keymaps
return M
