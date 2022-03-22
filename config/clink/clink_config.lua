os.execute('%localappdata%/clink/clink_config.bat')

function starship_preprompt_user_func(prompt)
    console.settitle(os.getcwd())
end

load(io.popen('starship init cmd'):read("*a"))()
