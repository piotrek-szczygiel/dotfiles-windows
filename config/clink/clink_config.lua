load(io.popen('oh-my-posh init cmd'):read("*a"))()

os.execute('%localappdata%/clink/clink_config.bat')

function starship_preprompt_user_func(prompt)
    console.settitle(os.getcwd())
end
