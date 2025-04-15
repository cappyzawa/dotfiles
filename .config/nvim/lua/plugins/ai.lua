return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    cmd = {
      "CopilotChat",
      "CopilotChatExplain",
      "CopilotChatReview",
      "CopilotChatFix",
      "CopilotChatOptimize",
      "CopilotChatDocs",
      "CopilotChatTests",
      "CopilotChatCommit",
    },
    opts = {
      model = "claude-3.7-sonnet",
      prompts = {
        Explain = {
          prompt = "選択したコードの説明を段落として書いてください。",
          system_prompt = "COPILOT_EXPLAIN",
        },
        Review = {
          prompt = "選択したコードをレビューしてください。",
          system_prompt = "COPILOT_REVIEW",
        },
        Fix = {
          prompt = "このコードには問題があります。問題を特定し、修正を加えてコードを書き直してください。何が問題だったのか、そしてあなたの変更がどのように問題を解決するかを説明してください。",
        },
        Optimize = {
          prompt = "選択したコードを最適化して、パフォーマンスと可読性を向上させてください。最適化戦略と変更の利点を説明してください。",
        },
        Docs = {
          prompt = "選択したコードにドキュメントコメントを追加してください。",
        },
        Tests = {
          prompt = "コードのテストを生成してください。",
        },
        Commit = {
          prompt = "コミットメッセージをコミットゼンの規約に従って書いてください。タイトルは50文字以内にし、メッセージは72文字で折り返してください。gitcommitコードブロックとしてフォーマットしてください。",
          context = "git:staged",
        },
      },
    },
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "copilot",
      copilot = {
        endpoint = "https://api.githubcopilot.com",
        model = "claude-3.7-sonnet",
        timeout = 30000,
        temperature = 0,
        max_completion_tokens = 4096,
      },
    },
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
  },
}
