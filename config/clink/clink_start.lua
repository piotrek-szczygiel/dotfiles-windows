local function set_title()
  console.settitle(os.getcwd())
end

clink.onbeginedit(set_title)
