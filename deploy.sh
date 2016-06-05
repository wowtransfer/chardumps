sourceDir="."
targetDir="d:/wow_wolk/Interface/AddOns/chardumps"

mkdir -v "$targetDir";

#rm -r "$targetDir/*"

cp -f -v README.md "${targetDir}";
cp -f -v LICENSE "${targetDir}";
cp -f -v TODO "${targetDir}";
cp -f -v chardumps.toc "${targetDir}";

mkdir "$targetDir/locales";
cp -f -v locales/*.lua "${targetDir}/locales";
cp -f *.lua "${targetDir}";
