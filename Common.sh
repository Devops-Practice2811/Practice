Print_task_Heading(){
  echo "######## $1 #####"
}

Check_Status(){
  if [$1 -eq 0]; then
    echo Sucess
  else
    echo Failure
  fi
}