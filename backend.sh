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



id expense &>>${LOG}
if [ $? -ne 0 ]
then
    useradd expense &>>${LOG}
    print_head "creates user"
else
    echo "Expense user already created"
fi


print_head "add  app"
mkdir /app -y &>>${LOG}
status_check


print_head "download new Nginx content "
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>${LOG}
status_check
 

print_head "change  app"
cd /app -y &>>${LOG}
status_check 

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
