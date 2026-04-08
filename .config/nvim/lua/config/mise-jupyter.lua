-- glue for jupyter installed via mise, with pynvim
--
-- installed through the mise tool_alias:
-- jupyter = "pipx:jupyter[pipx_args=--include-deps --preinstall pynvim]"
--
-- which enables binaries linked for dependencies' commands, and adds pynvim
-- for remote-plugin use
--

-- if a venv for pynvim and jupyter client has been created, use it
local jupyter_install = vim.fn.expand("~/.local/share/mise/installs/jupyter")
if vim.uv.fs_stat(jupyter_install) then
  vim.g.python3_host_prog = jupyter_install .. "/latest/venvs/jupyter/bin/python3"
end

