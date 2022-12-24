# Awakening mods for the USA version
- `code.bin` not included cause I don't know the legality
- only made for the USA version, I cannot gurantee anything working for others. Also don't ask me to port any of these to a different version.

# Brief how to use (windows)

0. cd into the head of this repo
1. copy the `code.bin` to as `shared/code.bin`
2. install just if you wanna use my short cuts
3. run `just create <project_name>` to generate code.s
4. write your patch
5. run `just compile <project_name>` to build a patched code.bin
6. run `just mkpatch target\<project_name>.bin` to create an .ips patch