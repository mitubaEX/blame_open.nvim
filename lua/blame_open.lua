local vim = vim

local function git_origin_path()
  local handle = io.popen('git config --get remote.origin.url')
  local result = handle:read("*a")
  handle:close()

  -- remove .git string
  return result:sub(0, -6)
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

  -- https://github.com/<author>/<repo_name>/commit/<commit_hash>
  os.execute('open ' .. git_origin_path() .. '/commit/' .. commit_hash)
end

return {
  blame_open = blame_open
}
