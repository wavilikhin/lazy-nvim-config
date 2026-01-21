-- Minimal markdown styling - disable render-markdown.nvim visual elements
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        enabled = false,
      },
      heading = {
        enabled = false,
      },
      bullet = {
        enabled = false,
      },
      checkbox = {
        enabled = false,
      },
      quote = {
        enabled = false,
      },
      dash = {
        enabled = false,
      },
      link = {
        enabled = false,
      },
      sign = {
        enabled = false,
      },
    },
  },
}
