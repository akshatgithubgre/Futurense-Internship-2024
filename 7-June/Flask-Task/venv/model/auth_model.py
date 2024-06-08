import json
import mysql.connector
import re
from flask import make_response,request
# from datetime import datetime,timedelta
import jwt
class auth_model():
    def __init__(self):
        # Connections estabilishment code
        try:
            self.con=mysql.connector.connect(host="localhost",username="root",password="",database="flask_tutorial")
            self.con.autocommit=True
            self.cur=self.con.cursor(dictionary=True)
            print("Connection successfull in auth_model")
        except:
            print("Some error")
    def token_auth(self,endpoint):
        def inner1(func):
            def inner2(*args):
                authorization=request.headers.get("Authorization")
                if re.match("Bearer *([^ ]+) *$",authorization,flags=0):
                    token=authorization.split(" ")[1]
                    print(token)
                    return func(*args)
                else:
                    return make_response({"Error":"INVALID_TOKEN"},401)
            return inner2
        return inner1