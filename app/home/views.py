# _*_ coding: utf-8 _*_
from functools import wraps

__author__ = 'mtianyan'
__date__ = '2017/8/26 17:07'

import uuid
from werkzeug.security import generate_password_hash
from app import db
from home.forms import RegistForm, LoginForm
from app.models import User, Userlog
from . import home
from flask import render_template, url_for, redirect, flash, session, request


def user_login_req(f):
    """
    登录装饰器
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "user" not in session:
            return redirect(url_for("home.login", next=request.url))
        return f(*args, **kwargs)

    return decorated_function


@home.route("/login/", methods=["GET", "POST"])
def login():
    """
    登录
    """
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        user = User.query.filter_by(name=data["name"]).first()
        if not user.check_pwd(data["pwd"]):
            flash("密码错误！", "err")
            return redirect(url_for("home.login"))
        session["user"] = user.name
        session["user_id"] = user.id
        userlog = Userlog(
            user_id=user.id,
            ip=request.remote_addr
        )
        db.session.add(userlog)
        db.session.commit()
        return redirect(url_for("home.user"))
    return render_template("home/login.html", form=form)


@home.route("/logout/")
def logout():
    """
    退出登录
    """
    # 重定向到home模块下的登录。
    session.pop("user", None)
    session.pop("user_id", None)
    return redirect(url_for('home.login'))


@home.route("/register/", methods=["GET", "POST"])
def register():
    """
    会员注册
    """
    form = RegistForm()
    if form.validate_on_submit():
        data = form.data
        user = User(
            name=data["name"],
            email=data["email"],
            phone=data["phone"],
            pwd=generate_password_hash(data["pwd"]),
            uuid=uuid.uuid4().hex
        )
        db.session.add(user)
        db.session.commit()
        flash("注册成功！", "ok")
    return render_template("home/register.html", form=form)


@home.route("/user/")
@user_login_req
def user():
    """
    用户中心
    """
    return render_template("home/user.html")


@home.route("/pwd/")
@user_login_req
def pwd():
    """
    修改密码
    """
    return render_template("home/pwd.html")


@home.route("/comments/")
@user_login_req
def comments():
    """
    评论记录
    """
    return render_template("home/comments.html")


@home.route("/loginlog/")
@user_login_req
def loginlog():
    """
    登录日志
    """
    return render_template("home/loginlog.html")


@home.route("/moviecol/")
@user_login_req
def moviecol():
    """
    收藏电影
    """
    return render_template("home/moviecol.html")
#


@home.route("/")
def index():
    """
     首页电影列表
    """
    return render_template("home/index.html")


@home.route("/animation/")
def animation():
    """
    首页轮播动画
    """
    return render_template("home/animation.html")


@home.route("/search/")
def search():
    """
    搜索
    """
    return render_template("home/search.html")


@home.route("/play/")
def play():
    """
    播放
    """
    return render_template("home/play.html")


