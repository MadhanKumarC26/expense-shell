source common.sh

print_head "Extract Frontend Content"
dnf install mysql-server -y
status_check


print_head "enable mysqld"
systemctl enable mysqld
status_check



systemctl start mysqld