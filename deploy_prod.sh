sourceDir="."
#targetDir="d:/wow_off/World of Warcraft/Interface/AddOns/chardumps"
targetDir="d:/wow_wolk/Interface/AddOns/chardumps"

rm -r "$targetDir"
mkdir -v "$targetDir";

cp -f -v README.md "${targetDir}";
cp -f -v LICENSE "${targetDir}";
cp -f -v chardumps_prod.toc "${targetDir}/chardumps.toc";
cp -f addon.lua "${targetDir}/chardumps.lua";
