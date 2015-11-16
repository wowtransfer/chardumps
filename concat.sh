#
declare -a files;

files=(

# constants

'locales\enUS.lua'
'locales\ruRU.lua'
'valid_bindings.lua'

# libraries
'global.lua'

# global
'b64.lua'

# code
'main_frame_handle.lua'
'main_frame.lua'
'crypt_client.lua'
'chardumps.lua'

);

targetDir="../chardumps";
targetFile="addon.lua";
targetFilePath="$targetDir/$targetFile";

echo "Concationation to $targetFilePath";
echo "" > ${targetFilePath};

for ((i=0; i < ${#files[@]}; i++))
do
  echo ${files[$i]};
  cat ${files[$i]} >> ${targetFilePath};
done

echo "Finish.";
