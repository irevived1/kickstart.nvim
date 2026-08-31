-- Add rounded borders to LSP floating windows (hover, code actions, diagnostics)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })
vim.diagnostic.config { float = { border = "rounded" } }

return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  -- example using `opts` for defining servers
  opts = {
    servers = {
      ts_ls = {},
      --
      html = { filetypes = { 'html', 'twig', 'hbs' } },
      cssls = {},
      tailwindcss = {},
      dockerls = {},
      sqlls = {},
      jsonls = {},
      yamlls = {},
      lua_ls = {},
    },
  },
  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      vim.lsp.config(server, config)
    end
  end,
}
