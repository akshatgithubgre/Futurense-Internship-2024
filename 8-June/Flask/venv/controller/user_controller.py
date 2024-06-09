from app import app
from model.user_model import user_model
from flask import request,send_file
from datetime import datetime
obj=user_model()

@app.route("/user/getalluser")
def user_getall_user_controller():
    return obj.user_getall_user_model()

@app.route("/user/addoneuser",methods=["POST"])
def user_addoneuser_controller():
    print("Hey i am addone user controller")
    return obj.user_addoneuser_model(request.form)

@app.route("/user/purchase/<userid>/<productid>/<productqt>",methods=["POST"])
def user_purchase_controller(userid,productid,productqt):
    print("hey i am in purchase controller",userid,"\n\n")
    return obj.user_purchase_model(userid,productid,productqt)

@app.route("/user/getallpurchase")
def user_getall_purchase_controller():
    return obj.user_getall_purchase_model()

@app.route("/user/<id>/update",methods=["PUT"])
def user_update_controller(id):
    return obj.user_update_model(id,request.form)

@app.route("/user/<id>/delete",methods=["DELETE"])
def user_delete_controller(id):
    return obj.user_delete_model(id)