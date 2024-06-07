import json
import mysql.connector
class user_model():
    def __init__(self):
        # Connections estabilishment code
        try:
            self.con=mysql.connector.connect(host="localhost",username="root",password="fill_the_password",database="flask_tutorial")
            self.con.autocommit=True
            self.cur=self.con.cursor(dictionary=True)
            print("Connection successfull")
        except:
            print("Some error")
    def user_getall_model(self):
        # Connection estabilishment code
        # Query execution code
        self.cur.execute("SELECT * FROM users")
        result=self.cur.fetchall()
        if(len(result)>0):
            return json.dumps(result)
        else:
            return "No Data found"
        

    def user_addone_model(self,data):
        # self.cur.execute("SELECT * FROM users")
        # print(data)
        self.cur.execute(f"INSERT INTO users(name,email,phone,role,password) VALUES ('{data['name']}','{data['email']}','{data['phone']}','{data['role']}','{data['password']}')")
        # print(data['email'])
        return "User created Successfully"