set shell := ["powershell.exe", "-c"]

# create patched rom and should put it into the target dir
compile project:
    .\utils\armips {{project}}code.s
# make ips patch
mkpatch patched_code:
    .\utils\flips --create --ips .\shared\code.bin {{patched_code}}
# create project folder and code.s
create project:
    mkdir {{project}}
    echo ".3ds" >> .\{{project}}\code.s
    echo '.open "shared/code.bin","target/{{project}}.bin",0x100000' >> .\{{project}}\code.s
    echo '' >> .\{{project}}\code.s
    echo '.close' >> .\{{project}}\code.s
