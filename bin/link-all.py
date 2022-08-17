import os
from pathlib import Path

dotfiles = os.environ.get("dotfiles")
if dotfiles is None:
    print("No environment variable 'dotfiles' found")
    exit(1)

appdata = os.environ["appdata"]
localappdata = os.environ["localappdata"]
home = os.environ["userprofile"]

config = os.path.join(dotfiles, "config")

links = {
    "clink": f"{localappdata}\\clink",
    "home": f"{home}",
    "lsd": f"{appdata}\\lsd",
    "nvim": f"{localappdata}\\nvim",
    "winfetch": f"{home}\\.config\\winfetch"
}

for program in os.listdir(config):
    subdir = os.path.join(config, program)
    if program not in links:
        print(f"No links defined for {program}")
        continue

    linkdir = links[program]
    Path(linkdir).mkdir(parents=True, exist_ok=True)

    count = 0
    for file in os.listdir(subdir):
        src_file = os.path.join(subdir, file)
        dst_file = os.path.join(linkdir, file)
        try:
            os.remove(dst_file)
        except FileNotFoundError:
            pass
        os.symlink(src_file, dst_file)
        count += 1
    print(f"{program}: {count} files")
