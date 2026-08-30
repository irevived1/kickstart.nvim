vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.virtualedit = 'block'
vim.opt.termguicolors = true  -- required for true-color themes (tender)

-- Restore cursor to last position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 1 and mark[1] <= lcount then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Zoom current window to fill the tab, toggle back with the same key
vim.keymap.set('n', '<C-z>', function()
  if vim.t.zoomed then
    vim.cmd(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    vim.cmd 'resize | vertical resize'
    vim.t.zoomed = true
  end
end, { noremap = true, desc = 'Zoom Toggle' })

-- [[ Keymaps ]]

vim.keymap.set('n', ',h', function()
  if vim.v.hlsearch == 1 then vim.cmd 'nohls' else vim.opt.hlsearch = true end
end, { noremap = true, desc = 'Toggle search highlight' })
vim.keymap.set('n', ';', ':', { noremap = true, desc = 'Command mode' })
vim.keymap.set('n', "'", '`', { noremap = true, desc = 'Mark character' })
vim.keymap.set('n', '`', "'", { noremap = true, desc = 'Mark line' })

-- Insert mode escape / save
vim.keymap.set('i', 'df', '<ESC>', { noremap = true, desc = 'ESC' })
vim.keymap.set('i', 'ß', '<ESC>:w<CR>', { noremap = true, desc = 'Save (Option+s)' })
vim.keymap.set('i', ';w', '<ESC>:w<CR>', { noremap = true, desc = 'Save' })

-- Editing
vim.keymap.set('n', '<CR>', 'o<ESC>', { noremap = true, desc = 'Insert blank line below' })
vim.keymap.set('n', 'j', 'gj', { noremap = true, desc = 'Visual line down' })
vim.keymap.set('n', 'k', 'gk', { noremap = true, desc = 'Visual line up' })
vim.keymap.set('n', '<Up>', 'kddpk', { noremap = true, desc = 'Move line up' })
vim.keymap.set('n', '<Down>', 'ddp', { noremap = true, desc = 'Move line down' })

-- Buffer navigation (Tab/S-Tab like vimrc)
vim.keymap.set('n', '<Tab>', '<cmd>bn!<CR>', { noremap = true, desc = 'Buffer next' })
vim.keymap.set('n', '<S-Tab>', '<cmd>bp!<CR>', { noremap = true, desc = 'Buffer previous' })
vim.keymap.set('n', 'L', '<cmd>bn<CR>', { noremap = true, desc = 'Buffer next' })
vim.keymap.set('n', 'H', '<cmd>bp<CR>', { noremap = true, desc = 'Buffer previous' })
vim.keymap.set('n', '<leader>q', function()
  local cur = vim.fn.bufnr('%')
  vim.cmd 'bp'
  if vim.fn.bufnr('%') ~= cur then vim.cmd('bd ' .. cur) end
end, { noremap = true, desc = 'Close buffer (keep split)' })

-- Insert mode navigation
vim.keymap.set('i', '<C-h>', '<left>',  { noremap = true, desc = 'Move left' })
vim.keymap.set('i', '<C-j>', '<down>',  { noremap = true, desc = 'Move down' })
vim.keymap.set('i', '<C-k>', '<up>',    { noremap = true, desc = 'Move up (blink shows signature help automatically)' })

-- macOS Option key insert mode navigation
vim.keymap.set('i', '˙', '<C-o>h',  { noremap = true, desc = 'Move left (opt+h)' })
vim.keymap.set('i', '∆', '<C-o>gj', { noremap = true, desc = 'Move down (opt+j)' })
vim.keymap.set('i', '˚', '<C-o>gk', { noremap = true, desc = 'Move up (opt+k)' })
vim.keymap.set('i', '¬', '<C-o>l',  { noremap = true, desc = 'Move right (opt+l)' })
vim.keymap.set('i', '∑', '<C-o>w',  { noremap = true, desc = 'Word forward (opt+w)' })
vim.keymap.set('i', '∫', '<C-o>b',  { noremap = true, desc = 'Word back (opt+b)' })
vim.keymap.set('i', '…', '<ESC>', { noremap = true, desc = 'ESC (opt+;)' })
vim.keymap.set('v', '…', '<ESC>', { noremap = true, desc = 'ESC (opt+;)' })
vim.keymap.set('c', '…', '<ESC>', { noremap = true, desc = 'ESC (opt+;)' })

-- Named register shortcuts (j/k/l as temporary clipboards)
vim.keymap.set('v', 'a', '"jy', { noremap = true, desc = 'Yank to register j' })
vim.keymap.set('v', 'z', '"ky', { noremap = true, desc = 'Yank to register k' })
vim.keymap.set('v', 'x', '"ly', { noremap = true, desc = 'Yank to register l' })
vim.keymap.set('n', 'å', '"jp', { noremap = true, desc = 'Paste from register j' })
vim.keymap.set('n', 'Ω', '"kp', { noremap = true, desc = 'Paste from register k' })
vim.keymap.set('n', '≈', '"lp', { noremap = true, desc = 'Paste from register l' })

vim.keymap.set('n', '<leader>z', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { noremap = true, desc = 'Toggle relative numbers' })

-- File explorer via Snacks
vim.keymap.set('n', '<leader>n', function() Snacks.explorer() end, { noremap = true, desc = 'Tree Toggle' })
vim.keymap.set('n', '<leader>N', function() Snacks.explorer({ reveal = true }) end, { noremap = true, desc = 'Reveal file in tree' })

-- Always open explorer on startup, but return focus to main window
-- so dashboard (no-arg launch) or file (file-arg launch) gets focus
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.schedule(function()
      Snacks.explorer()
      vim.cmd 'wincmd p'
    end)
  end,
})

-- Save
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { noremap = true, desc = 'Save file' })

-- LSP
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format,      { noremap = true, desc = 'LSP format' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename,      { noremap = true, desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, desc = 'Code Action' })

-- Copy paths to system clipboard
vim.keymap.set('n', '<leader>yr', function()
  vim.fn.setreg('+', vim.fn.expand '%:.')
end, { noremap = true, desc = 'Copy relative path' })
vim.keymap.set('n', '<leader>ya', function()
  vim.fn.setreg('+', vim.fn.expand '%:p')
end, { noremap = true, desc = 'Copy absolute path' })

-- Send file reference to Claude tmux pane (\sc in normal, V-line visual)
-- Finds the pane running 'claude' in the current tmux window; falls back to last active pane.
local function send_to_claude(text)
  text = vim.trim(text)
  if text == '' then return end
  local pane = vim.trim(vim.fn.system(
    "tmux list-panes -F '#{pane_id} #{pane_title} #{pane_current_command}' | grep -i 'claude' | head -1 | awk '{print $1}'"
  ))
  if pane == '' then pane = '!' end
  local cmd = 'tmux send-keys -t ' .. vim.fn.shellescape(pane) .. ' ' .. vim.fn.shellescape(text)
  local result = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify('send_to_claude failed (pane=' .. pane .. '): ' .. result, vim.log.levels.ERROR)
  else
    vim.notify('→ ' .. text, vim.log.levels.INFO)
  end
end

vim.keymap.set('n', '<leader>sc', function()
  local fname = vim.fn.expand '%:.'
  local lnum  = vim.fn.line '.'
  send_to_claude('@' .. fname .. ':' .. lnum)
end, { noremap = true, desc = 'Send file:line ref to Claude pane' })

vim.keymap.set('x', '<leader>sc', function()
  if vim.fn.mode() ~= 'V' then return end  -- linewise visual only
  local fname = vim.fn.expand '%:.'
  local s     = vim.fn.line 'v'
  local e     = vim.fn.line '.'
  if s > e then s, e = e, s end
  send_to_claude('@' .. fname .. ':' .. s .. '-' .. e)
end, { noremap = true, desc = 'Send file:range ref to Claude pane' })

-- Toggle LSP diagnostics virtual text
vim.keymap.set('n', '<leader>uv', function()
  vim.g.diagnostics_active = not vim.g.diagnostics_active
  vim.diagnostic.config { virtual_text = vim.g.diagnostics_active }
end, { noremap = true, desc = 'Toggle diagnostic text' })
vim.g.diagnostics_active = true

vim.api.nvim_create_user_command('Notes', function()
  vim.cmd('edit ' .. vim.fn.stdpath 'config' .. '/doc/notes.txt')
end, {})
