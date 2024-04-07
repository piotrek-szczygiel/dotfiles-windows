-- WARNING:  This file gets overwritten by the 'flexprompt configure' wizard!
--
-- If you want to make changes, consider copying the file to
-- 'flexprompt_config.lua' and editing that file instead.

flexprompt = flexprompt or {}
flexprompt.settings = flexprompt.settings or {}
flexprompt.settings.charset = "unicode"
flexprompt.settings.heads = "pointed"
flexprompt.settings.left_frame = "round"
flexprompt.settings.left_prompt = "{lbubble}"
flexprompt.settings.lines = "one"
flexprompt.settings.nerdfonts_version = 2
flexprompt.settings.nerdfonts_width = 2
flexprompt.settings.powerline_font = true
flexprompt.settings.right_frame = "round"
flexprompt.settings.right_prompt = "{rbubble:format=%a %H:%M}"
flexprompt.settings.spacing = "normal"
flexprompt.settings.style = "lean"
flexprompt.settings.symbols =
{
    prompt =
    {
        ">",
        winterminal = "❯",
    },
}
flexprompt.settings.top_prompt = "{tbubble}"
flexprompt.settings.use_8bit_color = true
