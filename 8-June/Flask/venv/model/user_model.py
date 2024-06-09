import json
import mysql.connector
from flask import make_response
from datetime import datetime
class user_model():
    def __init__(self):
        try:
            self.con=mysql.connector.connect(host="localhost",username="root",password="",database="8_june_task")
            self.con.autocommit=True
            self.cur=self.con.cursor(dictionary=True)
            print("Connection successfull")
        except:
            print("Some error")
            
    def user_getall_user_model(self):
        self.cur.execute("SELECT * FROM users")
        result=self.cur.fetchall()
        if(len(result)>0):
            res=make_response({"payload":result},200)
            res.headers['Access-Control-Allow-Origin']="*"
            return res
        else:
            return make_response({"message":"No user data found"},204)
        
    def user_addoneuser_model(self,data):
        print("hey i am in add_one_user_model")
        print(data)
        # self.cur.execute(f"INSERT INTO users(user_id,name,email,phone) VALUES ('{data['user_id']}','{data['name']}','{data['email']}','{data['phone']}')")        
        self.cur.execute(f"INSERT INTO users(name,email,phone) VALUES ('{data['name']}','{data['email']}','{data['phone']}')")
        return make_response({"message":"User Created Successfully"},201)
    
    def user_purchase_model(self,user_id,product_id,product_qt):
        self.cur.execute(f"SELECT * FROM users WHERE user_id='{user_id}'")
        user = self.cur.fetchone()
        if not user:
            return make_response({"message": "User not found"}, 404)
        
        self.cur.execute(f"SELECT * FROM myntradata WHERE product_id='{product_id}'")
        product = self.cur.fetchone()
        if not product:
            return make_response({"message": "Product not found"}, 404)
        
        try:
            purchase_time = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
            self.cur.execute("INSERT INTO user_purchase (user_id, product_id, purchase_time, product_qt) VALUES (%s, %s, %s, %s)",
                             (user_id, product_id, purchase_time, product_qt))
            return make_response({"message": "Purchase record added successfully"}, 201)
        except Exception as e:
            return make_response({"message": "Error adding purchase record", "error": str(e)}, 500)
    
    def user_getall_purchase_model(self):
        self.cur.execute("SELECT * FROM user_purchase")
        result=self.cur.fetchall()
        if(len(result)>0):
            res=make_response({"payload":result},200)
            res.headers['Access-Control-Allow-Origin']="*"
            return res
        else:
            return make_response({"message":"No data found"},204)
        
    def user_update_model(self,user_id,data):
        
        self.cur.execute(f"SELECT * FROM users WHERE user_id='{user_id}'")
        user = self.cur.fetchone()
        if not user:
            return make_response({"message": "User not found"}, 404)

        self.cur.execute(f"UPDATE users SET name='{data['name']}',email='{data['email']}',phone='{data['phone']}' WHERE user_id='{user_id}'")
        if self.cur.rowcount>0:
            return make_response({"message":"User Updated Successfully"},201)
        else:
            return make_response({"message":"Nothing to Update"},202)
        
    def user_delete_model(self,id):
        self.cur.execute(f"DELETE FROM users WHERE user_id= {id}")
        if self.cur.rowcount>0:
            return make_response({"message":"User Deleted Successfully"},200)
        else:
            return make_response({"message":"Nothing to Delete"},202)