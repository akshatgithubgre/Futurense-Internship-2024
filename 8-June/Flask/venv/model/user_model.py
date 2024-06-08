import json
import mysql.connector
from flask import make_response
class user_model():
    def __init__(self):
        try:
            self.con=mysql.connector.connect(host="localhost",username="root",password="passwrod",database="flask_tutorial")
            self.con.autocommit=True
            self.cur=self.con.cursor(dictionary=True)
            print("Connection successfull")
        except:
            print("Some error")