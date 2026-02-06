local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  vim.notify 'JDTLS not found'
  return
end

local jdtls_dir = vim.fn.stdpath 'data' .. '/mason/share/jdtls'
local config_dir = vim.fn.stdpath 'data' .. '/mason/packages/jdtls/config_linux'

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/site/java/workspaces/' .. project_name
os.execute('mkdir -p ' .. workspace_dir)

local bundles = {
  vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}
vim.list_extend(bundles, vim.split(vim.fn.glob(vim.fn.stdpath 'data' .. '/mason/share/java-test/*.jar', 1), '\n'))

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. jdtls_dir .. '/lombok.jar',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    jdtls_dir .. '/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration',
    config_dir,
    '-data',
    workspace_dir,
  },

  root_dir = require('jdtls.setup').find_root {
    '.git',
    'pom.xml',
  },

  settings = {
    java = {
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      signatureHelp = { enabled = true },

      project = {
        outputPath = 'bin',
        sourcesPaths = { 'src', 'test', 'web', 'contracts' },
      },

      configuration = {
        updateBuildConfiguration = 'automatic',
      },

      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath 'config' .. '/utils/eclipse-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
    },
  },

  init_options = {
    bundles = bundles,
  },
}

jdtls.start_or_attach(config)
