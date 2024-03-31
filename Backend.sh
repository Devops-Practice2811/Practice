dnf module disable nodejs -y &>>/tmp/expense.log
echo $?
echo dnf installed
echo $?

dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

rm -rf /app &>>/tmp/expense.log
echo $?


dnf install nodejs -y &>>/tmp/expense.log
echo $?

useradd expense &>>/tmp/expense.log
echo $?

cp Backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

mkdir /app
echo $?

curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
cd /app &>>/tmp/expense.log
echo $?

unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

cd /app  &>>/tmp/expense.log
echo $?

npm install &>>/tmp/expense.log
echo $?

systemctl daemon-reload &>>/tmp/expense.log
echo $?

systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?


dnf install mysql -y &>>/tmp/expense.log
mysql -h 172.31.41.140 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>/tmp/expense.log