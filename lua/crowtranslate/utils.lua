local M = {}

function M.get_visual_selection()
  local a_orig = vim.fn.getreg("a")
  local mode = vim.fn.mode()
  if mode ~= "v" and mode ~= "V" then
    vim.cmd([[normal! gv]])
  end
  vim.cmd([[silent! normal! "aygv]])
  local text = vim.fn.getreg("a")
  vim.fn.setreg("a", a_orig)
  return text
end

function M.combine_stdout(cmd, multiline, callback)
  local stdout = ""
  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      for _, v in ipairs(data) do
        if multiline then
          if stdout == "" then
            stdout = v
          else
            stdout = stdout .. "\n" .. v
          end
        else
          stdout = stdout .. v
        end
      end
    end,
    on_exit = function(_, code)
      if code == 0 then
        callback(stdout)
      else
        callback(nil)
      end
    end,
    on_stderr = function(_, data)
      if data ~= nil and #data > 0 then
        local lines = vim.concat(data, "\n")
        if lines ~= "" then
          vim.notify(lines, vim.log.levels.ERROR)
        end
      end
    end,
  })
end

function M.align_blanklines(source, dest)
  local start_newlines = string.match(source, "^\n*")
  local end_newlines = string.match(source, "\n*$")
  dest = dest:gsub("^\n*", "")
  dest = dest:gsub("\n*$", "")
  if start_newlines ~= nil then
    dest = start_newlines .. dest
  end
  if end_newlines ~= nil then
    dest = dest .. end_newlines
  end
  return dest
end

function M.replace_selected(text)
  local b_orig = vim.fn.getreg("b")
  vim.fn.setreg("b", text)
  vim.cmd('normal! "bp')
  vim.fn.setreg("b", b_orig)
end

function M.languages()
  return {
    "am",
    "ar",
    "bg",
    "bn",
    "ca",
    "cs",
    "da",
    "de",
    "el",
    "en",
    "es",
    "et",
    "fa",
    "fi",
    "fil",
    "fr",
    "gu",
    "he",
    "hi",
    "hr",
    "hu",
    "id",
    "it",
    "iw",
    "ja",
    "kn",
    "ko",
    "lt",
    "lv",
    "ml",
    "mr",
    "ms",
    "nl",
    "no",
    "pl",
    "pt",
    "ro",
    "ru",
    "sk",
    "sl",
    "sr",
    "sv",
    "sw",
    "ta",
    "te",
    "th",
    "tr",
    "uk",
    "ur",
    "vi",
    "zh",
  }
end

return M
