import json
import mysql.connector
from flask import make_response
class user_model():
    def __init__(self):
        # Connections estabilishment code
        try:
            self.con=mysql.connector.connect(host="localhost",username="root",password="password",database="flask_tutorial")
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
            # return json.dumps(result)#dumps function turn to convert that serialized object(result) to string format but we have to generate a better readable format
            return make_response({"payload":result},200)#this will return json data as postman api tool will beautify it whereas for dumps postamn will not beautify it
        else:
            return make_response({"message":"No Data found"},204)#204 doesnt need a body
        

    def user_addone_model(self,data):
        # self.cur.execute("SELECT * FROM users")
        # print(data)
        self.cur.execute(f"INSERT INTO users(name,email,phone,role,password) VALUES ('{data['name']}','{data['email']}','{data['phone']}','{data['role']}','{data['password']}')")
        # print(data['email'])
        return make_response({"message":"User Created Successfully"},201)
    

    def user_update_model(self,data):
        self.cur.execute(f"UPDATE users SET name='{data['name']}',email='{data['email']}',phone='{data['phone']}',role='{data['role']}',password='{data['password']}' WHERE id= {data['id']}")
        if self.cur.rowcount>0:
            return make_respone({"message":"User Updated Successfully"},201)
        else:
            return make_response({"message":"Nothing to Update"},202)
        
    def user_delete_model(self,id):
        self.cur.execute(f"DELETE FROM users WHERE id= {id}")
        if self.cur.rowcount>0:
            return make_response({"message":"User Deleted Successfully"},200)
        else:
            return make_response({"message":"Nothing to Delete"},202)