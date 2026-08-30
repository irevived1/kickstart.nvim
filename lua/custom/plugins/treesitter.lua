return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    build = ':TSUpdate',
    dependencies = {
      'windwp/nvim-ts-autotag',
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      require('nvim-treesitter').setup {
        auto_install = true,
        -- enable syntax highlighting
        highlight = {
          enable = true,
        },
        -- enable indentation
        indent = { enable = true },
        -- enable autotagging (w/ nvim-ts-autotag plugin)
        autotag = {
          enable = true,
        },
        -- ensure these language parsers are installed
        ensure_installed = {
          'json',
          'javascript',
          'typescript',
          'tsx',
          'yaml',
          'html',
          'css',
          'prisma',
          'markdown',
          'markdown_inline',
          'graphql',
          'bash',
          'lua',
          'vim',
          'dockerfile',
          'gitignore',
          'query',
          'vimdoc',
          'c',
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
              ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v',   -- charwise
              ['@function.outer'] = 'V',    -- linewise
              ['@class.outer'] = '<c-v>',   -- blockwise
            },
            include_surrounding_whitespace = true,
          },
        },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    build = ':TSUpdate',
  },
}
