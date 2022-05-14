#It is not complete

archive_list=$(ls "${backup_dir}/")
file_count=$(echo "$archive_list" | wc -l | tr -d '[:blank:]')

if [ "$file_count" -ge "$max_backups" ]; then

  num_to_delete=$(($file_count - $max_backups + 1))

  files_to_delete=$(echo "$archive_list" | head -n $num_to_delete)

  echo
  printf "%s\n" "These $num_to_delete remote archive files will be deleted:" "$files_to_delete"

  for rm_file in $files_to_delete; do
    sudo rm "${backup_dir}/$rm_file"
    done
else
  files_to_delete="None"
fi