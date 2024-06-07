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

@app.route("/user/delete/<id>",methods=["DELETE"])
def user_delete_controller(id):
    return obj.user_delete_model(id)

@app.route("/user/patch/<id>",methods=["PATCH"])
def user_patch_controller(id):
    data=request.args.to_dict()
    return obj.user_patch_model(data,id)

@app.route("/user/getall/limit/<limit>/page/<page>",methods=["GET"])
def user_pagination_controller(limit,page):
    return obj.user_pagination_model(limit,page)