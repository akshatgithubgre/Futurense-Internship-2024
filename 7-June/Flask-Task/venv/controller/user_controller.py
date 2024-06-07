from app import app
from model.user_model import user_model#first model.usermodel refer to file name and import user_model refers to class name
obj=user_model()
@app.route("/user/signup")
def user_signup_controller():
    return obj.user_signup_model()

# browser->app.py->controller->init.py->user_controller.py->model->user_model.py