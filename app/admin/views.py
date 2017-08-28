# _*_ coding: utf-8 _*_
__author__ = 'mtianyan'
__date__ = '2017/8/26 17:06'


from . import admin

@admin.route("/")
def index():
    return "<h1 style='color:red'>this is admin</h1>"