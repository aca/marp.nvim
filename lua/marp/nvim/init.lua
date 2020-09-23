local M = {}

M.jobid = 0
function M.ServerStart()
  if M.jobid ~= 0 then
    -- kill running jobs
    vim.fn.jobstop(M.jobid)
    return
  end
  local port = os.getenv("PORT")
  if port == nil then
    port = "8080"
  end
  print('marp: started server on http://localhost:' .. port)
  M.jobid = vim.fn.jobstart({"marp", "--server", vim.fn.getcwd()}, {
    on_exit = function(_, code)
      M.jobid = 0
      if code ~= 143 then print('marp: exit', code) end
    end,
  })
end

function M.ServerStop()
  vim.fn.jobstop(M.jobid)
  M.jobid = 0
  print('marp: server stopped')
end

return M
