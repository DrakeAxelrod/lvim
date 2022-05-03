local ok, bufremove = pcall(require, "mini.bufremove")
if not ok then
  return
end
bufremove.setup({
  -- Whether to set Vim's settings for buffers (allow hidden buffers)
  set_vim_settings = true,
})

--[[
`MiniBufremove.unshow`({buf_id})
`MiniBufremove.wipeout`({buf_id}, {force})
`MiniBufremove.delete`({buf_id}, {force})
`MiniBufremove.unshow_in_window`({win_id})
]]
