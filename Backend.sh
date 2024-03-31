Password="$1"
Print_task_Heading(){
  echo "############ $1 #########" &>> tmp/expense.log

}
Print_task_Heading "Disabling NodeJS version"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

Print_task_Heading "enabling node JS 20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

Print_task_Heading "Removing or deleting previous content"
rm -rf /app &>>/tmp/expense.log
echo $?

Print_task_Heading "Installing nodeJS"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

Print_task_Heading "Adding User"
useradd expense &>>/tmp/expense.log
echo $?

Print_task_Heading "Copying Backend service file"
cp Backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

Print_task_Heading "Craating App directory"
mkdir /app
echo $?

Print_task_Heading "Download Curl Cmd"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

Print_task_Heading "Changing directory to APP directory and Unzipping the Backend file"
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

Print_task_Heading "Downling Nodejs dependencies"
cd /app  &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

Print_task_Heading "Reloading the backend"
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

Print_task_Heading "Installing MySQl"
dnf install mysql -y &>>/tmp/expense.log
echo $?

Print_task_Heading "Proving root password"
mysql -h 172.31.41.140 -uroot -p${Password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?