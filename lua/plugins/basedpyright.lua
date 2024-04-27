return {
  "AstroNvim/astrolsp",
  ---@type AstroLSPOpts
  opts = {
    ---@diagnostic disable: missing-fields
    config = {
      basedpyright = {
        settings = {
          basedpyright = {
            disableLanguageServices = false,
            analysis = {
              autoImportCompletions = true,
              autoSearchPaths = true,
              diagnosticMode = "openFilesOnly",
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
    },
  },
}
