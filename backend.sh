source common.sh

print_head "diable  deabult node js"
dnf module disable nodejs -y &>>{log}
status_check

print_head "diable  deabult node js"
dnf module enable nodejs:20 -y &>>{log}
status_check



print_head "Install nodejs"
dnf install nodejs -y &>>${LOG}
status_check



#   print_head "Add Application User"
#   id Expense &>>${LOG}
#   if [ $? -ne 0 ]; then
#     useradd Expense &>>${LOG}
#   fi
#   status_check


print_head "add  app"
mkdir -p /app  &>>${LOG}
status_check


print_head "download new  content "
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>${LOG}
status_check
 

print_head "change  app"
cd /app -y &>>${LOG}
status_check 

rm -rf /app/* 

print_head "unzip content"
unzip /tmp/backend.zip &>>${LOG}
status_check 

npm install


cp ${script_location}/files/backend.service /etc/systemd/system/backend.service




print_head "deamon reload"
systemctl daemon-reload  &>>${LOG}
status_check



print_head "Start service"
systemctl start backend &>>${LOG}
status_check

print_head "Enable service"
systemctl enable backend &>>${LOG}
status_check


dnf install mysql -y &>>${LOG}


mysql -h db.devops26.shop -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>${LOG}


systemctl restart backend &>>${LOG}
