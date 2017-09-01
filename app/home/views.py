# _*_ coding: utf-8 _*_
__author__ = 'mtianyan'
__date__ = '2017/8/26 17:07'

from . import home
from flask import render_template

@home.route("/")
def index():
    return render_template("home/index.html")