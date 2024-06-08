import json
import mysql.connector
from flask import make_response
from datetime import datetime,timedelta
from config.config import dbconfig
import jwt
class user_model():
    def __init__(self):
        # Connections estabilishment code
        try:
            self.con=mysql.connector.connect(host=dbconfig['hostname'],username=dbconfig['username'],password=dbconfig['password'],database=dbconfig['database'])
            self.con.autocommit=True
            self.cur=self.con.cursor(dictionary=True)
            print("Connection successfull in user_model")
        except:
            print("Some error")
    def user_getall_model(self):
        # Connection estabilishment code
        # Query execution code
        self.cur.execute("SELECT * FROM users")
        result=self.cur.fetchall()
        if(len(result)>0):
            # return json.dumps(result)#dumps function turn to convert that serialized object(result) to string format but we have to generate a better readable format
            
            res=make_response({"payload":result},200)
            res.headers['Access-Control-Allow-Origin']="*"# this header is necessary to be present here , postman never blocks a request as it is a developer tool but browsers like firefox, chrome they block if they dont get access control allow origin
            return res
            # return make_response({"payload":result},200)#this will return json data as postman api tool will beautify it whereas for dumps postamn will not beautify it
        else:
            return make_response({"message":"No Data found"},204)#204 doesnt need a body
        

    def user_addone_model(self,data):
        # self.cur.execute("SELECT * FROM users")
        # print(data)
        self.cur.execute(f"INSERT INTO users(name,email,phone,role_id,password) VALUES ('{data['name']}','{data['email']}','{data['phone']}','{data['role_id']}','{data['password']}')")
        # print(data['email'])
        return make_response({"message":"User Created Successfully"},201)
    
    def user_add_multiple_model(self,data):
        # "INSERT INTO table(columns) VALUES (), () ,()"
        qry="INSERT INTO users(name,email,phone,role_id,password) VALUES "
        for userdata in data:
            qry+=f"('{userdata['name']}','{userdata['email']}','{userdata['phone']}','{userdata['role_id']}','{userdata['password']}'),"
        finalqry=qry.rstrip(",")
        self.cur.execute(finalqry)
        return make_response({"message":"Multiple Users Created Successfully"},201)
    
    def user_update_model(self,data):
        self.cur.execute(f"UPDATE users SET name='{data['name']}',email='{data['email']}',phone='{data['phone']}',role_id='{data['role_id']}',password='{data['password']}' WHERE id={data['id']}")
        if self.cur.rowcount>0:
            return make_response({"message":"User Updated Successfully"},201)
        else:
            return make_response({"message":"Nothing to Update"},202)
        
    def user_delete_model(self,id):
        self.cur.execute(f"DELETE FROM users WHERE id= {id}")
        if self.cur.rowcount>0:
            return make_response({"message":"User Deleted Successfully"},200)
        else:
            return make_response({"message":"Nothing to Delete"},202)
        
    def user_patch_model(self,data,id):
        #UPDATE users SET ,col=val,col=val WHERE id={id}, we have to change the part between SET and WHERE
        qry="UPDATE users SET "
        k=""
        for key in data:
            k+=f"{key}='{data[key]}',"
        qry+=k[:-1]+f" WHERE id={id}"
        # return qry
        self.cur.execute(qry)
        if self.cur.rowcount>0:
            return make_response({"message":"User Updated Successfully"},201)
        else:
            return make_response({"message":"Nothing to Update"},202)
        
    def user_pagination_model(self,limit,page):
        limit=int(limit)
        page=int(page)
        start=(page*limit)-limit
        qry=f"SELECT * FROM users LIMIT {start},{limit}"
        self.cur.execute(qry)
        result=self.cur.fetchall()
        if(len(result)>0):
            # return json.dumps(result)#dumps function turn to convert that serialized object(result) to string format but we have to generate a better readable format
            
            res=make_response({"payload":result,"page_no":page,"limit":limit},200)
            return res
            # return make_response({"payload":result},200)#this will return json data as postman api tool will beautify it whereas for dumps postamn will not beautify it
        else:
            return make_response({"message":"No Data found"},204)#204 doesnt need a body
    
    def user_upload_avatar_model(self,uid,filepath):
        self.cur.execute(f"UPDATE users SET avatar='{filepath}' WHERE id={uid}")
        if self.cur.rowcount>0:
            return make_response({"message":"File Successfully"},201)
        else:
            return make_response({"message":"Nothing to Update"},202)
        
    def user_login_model(self,data):
        self.cur.execute(f"SELECT id,name,email,phone,avatar,role_id FROM users WHERE email='{data['email']}' and password='{data['password']}'")
        result=self.cur.fetchall()
        userdata=result[0]
        exp_time=datetime.now()+timedelta(minutes=15)
        exp_epoch_time=int(exp_time.timestamp())
        payload={
            "payload":userdata,
            "exp":exp_epoch_time
        }
        jwttoken=jwt.encode(payload,"sagar",algorithm="HS256")#sgaar is encryption key
        return make_response({"token":jwttoken},200)