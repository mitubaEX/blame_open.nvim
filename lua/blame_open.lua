local vim = vim

local function greet()
  local filename = 'lua/blame_open.lua'
  local handle = io.popen('git blame -l -L 1,+1 ' .. filename)
  local result = handle:read("*a")
  handle:close()
  local commit_hash = ''
  for str in string.gmatch(result, "%S+") do
    commit_hash = str
    break
  end
  -- https://github.com/<author>/<repo_name>/commit/<commit_hash>
  os.execute('open https://github.com/mitubaEX/blame_open/commit/' .. commit_hash)
end

return {
  greet = greet
}
