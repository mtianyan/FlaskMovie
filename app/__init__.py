# _*_ coding: utf-8 _*_
import os

from config.base_config import SQLALCHEMY_DATABASE_URI

__author__ = 'mtianyan'
__date__ = '2017/8/26 17:05'
from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
from flask_redis import FlaskRedis

app = Flask(__name__)
# 用于连接数据的数据库。
# app.config["SQLALCHEMY_DATABASE_URI"] = "mysql+pymysql://root:mtianyanmysql@115.159.122.64:3306/movie"
app.config["SQLALCHEMY_DATABASE_URI"] = SQLALCHEMY_DATABASE_URI
# 如果设置成 True (默认情况)，Flask-SQLAlchemy 将会追踪对象的修改并且发送信号。
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = True
app.config["REDIS_URL"] = "redis://127.0.0.1:6379/0"
app.config['SECRET_KEY'] = 'mtianyan_movie'
app.config["UP_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)), "static/uploads/")
app.config["FC_DIR"] = os.path.join(os.path.abspath(os.path.dirname(__file__)), "static/uploads/users/")
app.debug = True
db = SQLAlchemy(app)
rd = FlaskRedis(app)

# 不要在生成db之前导入注册蓝图。
from app.home import home as home_blueprint
from app.admin import admin as admin_blueprint

app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint, url_prefix="/admin")


@app.errorhandler(404)
def page_not_found(error):
    """
    404
    """
    return render_template("home/404.html"), 404
