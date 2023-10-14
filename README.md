# crowtranslate.nvim

This Neovim plugin allows you to translate selected text using
[Crow Translate](https://github.com/crow-translate/crow-translate)
(required on your system).

Text will be replaced over the selection.

## Installation

Using lazy.nvim:

```lua
{
    "coffebar/crowtranslate.nvim",
    lazy = true,
    cmd = { "CrowTranslate" },
    opts = {
        -- Japanese to English if selected text includes Japanese characters
        language = "ja",
        mask = "[ぁ-んァ-ン一-龥]", -- regex for your language detection
        default = "en", -- alternative language
        engine = "google", -- google, bing, libretranslate, lingva, yandex
    },
},
```

## Usage

Select text in visual mode and run `:CrowTranslate`. Text will be replaced with the translation.

```lua
-- Example keymap with which-key
local wk = require("which-key")
wk.register({
    T = { "<cmd>CrowTranslate<cr>", "Translate selected text" },
}, { mode = "x" })
```

The direction will be automatically detected based on the selected text and the `mask` option.

Alternatively, you can specify the direction manually by passing argument to command:

`:CrowTranslate en`

## Known issues

- Windows is not supported, PRs are welcome.

## Demo

https://github.com/coffebar/crowtranslate.nvim/assets/3100053/1bf77e1d-c7c6-4b42-9071-7e5049a5e35d


