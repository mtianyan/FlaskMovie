# _*_ coding: utf-8 _*_
__author__ = 'mtianyan'
__date__ = '2017/8/26 17:06'

from flask import Blueprint

home = Blueprint("home", __name__)

import app.home.views