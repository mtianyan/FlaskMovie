# _*_ coding: utf-8 _*_
__author__ = 'mtianyan'
__date__ = '2017/8/26 17:07'

from . import home
from flask import render_template, url_for, redirect


@home.route("/")
def index():
    return render_template("home/index.html")


# 登录
@home.route("/login/")
def login():
    return render_template("home/login.html")


# 退出
@home.route("/logout/")
def logout():
    # 重定向到home模块下的登录。
    return redirect(url_for('home.login'))


# 会员注册
@home.route("/register/")
def register():
    return render_template("home/register.html")
