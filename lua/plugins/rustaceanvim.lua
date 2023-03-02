return {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    -- config = function()
    --     vim.g.rustaceanvim = {
    --         server = {
    --             cmd = function()
    --                 local mason_registry = require('mason-registry')
    --                 local package = mason_registry.get_package('rust-analyzer')
    --                 local install_dir = package:get_install_path()
    --                 -- find out where the binary is in the install dir, and append it to the install dir
    --                 local ra_bin = install_dir .. '/' .. 'rust-analyzer.exe' -- this may need tweaking
    --                 return { ra_bin } -- you can add additional args like `'--logfile', '/path/to/logfile'` to the list
    --             end,
    --         },
    --     }
    -- end
}
