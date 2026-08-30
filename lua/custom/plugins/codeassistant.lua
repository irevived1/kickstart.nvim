return {
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
}
