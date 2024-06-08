import json
import mysql.connector
from flask import make_response
class user_model():
    def __init__(self):
        try:
            self.con=mysql.connector.connect(host="localhost",username="root",password="",database="flask_revision")
            self.con.autocommit=True
            self.cur=self.con.cursor(dictionary=True)
            print("Connection successfull")
        except:
            print("Some error")
    def user_getall_model(self):
        self.cur.execute("SELECT * FROM ecommerce")
        result=self.cur.fetchall()
        if(len(result)>0):
            res=make_response({"payload":result},200)
            res.headers['Access-Control-Allow-Origin']="*"
            return res
        else:
            return make_response({"message":"No Data found"},204)
        
    def user_addone_model(self,data):
        print("i am being called",data)
        self.cur.execute(f"INSERT INTO ecommerce(name,state,checkout_date,location) VALUES ('{data['name']}','{data['state']}','{data['checkout_date']}','{data['location']}')")
        return make_response({"message":"User Created Successfully"},201)
    
    def user_update_model(self,data):
        self.cur.execute(f"UPDATE ecommerce SET name='{data['name']}',state='{data['state']}',checkout_date='{data['checkout_date']}',location='{data['location']}' WHERE id={data['id']}")
        if self.cur.rowcount>0:
            return make_response({"message":"User Updated Successfully"},201)
        else:
            return make_response({"message":"Nothing to Update"},202)
        
    def user_delete_model(self,id):
        self.cur.execute(f"DELETE FROM ecommerce WHERE id= {id}")
        if self.cur.rowcount>0:
            return make_response({"message":"User Deleted Successfully"},200)
        else:
            return make_response({"message":"Nothing to Delete"},202)