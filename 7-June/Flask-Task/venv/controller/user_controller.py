from app import app
from model.user_model import user_model#first model.usermodel refer to file name and import user_model refers to class name
from flask import request
obj=user_model()
@app.route("/user/getall")
def user_getall_controller():
    return obj.user_getall_model()

# browser->app.py->controller->init.py->user_controller.py->model->user_model.py


@app.route("/user/addone",methods=["POST"])
def user_addone_controller():
    return obj.user_addone_model(request.form)


@app.route("/user/update",methods=["PUT"])
def user_update_controller():
    return obj.user_update_model(request.form)