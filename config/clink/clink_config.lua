os.execute('%localappdata%/clink/clink_config.bat')
os.setenv('LOGONSERVER', '')
load(io.popen('starship init cmd'):read("*a"))()
