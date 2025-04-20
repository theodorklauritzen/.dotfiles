local copilotEnabled = false

vim.keymap.set('i', '<C-U>', function ()
  if not vim.g.augment_disable_completions then
    vim.cmd 'call augment#Accept()'
  elseif copilotEnabled then
    local keys = vim.fn.eval('copilot#Accept()')
    vim.fn.feedkeys(keys, 'i')
  end
end)

return {
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-I>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })

      vim.g.copilot_no_tab_map = true

      local function setCopilot (value)
        copilotEnabled = value
        if copilotEnabled then
          vim.cmd 'Copilot enable'
        else
          vim.cmd 'Copilot disable'
        end
        print("Copilot completions: " .. (copilotEnabled and "enabled" or "disabled"))
      end

      setCopilot(copilotEnabled)

      vim.keymap.set('n', '<leader>tc', function ()
        setCopilot(not copilotEnabled)
      end, {
          desc = 'Toggle Copilot Completions'
        })

      vim.keymap.set('n', '<leader>cs', '<Plug>(copilot-suggest)', {
        desc = 'Copilot Suggest',
      })

    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      'github/copilot.vim', -- or zbirenbaum/copilot.lua
      'nvim-lua/plenary.nvim', -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
      mappings = {
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
      },
      model = 'claude-3.7-sonnet',
      prompts = {
        Docs = {
          prompt = "Please add documentation comments to the selected code. Do not include linenumbers. If the selected text is only a funciton, only add documentation to that function and don't edit aything inside the function or the function signature. If the function is written in typescript, do not include the types in the JSDoc comment.",
          system_prompt = '',
          mapping = '<leader>cd',
          description = 'Copilot Documentation',
        },
        Explain = {
          prompt = 'Please explain how the following code works or what the following error message means.',
          system_prompt = '',
          mapping = '<leader>ce',
          description = 'Copilot Explain',
        },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      chat.setup(opts)

      vim.keymap.set('n', '<leader>cc', ':CopilotChat<CR>', {
        desc = 'Copilot Chat',
      })

      vim.keymap.set('n', '<leader>cr', function()
        local diagnostics = vim.lsp.diagnostic.get_line_diagnostics(0)
        local error_message = ''

        -- Loop through diagnostics to find the first error message
        for _, diagnostic in ipairs(diagnostics) do
          if diagnostic.severity == vim.lsp.protocol.DiagnosticSeverity.Error then
            error_message = diagnostic.message
            break
          end
        end

        -- If no error message is found, use a default prompt
        if error_message == '' then
          error_message = vim.api.nvim_get_current_line()
        end

        error_message = error_message:gsub("\n", " ")

        vim.cmd('CopilotChat Explain this error: ' .. error_message)
      end, {
        desc = 'Copilot Explain Error',
      })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- {
  --   'Exafunction/codeium.vim',
  --   config = function ()
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set('i', '<C-U>', function () return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
  --     -- vim.keymap.set('i', '<c-;>', function() return vim.fn['codeium#CycleCompletions'](1) end, { expr = true, silent = true })
  --     -- vim.keymap.set('i', '<c-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end, { expr = true, silent = true })
  --     -- vim.keymap.set('i', '<c-x>', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })
  --   end
  -- },
  {
    'augmentcode/augment.vim',
    init = function ()
      vim.g.augment_disable_tab_mapping = true
      vim.g.augment_workspace_folders = { vim.fn.getcwd() }
    end,
    config = function ()

      vim.keymap.set('n', '<leader>ta', function()
          vim.g.augment_disable_completions = not vim.g.augment_disable_completions
          print("Augment completions: " .. (vim.g.augment_disable_completions and "disabled" or "enabled"))
      end, { desc = "Toggle Augment completions" })

      vim.keymap.set('n', '<leader>ch', ':Augment chat<CR>', {noremap = true, desc = "Augment chat"})
      vim.keymap.set('n', '<leader>cH', ':Augment chat-new<CR>', {noremap = true, desc = "Augment new chat"})
      vim.keymap.set('n', '<leader>ct', ':Augment chat-toggle<CR>', {noremap = true, desc = "Augment toggle chat"})

      vim.g.augment_disable_completions = true

    end
  },
}
