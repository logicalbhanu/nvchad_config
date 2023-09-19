local configs = require "plugins.configs.lspconfig"
local on_attach = configs.on_attach
local capabilities = configs.capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Without the loop, you would have to manually set up each LSP
--
-- lspconfig.html.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }
--
-- lspconfig.cssls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

--  ############################################## Configuring python lsp ##################################################    
--  #################################################################################################### 
--  #################################################################################################### 
--  #################################################################################################### 

-- lspconfig.pyright.setup { blabla}

-- setting up pylsp
local utils = require "core.utils"
on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

lspconfig.pylsp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    pylsp = {
      plugins = {
        -- disabling pycodestyle to use flake8
        pycodestyle = {
          enabled = false,
          ignore = { "W391" },
          maxLineLength = 100,
        },
        jedi_hover = { enabled = true },
        --jedi_completion = {eager = true},
        rope_autoimport = { enabled = true },
        mccabe = { enabled = false },
        pyflakes = { enabled = false },
        flake8 = { enabled = false, maxLineLength = 100 },
        black = { enabled = true },
        ruff = {
          enabled = true,
          --select = { "ALL" },      -- this is to select the rules that we want to include
                                     -- in the diagnostics for the ruff lsp, similarly for format.
          format = { "ALL" },
          extendSelect = { "I" },
        },
      },
    },
  },
}

-- setting up ruff for python will experiment it in future as not getting hover in this way
-- future approach is to use ruff from here and 
-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
-- lspconfig.ruff_lsp.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   init_options = {
--     settings = {
--       -- Any extra CLI arguments for `ruff` go here.
--       args = {},
--     },
--   },
-- }
--
--#######################################################################################################################
--#######################################################################################################################
--######################################### python lsp config ends here #################################################
--#######################################################################################################################
--#######################################################################################################################
