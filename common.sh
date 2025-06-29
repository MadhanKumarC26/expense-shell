

script_location=$(pwd)
LOG=/tmp/roboshop.log
 
status_check() {
if [ $? -eq 0 ]; then
    echo "sucess"
else
   echo "failure refer log file, LOG - ${LOG}"     
fi
}

print_head() {
  echo -e "\e[1m $1 \e[0m"
}