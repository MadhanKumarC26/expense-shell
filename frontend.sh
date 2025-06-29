source common.sh

print_head "Install Nginx"
dnf install nginx -y &>>${LOG}
status_check


print_head "Install Nginx"
systemctl enable nginx &>>${LOG}
status_check

print_head "start Nginx"
systemctl start nginx &>>${LOG}
status_check


print_head "remove old Nginx content "
rm -rf /usr/share/nginx/html/* &>>${LOG}
status_check

print_head "download new Nginx content "
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>${LOG}
status_check

cd /usr/share/nginx/html &>>${LOG}

print_head "Extract Frontend Content"
unzip /tmp/frontend.zip &>>${LOG}
status_check


print_head " cp new  service file Frontend Content"
cp ${script_location}/files/expense.conf /etc/nginx/default.d/expense.conf &>>${LOG}
status_check

print_head "Enable Nginx"
systemctl enable nginx &>>${LOG}
status_check

print_head "Start Nginx"
systemctl restart nginx &>>${LOG}
status_check