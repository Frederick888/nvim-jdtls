local M = {}
local client = {}

function M.is_enabled()
  if vim.g.coc_enabled ~= 1 then
    return false
  end
  local coc_services = vim.fn['CocAction']('services')
  for _, service in pairs(coc_services) do
    local language_ids = service['languageIds']
    if vim.tbl_contains(language_ids, 'java') then
      return true
    end
  end
  return false
end

---@diagnostic disable-next-line: unused-local
function client.request(method, params, callback, bufnr)
  local callback_wrapper = function(err, result)
    if err == vim.NIL then
      err = nil
    end
    callback(err, result)
  end
  vim.fn['CocRequestAsync']('java', method, params, callback_wrapper)
end

M.client = client

return M
