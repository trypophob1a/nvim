return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require("leap").add_default_mappings(true)
    end,
  },
  -- {
  --   "ziglang/zig.vim",
  -- },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "javascript",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "asm",
        -- "zig",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "gopls",
        "gofumpt",
        "goimports",
        "goimports-reviser",
        "golangci-lint",
        "golangci-lint-langserver",
        "gotests",
        "gomodifytags",
        -- "asmfmt",
        -- "zls",
      },
    },
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
  },

  {
    "yetone/avante.nvim",
    opts = {
      windows = {
        wrap_line = true, -- similar to vim.o.wrap
        width = vim.g.neovide and 40 or 30, -- default % based on available width
        sidebar_header = {
          align = "center", -- left, center, right for title
          rounded = false,
        },
      },
      -- your config goes here
      provider = "gemini",
      gemini = {
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-1.5-flash-latest",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,

        generationConfig = {
          stopSequences = { "philosopher", "function" },
        },
      },
    },
    event = "VeryLazy",
    lazy = false,
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap, dapui = require "dap", require "dapui"

      require("dap-go").setup()
      dapui.setup()

      -- Адаптер для gdb
      dap.adapters.gdb = {
        type = "executable",
        command = "gdb",
        args = { "--interpreter=dap", "--eval-command", "set print pretty on" },
      }

      -- Конфигурация для GAS
      dap.configurations.asm = {
        {
          name = "Launch Assembly Program",
          type = "gdb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
          setupCommands = {
            {
              text = "target record-full",
              description = "Enable reversible debugging",
            },
            {
              text = "set disassemble-next-line on",
              description = "Automatically disassemble on stop",
            },
          },
        },
        {
          name = "Attach to Assembly Process",
          type = "gdb",
          request = "attach",
          pid = function()
            return vim.fn.input "PID: "
          end,
          cwd = "${workspaceFolder}",
        },
      }

      -- DAP UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },

  {
    "theHamsta/nvim-dap-virtual-text",
  },

  -- {
  --   "leoluz/nvim-dap-go",
  --   ft = "go",
  --   dependencies = { "mfussenegger/nvim-dap" },
  --   --  opts = {
  --   --    delve = {
  --   --      detached = false,
  --   --    },
  --   --  },
  --   config = function(_, opts)
  --     require("plugins.user_plugins_configs.dap_go_config").Setup(_, opts)
  --   end,
  -- },

  {
    "nvim-lua/plenary.nvim",
  },

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "go", "lua" },
    opts = require("plugins.user_plugins_configs.todo").setup(),
  },
}
