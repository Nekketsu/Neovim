return {
    "SirZenith/oil-vcs-status",
    dependencies = "stevearc/oil.nvim",
    config = function()
        require "oil".setup {
            win_options = {
                signcolumn = "yes:2",
            }
        }

        local status_const = require "oil-vcs-status.constant.status"
        local StatusType = status_const.StatusType

        require "oil-vcs-status".setup {
            -- Sign character used by each status.
            ---@type table<oil-vcs-status.StatusType, string>
            status_symbol = {
                [StatusType.Added]                = "",
                [StatusType.Copied]               = "󰆏",
                [StatusType.Deleted]              = "",
                [StatusType.Ignored]              = "",
                [StatusType.Modified]             = "",
                [StatusType.Renamed]              = "",
                [StatusType.TypeChanged]          = "󰉺",
                [StatusType.Unmodified]           = " ",
                [StatusType.Unmerged]             = "",
                [StatusType.Untracked]            = "",
                [StatusType.External]             = "",

                [StatusType.UpstreamAdded]       = "󰈞",
                [StatusType.UpstreamCopied]      = "󰈢",
                [StatusType.UpstreamDeleted]     = "",
                [StatusType.UpstreamIgnored]     = " ",
                [StatusType.UpstreamModified]    = "󰏫",
                [StatusType.UpstreamRenamed]     = "",
                [StatusType.UpstreamTypeChanged] = "󱧶",
                [StatusType.UpstreamUnmodified]  = " ",
                [StatusType.UpstreamUnmerged]    = "",
                [StatusType.UpstreamUntracked]   = " ",
                [StatusType.UpstreamExternal]    = "",
            }
        }
    end
}
