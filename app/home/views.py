# _*_ coding: utf-8 _*_
__author__ = 'mtianyan'
__date__ = '2017/8/26 17:07'

from . import home

@home.route("/")
def index():
    return "<h1 style='color:green'>this is home</h1>"