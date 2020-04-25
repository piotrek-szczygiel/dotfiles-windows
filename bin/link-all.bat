@echo off
for /r "%dotfiles%\config" %%f in (link-*.bat) do (
	echo=
	echo Running %%~nf
	call %%f
)
