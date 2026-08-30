return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<Tab>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
      panel = { enabled = false },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    opts = {
      adapters = {
        http = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = {
                api_key = os.getenv 'ANTHROPIC_API_KEY',
                model = 'claude-sonnet-4-20250514',
              },
            })
          end,
        },
      },
      strategies = {
        chat = { adapter = 'anthropic' },
        inline = { adapter = 'anthropic' },
        agent = { adapter = 'anthropic' },
      },
      display = {
        action_palette = {
          provider = 'snacks',
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
            title = 'CodeCompanion actions',
          },
        },
      },
      opts = {
        log_level = 'DEBUG',
      },
    },
  },

  -- Inline AI transforms: select code, press \k, type instruction → replaced in place
  -- Uses the `claude` CLI under the hood (same binary as Claude Code)
  {
    'AdamAugustinsky/opencode-inline.nvim',
    cmd = { 'OpencodeInline' },
    keys = {
      { '<leader>k',  mode = 'v' },
      { '<leader>ke', mode = 'v' },
      { '<leader>kr', mode = 'v' },
      { '<leader>kt', mode = 'v' },
    },
    config = function()
      require('opencode_inline').setup {
        input_prompt = 'Instruction: ',
        mappings = {
          prompt      = '<leader>k',
          prompt_desc = 'AI: transform selection',
        },
        presets = {
          explain  = { key = '<leader>ke', instruction = 'Explain this code concisely', desc = 'AI: explain' },
          refactor = { key = '<leader>kr', instruction = 'Refactor for readability',    desc = 'AI: refactor' },
          tests    = { key = '<leader>kt', instruction = 'Write unit tests',             desc = 'AI: write tests' },
        },
      }
    end,
  },
}
