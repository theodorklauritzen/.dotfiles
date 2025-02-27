return {
  {
    'github/copilot.vim',
    config = function()
      vim.keymap.set('i', '<C-U>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })

      vim.g.copilot_no_tab_map = true

      vim.keymap.set('n', '<leader>cE', ':Copilot enable<CR>', {
        desc = 'Enable Copilot',
      })

      vim.keymap.set('n', '<leader>cD', ':Copilot disable<CR>', {
        desc = 'Disable Copilot',
      })

      vim.keymap.set('n', '<leader>cs', '<Plug>(copilot-suggest)', {
        desc = 'Copilot Suggest',
      })

      vim.cmd 'Copilot disable'
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

        vim.cmd('CopilotChat Explain this error: ' .. error_message)
      end, {
        desc = 'Copilot Explain Error',
      })
    end,
    -- See Commands section for default commands if you want to lazy load on them
  },
}
