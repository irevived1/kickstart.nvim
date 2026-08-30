vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.virtualedit = 'block'
vim.opt.termguicolors = true
vim.opt.synmaxcol = 200        -- stop syntax highlighting past col 200 (perf on long lines)
vim.opt.clipboard = 'unnamed'  -- match vimrc behavior (system clipboard via unnamed register)

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

vim.api.nvim_exec2(
  [[
    function! s:ZoomToggle() abort
      if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
      else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
      endif
    endfunction
    command! ZoomToggle call s:ZoomToggle()
  ]],
  { output = false }
)

-- [[ Keymaps ]]

vim.keymap.set('n', ',h', [[ (&hls && v:hlsearch ? ':nohls' : ':set hls').."\n"]], { silent = true, expr = true, desc = 'Toggle highlighting' })
vim.keymap.set('n', ';', ':', { noremap = true, desc = 'Command mode' })
vim.keymap.set('n', "'", '`', { noremap = true, desc = 'Mark character' })
vim.keymap.set('n', '`', "'", { noremap = true, desc = 'Mark line' })
vim.keymap.set('n', '<C-z>', '<cmd>ZoomToggle<CR>', { noremap = true, desc = 'Zoom Toggle' })

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
vim.keymap.set('n', '<leader>q', ':bp<CR>:bd #<CR>', { noremap = true, desc = 'Close buffer (keep split)' })

-- Insert mode navigation
vim.keymap.set('i', '<C-h>', '<left>', { noremap = true, desc = 'Move left' })
vim.keymap.set('i', '<C-j>', '<down>', { noremap = true, desc = 'Move down' })
-- Note: <C-k> is used for LSP signature help below

-- macOS Option key insert mode navigation
vim.keymap.set('i', '˙', '<C-o>h', { noremap = true, desc = 'Move left (opt+h)' })
vim.keymap.set('i', '∆', '<C-o>gj', { noremap = true, desc = 'Move down (opt+j)' })
vim.keymap.set('i', '˚', '<C-o>gk', { noremap = true, desc = 'Move up (opt+k)' })
vim.keymap.set('i', '¬', '<C-o>l', { noremap = true, desc = 'Move right (opt+l)' })
vim.keymap.set('i', '∑', '<C-o>w', { noremap = true, desc = 'Word forward (opt+w)' })
vim.keymap.set('i', '∫', '<C-o>b', { noremap = true, desc = 'Word back (opt+b)' })
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

-- Number toggle
function _G.NumberToggle()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end
vim.keymap.set('n', '<leader>z', '<cmd>lua NumberToggle()<CR>', { noremap = true, desc = 'Toggle relative numbers' })

-- File explorer via Snacks
vim.keymap.set('n', '<leader>n', function() Snacks.explorer() end, { noremap = true, desc = 'Tree Toggle' })
vim.keymap.set('n', '<leader>N', function() Snacks.explorer({ reveal = true }) end, { noremap = true, desc = 'Reveal file in tree' })

-- Always open explorer on startup, but return focus to main window
-- so dashboard (no-arg launch) or file (file-arg launch) gets focus
vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.schedule(function()
      Snacks.explorer()
      vim.cmd('wincmd p')
    end)
  end,
})

-- Save
vim.keymap.set('n', '<leader>w', '<cmd>:w<CR>', { noremap = true, desc = 'Save file' })

-- LSP
vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, { noremap = true, desc = 'Signature Help' })
vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, { noremap = true, desc = 'LSP format' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, desc = 'Rename' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { noremap = true, desc = 'Code Action' })

-- Copy paths
vim.api.nvim_set_keymap('n', '<leader>yr', ":let @+=expand('%:.%:t')<CR>", { noremap = true, silent = true, desc = 'Copy Relative Path' })
vim.api.nvim_set_keymap('n', '<leader>ya', ":let @+=expand('%:P%:t')<CR>", { noremap = true, silent = true, desc = 'Copy Absolute Path' })

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
  local fname = vim.fn.expand('%:.')
  local lnum  = vim.fn.line('.')
  send_to_claude('@' .. fname .. ':' .. lnum)
end, { noremap = true, desc = 'Send file:line ref to Claude pane' })

vim.keymap.set('x', '<leader>sc', function()
  if vim.fn.mode() ~= 'V' then return end  -- linewise visual only
  local fname = vim.fn.expand('%:.')
  local s     = vim.fn.line('v')
  local e     = vim.fn.line('.')
  if s > e then s, e = e, s end
  send_to_claude('@' .. fname .. ':' .. s .. '-' .. e)
end, { noremap = true, desc = 'Send file:range ref to Claude pane' })

-- Toggle diagnostics virtual text
vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    vim.diagnostic.config { virtual_text = false }
  else
    vim.g.diagnostics_active = true
    vim.diagnostic.config { virtual_text = true }
  end
end
vim.api.nvim_set_keymap('n', '<leader>uv', ':call v:lua.toggle_diagnostics()<CR>', { noremap = true, silent = true, desc = 'Toggle diagnostic text' })

vim.api.nvim_create_user_command('Notes', 'edit' .. vim.fn.stdpath 'config' .. '/doc/notes.txt', {})
