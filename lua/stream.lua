-- lua/mirror_push.lua
local server = '/tmp/nvim-mirror.sock'  -- must match: nvim --listen /tmp/nvim-mirror.sock
local chan = nil

local function alive(c)
  if not c then return false end
  -- ping the mirror; if it throws, channel's dead
  local ok = pcall(vim.rpcrequest, c, 'nvim_get_api_info')
  return ok
end

local function connect()
  if alive(chan) then return true end
  -- (re)connect as RPC
  chan = vim.fn.sockconnect('pipe', server, { rpc = true })
  if not alive(chan) then chan = nil; return false end
  return true
end

local function rcmd(cmd)
  if not connect() then return end
  vim.rpcnotify(chan, 'nvim_command', cmd)
end

local function push_file_and_view()
  if not connect() then return end

  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].buftype ~= '' or not vim.api.nvim_buf_is_loaded(buf) then return end

  local fname = vim.fn.expand('%:p')
  if fname == '' then return end

  -- open same file there, keep it single-window
  -- rcmd('silent! noautocmd keepalt keepjumps edit ' .. vim.fn.fnameescape(fname))
  rcmd('silent keepalt keepjumps edit ' .. vim.fn.fnameescape(fname))

  rcmd('silent filetype plugin ident on')
  rcmd('silent syntax enable')
  rcmd('silent if &l:ft == "" | filetype detect | endif')
  rcmd('only')

  -- sync viewport
  local v = vim.fn.winsaveview()
  local lnum, col = v.lnum or 1, v.col or 1
  rcmd(string.format('call cursor(%d,%d)', lnum, col))
  rcmd('normal! zt')
end

local aug = vim.api.nvim_create_augroup('MirrorExternalRPC', { clear = true })

vim.api.nvim_create_autocmd({ 'BufEnter', 'WinEnter' }, {
  group = aug,
  callback = push_file_and_view,
})

vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'WinScrolled' }, {
  group = aug,
  callback = function()
    if not connect() then return end
    local v = vim.fn.winsaveview()
    if not v or not v.lnum then return end
    rcmd(string.format('call cursor(%d,%d)', v.lnum, v.col or 1))
    rcmd('normal! zt')
  end,
})

vim.keymap.set('n', '<leader>mm', push_file_and_view, { desc = 'Force mirror update (RPC)' })
