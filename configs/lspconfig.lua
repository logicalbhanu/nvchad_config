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

-- adding lsp's here over which i want more control
-- setting up core functions of lsp's
local utils = require "core.utils"

-- adding custom_attach for separate on_attach functionalities.
local custom_attach = function(client, bufnr)
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

-- to enable the capabilities via nvim-cmp use this,
-- note that only one type of capabilities can be enabled 
-- either the one comes as the "default" in vim or the one
-- provided by cmp, and i found nvim-cmp capabilities
-- inferior to the default one of vim.
--M.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- setting up pylsp here
lspconfig.pylsp.setup {
  on_attach = custom_attach,
  settings = {
    pylsp = {
      plugins = {
        -- formatter options
        black = { enabled = true },
        autopep8 = { enabled = false },
        yapf = { enabled = false },
        -- linter options
        ruff = {
          enabled = true,
          --select = { "ALL" },
          -- this is to select the rules that we want to include
          -- in the diagnostics for the ruff lsp, similarly for format.
          format = { "ALL" },
          extendSelect = { "I" },
        },
        pylint = { enabled = false, executable = "pylint" },
        pyflakes = { enabled = false },
        pycodestyle = { enabled = false },
        -- type checker
        pylsp_mypy = { enabled = true },
        -- auto-completion options
        jedi_completion = { fuzzy = true },
        -- import sorting
        pyls_isort = { enabled = true },
      },
    },
  },
  flags = {
    debounce_text_changes = 200,
  },
  capabilities = capabilities,
}

-- setting up ruff for python will experiment it in future as not getting hover in this way
-- future approach is to use ruff from here and
-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
--
-- on_attach = function(client, bufnr)
--   client.server_capabilities.documentFormattingProvider = true
--   client.server_capabilities.documentRangeFormattingProvider = true
--   -- disabling it in favor of pylsp
--   client.server_capabilities.hoverProvider = true
--
--   utils.load_mappings("lspconfig", { buffer = bufnr })
--
--   if client.server_capabilities.signatureHelpProvider then
--     require("nvchad.signature").setup(client)
--   end
--
--   if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
--     client.server_capabilities.semanticTokensProvider = nil
--   end
-- end
--
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
