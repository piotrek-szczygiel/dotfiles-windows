-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt = flexprompt or {}
flexprompt.settings = flexprompt.settings or {}
flexprompt.settings.style = "lean"
flexprompt.settings.use_icons = true
flexprompt.settings.spacing = "normal"
flexprompt.settings.right_frame = "round"
flexprompt.settings.charset = "unicode"
flexprompt.settings.flow = "concise"
flexprompt.settings.use_8bit_color = true
flexprompt.settings.symbols =
{
    prompt =
    {
        ">",
        winterminal = "❯",
    },
}
flexprompt.settings.lean_separators = "dot"
flexprompt.settings.right_prompt = "{exit}{duration}{time:format=%a %H:%M}"
flexprompt.settings.left_frame = "round"
flexprompt.settings.powerline_font = true
flexprompt.settings.left_prompt = "{battery}{histlabel}{cwd}{git}"
flexprompt.settings.heads = "pointed"
flexprompt.settings.lines = "one"
