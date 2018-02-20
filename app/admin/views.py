# _*_ coding: utf-8 _*_
from flask import render_template, redirect, url_for

__author__ = 'mtianyan'
__date__ = '2017/8/26 17:06'


from . import admin


@admin.route("/login/")
def login():
    """
    后台登录
    """
    return render_template("admin/login.html")


@admin.route("/logout/")
def logout():
    """
    后台注销登录
    """
    return redirect(url_for("admin.login"))


@admin.route("/pwd/")
def pwd():
    """
    后台密码修改
    """
    return render_template("admin/pwd.html")


@admin.route("/")
def index():
    """
    后台首页系统管理
    """
    return render_template("admin/index.html")


@admin.route("/tag/add/")
def tag_add():
    """
    标签添加与编辑
    """
    return render_template("admin/tag_add.html")


@admin.route("/tag/list/")
def tag_list():
    """
    标签列表
    """
    return render_template("admin/tag_list.html")


@admin.route("/movie/add/")
def movie_add():
    """
    编辑电影页面
    """
    return render_template("admin/movie_add.html")


@admin.route("/movie/list/")
def movie_list():
    """
    电影列表页面
    """
    return render_template("admin/movie_list.html")


@admin.route("/preview/add/")
def preview_add():
    """
    上映预告添加
    """
    return render_template("admin/preview_add.html")


@admin.route("/preview/list/")
def preview_list():
    """
    上映预告列表
    """
    return render_template("admin/preview_list.html")


@admin.route("/user/list/")
def user_list():
    """
    会员列表
    """
    return render_template("admin/user_list.html")


@admin.route("/user/view/")
def user_view():
    """
    查看会员
    """
    return render_template("admin/user_view.html")


@admin.route("/comment/list/")
def comment_list():
    """
    评论列表
    """
    return render_template("admin/comment_list.html")


@admin.route("/moviecol/list/")
def moviecol_list():
    """
    电影收藏
    """
    return render_template("admin/moviecol_list.html")


@admin.route("/oplog/list/")
def oplog_list():
    """
    操作日志管理
    """
    return render_template("admin/oplog_list.html")


@admin.route("/adminloginlog/list/")
def adminloginlog_list():
    """
    管理员日志列表
    """
    return render_template("admin/adminloginlog_list.html")


@admin.route("/userloginlog/list/")
def userloginlog_list():
    """
    会员日志列表
    """
    return render_template("admin/userloginlog_list.html")


@admin.route("/role/add/")
def role_add():
    """
    角色添加
    """
    return render_template("admin/role_add.html")


@admin.route("/role/list/")
def role_list():
    """
    角色列表
    """
    return render_template("admin/role_list.html")


@admin.route("/auth/add/")
def auth_add():
    """
    添加权限
    """
    return render_template("admin/auth_add.html")


@admin.route("/auth/list/")
def auth_list():
    """
    权限列表
    """
    return render_template("admin/auth_list.html")


@admin.route("/admin/add/")
def admin_add():
    """
    添加管理员
    """
    return render_template("admin/admin_add.html")


@admin.route("/admin/list/")
def admin_list():
    """
    管理员列表
    """
    return render_template("admin/admin_list.html")