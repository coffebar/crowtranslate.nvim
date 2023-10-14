local utils = require("crowtranslate.utils")

local M = {}
M.opts = {}

-- TODO: use args to specify direction language
-- TODO: add autocompelete for language
-- TODO: add option for provider

M.setup = function(opts)
  local defaults = {
    language = "ja",
    mask = "[ぁ-んァ-ン一-龥]",
    default = "en",
    engine = "google",
  }

  M.opts = vim.tbl_deep_extend("force", defaults, opts or {})

  -- Translate for Visual mode: replace selected text with translation
  vim.api.nvim_create_user_command("CrowTranslate", function(opts)
    local selected = utils.get_visual_selection()
    if #selected == 0 then
      return
    end
    local multiline = string.match(selected, "\n") ~= nil
    local direction = M.opts.default
    if string.match(selected, M.opts.mask) == nil then
      direction = M.opts.language
    end
    if #opts.fargs > 0 then
      direction = opts.fargs[1]
    end
    -- pass the text via stdin,
    -- otherwise crow will take the quotes as part of the text
    local cmd = "echo " .. vim.fn.shellescape(selected)
    cmd = cmd .. " | crow -i -b -t " .. direction .. " -e " .. M.opts.engine
    utils.combine_stdout(cmd, multiline, function(stdout)
      if stdout ~= nil then
        stdout = utils.align_blanklines(selected, stdout)
        utils.replace_selected(stdout)
      end
    end)
  end, { range = true, nargs = "?", complete = utils.languages })
end

return M
