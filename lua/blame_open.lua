local vim = vim

local function git_remote_url()
  local remote_name = 'remote.origin.url'
  if vim.api.nvim_get_var('blame_open_upstream_remote') == 1 then
    remote_name = 'remote.upstream.url'
  end

  local handle = io.popen('git config --get ' .. remote_name)
  local result = handle:read("*a")
  handle:close()

  -- if empty remote url
  if result == '' then
    return
  end

  -- replace ssh -> https
  local replaced_result, _ = string.gsub(result, 'git@github.com:', 'https://github.com/')

  -- remove .git string
  return replaced_result:sub(0, -6)
end

local function blame_open()
  local filename = vim.fn.expand('%')
  -- if empty filename
  if filename == '' then
    return
  end

  local line_number = vim.fn.line('.')
  local handle = io.popen('git blame -l -L ' .. line_number .. ',+1 ' .. filename)
  local blame_result = handle:read("*a")
  handle:close()

  local commit_hash = ''
  for str in string.gmatch(blame_result, "%S+") do
    commit_hash = str
    break
  end

  -- not commit hash
  if commit_hash == '0000000000000000000000000000000000000000' then
    return
  end

  local git_repository_url = git_remote_url()
  if git_repository_url == nil then
    return
  end

  -- https://github.com/<author>/<repo_name>/commit/<commit_hash>
  os.execute('open ' .. git_remote_url() .. '/commit/' .. commit_hash)
end

-- print only blame url
local function blame_open_url()
  local filename = vim.fn.expand('%')
  -- if empty filename
  if filename == '' then
    return
  end

  local line_number = vim.fn.line('.')
  local handle = io.popen('git blame -l -L ' .. line_number .. ',+1 ' .. filename)
  local blame_result = handle:read("*a")
  handle:close()

  local commit_hash = ''
  for str in string.gmatch(blame_result, "%S+") do
    commit_hash = str
    break
  end

  -- not commit hash
  if commit_hash == '0000000000000000000000000000000000000000' then
    return
  end

  local git_repository_url = git_remote_url()
  if git_repository_url == nil then
    return
  end

  -- https://github.com/<author>/<repo_name>/commit/<commit_hash>
  print(git_remote_url() .. '/commit/' .. commit_hash)
end

return {
  blame_open = blame_open,
  blame_open_url = blame_open_url
}
