#
declare -a files;

files=(

'global.lua'
'log.lua'
'locales\enUS.lua'
'locales\ruRU.lua'
'valid_bindings.lua'
'b64.lua'

'encryption.lua'
'config.lua'
'functions.lua'
'entity_manager.lua'
'widgets.lua'
'options.lua'
'dumper.lua'
'main_frame.lua'
'entity_views.lua'
'chardumps.lua'

);

targetDir=".";
targetFile="addon.lua";
targetFilePath="$targetDir/$targetFile";

echo "Concationation to $targetFilePath";
echo "" > ${targetFilePath};

for ((i=0; i < ${#files[@]}; i++))
do
  echo ${files[$i]};
  cat ${files[$i]} >> ${targetFilePath};
  echo -e "\n" >> ${targetFilePath};
done

echo "Finish.";
