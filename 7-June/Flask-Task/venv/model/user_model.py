import json
import mysql.connector
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
            return {"payload":result}#this will return json data as postman api tool will beautify it whereas for dumps postamn will not beautify it
        else:
            return {"message":"No Data found"}
        

    def user_addone_model(self,data):
        # self.cur.execute("SELECT * FROM users")
        # print(data)
        self.cur.execute(f"INSERT INTO users(name,email,phone,role,password) VALUES ('{data['name']}','{data['email']}','{data['phone']}','{data['role']}','{data['password']}')")
        # print(data['email'])
        return {"message":"User Created Successfully"}
    

    def user_update_model(self,data):
        self.cur.execute(f"UPDATE users SET name='{data['name']}',email='{data['email']}',phone='{data['phone']}',role='{data['role']}',password='{data['password']}' WHERE id= {data['id']}")
        if self.cur.rowcount>0:
            return {"message":"User Updated Successfully"}
        else:
            return {"message":"Nothing to Update"}
        
    def user_delete_model(self,id):
        self.cur.execute(f"DELETE FROM users WHERE id= {id}")
        if self.cur.rowcount>0:
            return {"message":"User Deleted Successfully"}
        else:
            return {"message":"Nothing to Delete"}