git_remote_add() {
  template_repo_origin=$1
  template_repo_url=$2

  # This next line is not silenced
  git remote add $template_repo_origin $template_repo_url --no-tags > /dev/null
  git remote set-url --push $template_repo_origin not-allowed > /dev/null
}

git_template_update_record() {
  template_date_human=$1
  template_date_epoch=$2
  record_target=$REPO_CONFIG_FILE
  if [[ "$update_mode" == "template" ]];
    then
      record_target=$PARENT_TEMPLATE_CONFIG_FILE
    fi
  if [ ! -f $record_target ];
  then
    touch $REPO_CONFIG_FILE
  else
    sed -i '/TEMPLATE_LAST_COMMIT_EPOCH/d' $REPO_CONFIG_FILE 
  fi
  echo "TEMPLATE_LAST_COMMIT_EPOCH=$template_date_epoch # $template_date_human" >> $REPO_CONFIG_FILE
}
