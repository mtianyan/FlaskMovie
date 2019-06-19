/*
 Navicat Premium Data Transfer

 Source Server         : ght_ubuntu
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : 139.199.189.211:3306
 Source Schema         : movie

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 06/05/2018 19:54:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_super` smallint(6) NULL DEFAULT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `ix_admin_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'mtianyan', 'pbkdf2:sha256:50000$9GaXWuON$e0c21ad6c89523bb8e98c07ad0f42f732169279c829dfe6c2da53cf28f171ae0', 0, NULL, '2018-03-11 20:19:59');

-- ----------------------------
-- Table structure for adminlog
-- ----------------------------
DROP TABLE IF EXISTS `adminlog`;
CREATE TABLE `adminlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  INDEX `ix_adminlog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `adminlog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of adminlog
-- ----------------------------
INSERT INTO `adminlog` VALUES (14, 1, '127.0.0.1', '2018-03-11 20:21:27');
INSERT INTO `adminlog` VALUES (15, 1, '127.0.0.1', '2018-03-11 20:21:49');
INSERT INTO `adminlog` VALUES (16, 1, '127.0.0.1', '2018-03-22 00:08:15');
INSERT INTO `adminlog` VALUES (17, 1, '127.0.0.1', '2018-03-22 00:14:06');
INSERT INTO `adminlog` VALUES (18, 1, '127.0.0.1', '2018-03-22 06:25:35');
INSERT INTO `adminlog` VALUES (19, 1, '127.0.0.1', '2018-03-22 07:49:43');
INSERT INTO `adminlog` VALUES (20, 1, '127.0.0.1', '2018-03-22 11:33:37');
INSERT INTO `adminlog` VALUES (21, 1, '127.0.0.1', '2018-03-22 11:57:16');
INSERT INTO `adminlog` VALUES (22, 1, '127.0.0.1', '2018-03-22 12:53:55');
INSERT INTO `adminlog` VALUES (23, 1, '127.0.0.1', '2018-03-29 14:28:42');
INSERT INTO `adminlog` VALUES (24, 1, '127.0.0.1', '2018-03-29 14:29:00');
INSERT INTO `adminlog` VALUES (25, 1, '127.0.0.1', '2018-03-31 00:13:28');
INSERT INTO `adminlog` VALUES (26, 1, '127.0.0.1', '2018-03-31 00:18:24');
INSERT INTO `adminlog` VALUES (27, 1, '::1', '2018-04-02 01:12:02');
INSERT INTO `adminlog` VALUES (28, 1, '117.136.72.75', '2018-05-04 03:53:30');

-- ----------------------------
-- Table structure for auth
-- ----------------------------
DROP TABLE IF EXISTS `auth`;
CREATE TABLE `auth`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `url`(`url`) USING BTREE,
  INDEX `ix_auth_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `movie_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_comment_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (23, '<p>有电影和弹幕了。真棒棒</p>', 7, 40, '2018-04-02 01:06:50');
INSERT INTO `comment` VALUES (24, '<p>嘹咋咧</p>', 7, 46, '2018-04-05 19:20:24');
INSERT INTO `comment` VALUES (25, '<p>卡啦啦啦</p>', 7, 48, '2018-04-10 10:58:17');

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `star` smallint(6) NULL DEFAULT NULL,
  `playnum` bigint(20) NULL DEFAULT NULL,
  `commentnum` bigint(20) NULL DEFAULT NULL,
  `tag_id` int(11) NULL DEFAULT NULL,
  `area` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `release_time` date NULL DEFAULT NULL,
  `length` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE,
  UNIQUE INDEX `url`(`url`) USING BTREE,
  UNIQUE INDEX `logo`(`logo`) USING BTREE,
  INDEX `tag_id`(`tag_id`) USING BTREE,
  INDEX `ix_movie_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES (7, 'flask构建弹幕电影', '20180331002223c81386f69e1e4c33bfed07759a3b82c1.wmv', 'flask构建弹幕电影', '201803310022236a7f8321fe4f4af9b34b769e495521c2.jpg', 5, 182, 3, 16, '中国', '2018-03-01', '10', '2018-03-31 00:22:23');

-- ----------------------------
-- Table structure for moviecol
-- ----------------------------
DROP TABLE IF EXISTS `moviecol`;
CREATE TABLE `moviecol`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_moviecol_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `moviecol_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `moviecol_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reason` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_id`(`admin_id`) USING BTREE,
  INDEX `ix_oplog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`admin_id`) REFERENCES `admin` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of oplog
-- ----------------------------
INSERT INTO `oplog` VALUES (2, 1, '127.0.0.1', '添加标签爱情', '2018-03-31 00:13:39');
INSERT INTO `oplog` VALUES (3, 1, '127.0.0.1', '添加标签动作', '2018-03-31 00:13:45');
INSERT INTO `oplog` VALUES (4, 1, '127.0.0.1', '添加标签爱情动作', '2018-03-31 00:13:50');
INSERT INTO `oplog` VALUES (5, 1, '127.0.0.1', '添加标签文艺', '2018-03-31 00:13:55');
INSERT INTO `oplog` VALUES (6, 1, '127.0.0.1', '添加标签搞笑', '2018-03-31 00:14:09');

-- ----------------------------
-- Table structure for preview
-- ----------------------------
DROP TABLE IF EXISTS `preview`;
CREATE TABLE `preview`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `title`(`title`) USING BTREE,
  UNIQUE INDEX `logo`(`logo`) USING BTREE,
  INDEX `ix_preview_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of preview
-- ----------------------------
INSERT INTO `preview` VALUES (1, '1', '20180331002259c5c5603066474243be7ad77fb5ea4b5d.jpg', '2018-03-31 00:23:00');
INSERT INTO `preview` VALUES (2, '2', '2018033100231857e5680e117c456bbe16a8ae343d84fc.jpg', '2018-03-31 00:23:19');
INSERT INTO `preview` VALUES (3, '3', '201803310023339c87335d973d4327a55c90c6b0dfcbd8.jpg', '2018-03-31 00:23:33');
INSERT INTO `preview` VALUES (4, '4', '201803310023473cbd44f60a224d47aa2429a0bd586219.jpg', '2018-03-31 00:23:47');
INSERT INTO `preview` VALUES (5, '5', '20180402011241f2b92b6f1d514f27bd8a378ddb2ed5e6.jpg', '2018-04-02 01:12:41');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `auths` varchar(600) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `ix_role_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  INDEX `ix_tag_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tag
-- ----------------------------
INSERT INTO `tag` VALUES (14, '爱情', '2018-03-31 00:13:39');
INSERT INTO `tag` VALUES (15, '动作', '2018-03-31 00:13:45');
INSERT INTO `tag` VALUES (16, '爱情动作', '2018-03-31 00:13:50');
INSERT INTO `tag` VALUES (17, '文艺', '2018-03-31 00:13:55');
INSERT INTO `tag` VALUES (18, '搞笑', '2018-03-31 00:14:08');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pwd` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `info` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL,
  `face` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  `uuid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE,
  UNIQUE INDEX `email`(`email`) USING BTREE,
  UNIQUE INDEX `phone`(`phone`) USING BTREE,
  UNIQUE INDEX `face`(`face`) USING BTREE,
  UNIQUE INDEX `uuid`(`uuid`) USING BTREE,
  INDEX `ix_user_addtime`(`addtime`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (40, 'mtianyan', 'pbkdf2:sha256:50000$9GaXWuON$e0c21ad6c89523bb8e98c07ad0f42f732169279c829dfe6c2da53cf28f171ae0', '1147727180@qq.com', '18092671458', NULL, NULL, '2018-03-11 20:19:13', '0c54d72083c94cdda6f2bc7c6fb967cc');
INSERT INTO `user` VALUES (41, 'kobe', 'pbkdf2:sha256:50000$Tr7ALxLJ$ffeb935bf01eafe69f78b227c999f0f4786b3de150cabfb13f8911bb16f26b75', 'kobe@gmail.com', '18910441212', NULL, NULL, '2018-03-16 15:30:50', '2ca17669c93c4935834cf38d8792070e');
INSERT INTO `user` VALUES (42, 'elementsong', 'pbkdf2:sha256:50000$bq3wQOxo$a1f5bd2e7eee942e3f17ba8e4547ecd76062ddb62d5c0829d1bbe8e6ea34beb8', '916939772@qq.com', '18729388704', NULL, NULL, '2018-03-18 16:22:48', '5381c951550647a2b947f7fc0aa880fb');
INSERT INTO `user` VALUES (43, '1', 'pbkdf2:sha256:50000$a3o1dA69$29cc646ac03ce947c909760135ff61fd823eb944939735b5dc0f5e48c075e89e', '1@1.com', '13888888888', NULL, NULL, '2018-03-20 21:25:53', 'c1d9c417085f430094283f4c9300b198');
INSERT INTO `user` VALUES (44, 'fenfen321', 'pbkdf2:sha256:50000$fq7oPaYc$9bd01521e44b4d3b149bd8d555ad034c15768ea15eac516e0f23184e29b72364', '111@qq.com', '15061884383', NULL, NULL, '2018-03-23 16:44:23', 'd6c665b4b8b74f2ea2d7be228f735a48');
INSERT INTO `user` VALUES (45, 'hello', 'pbkdf2:sha256:50000$HKqtaMpo$72401becd5857c3b37b19287f5d13e4bad698c4481a8edf8fb63878ceb202030', 'hellohello@hello.com', '13695455549', NULL, NULL, '2018-03-30 11:51:41', 'bea6fe42958e406cb279e968d476034c');
INSERT INTO `user` VALUES (46, 'alfred3', 'pbkdf2:sha256:50000$IkRy8wGH$9a61b38ed48e46040b269f4c2b205459b84571bc322a609318c07d6e00e1a5ef', 'alfred342@sohu.com', '13700102938', '弹幕电影，flask .', '201804051918498ce0010854f840558c46c048f5240121.gif', '2018-04-05 19:16:28', '363346ae6cf84d1c82503de7df03131f');
INSERT INTO `user` VALUES (47, 'test', 'pbkdf2:sha256:50000$0Hn1lc1l$a35ad4932b40d7680810937e32da56d6bb41491048ea8edbf4aea205b1188019', 'setest@qq.com', '15678900987', NULL, NULL, '2018-04-07 21:01:52', 'b6b3b01b80fa43aba6c6b64aa5255f00');
INSERT INTO `user` VALUES (48, 'asdasd', 'pbkdf2:sha256:50000$cZ8q2fst$fc0c01d43aa7acb33d2ba877b67e09c7644552816c601ce814d3550431d8861f', 'sdfsdfs@qq.com', '18888888888', NULL, NULL, '2018-04-10 10:56:56', 'ef63d29204494cb6ac319011a8213bef');
INSERT INTO `user` VALUES (49, 'test11', 'pbkdf2:sha256:50000$1Iy1151y$e2dd58faf35f943be3dc1b6fb2ef4ebeb7215c54e0be097e7d7cde3459139c14', '12342323@qq.com', '13747588890', '12313', '2018041419071955e84c95f1a04f2b9d2738fb7b6fb011.jpg', '2018-04-14 19:06:16', 'dcdeea47da54468ab9ddd2cb8176ea60');
INSERT INTO `user` VALUES (50, 'ABCD123', 'pbkdf2:sha256:50000$QGYiU5nh$d44a0f15d2f5899f69fd99b43f776ba105dca82664d2d8833b96a7334213123f', 'ERERWQEW@qq.com', '13123554444', NULL, NULL, '2018-04-15 23:01:30', '3621dd556a314b0baaa33879800d578f');

-- ----------------------------
-- Table structure for userlog
-- ----------------------------
DROP TABLE IF EXISTS `userlog`;
CREATE TABLE `userlog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NULL DEFAULT NULL,
  `ip` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `addtime` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `ix_userlog_addtime`(`addtime`) USING BTREE,
  CONSTRAINT `userlog_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 40 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userlog
-- ----------------------------
INSERT INTO `userlog` VALUES (23, 40, '127.0.0.1', '2018-03-11 20:19:21');
INSERT INTO `userlog` VALUES (24, 41, '127.0.0.1', '2018-03-16 15:31:18');
INSERT INTO `userlog` VALUES (25, 41, '127.0.0.1', '2018-03-16 15:51:49');
INSERT INTO `userlog` VALUES (26, 41, '127.0.0.1', '2018-03-16 15:51:50');
INSERT INTO `userlog` VALUES (27, 42, '127.0.0.1', '2018-03-18 16:23:03');
INSERT INTO `userlog` VALUES (28, 42, '127.0.0.1', '2018-03-18 16:23:15');
INSERT INTO `userlog` VALUES (29, 43, '127.0.0.1', '2018-03-20 21:26:19');
INSERT INTO `userlog` VALUES (30, 44, '127.0.0.1', '2018-03-23 16:44:37');
INSERT INTO `userlog` VALUES (31, 45, '127.0.0.1', '2018-03-30 11:51:50');
INSERT INTO `userlog` VALUES (32, 40, '127.0.0.1', '2018-04-02 01:06:26');
INSERT INTO `userlog` VALUES (33, 46, '127.0.0.1', '2018-04-05 19:16:53');
INSERT INTO `userlog` VALUES (34, 46, '127.0.0.1', '2018-04-05 19:19:29');
INSERT INTO `userlog` VALUES (35, 47, '127.0.0.1', '2018-04-07 21:02:04');
INSERT INTO `userlog` VALUES (36, 40, '127.0.0.1', '2018-04-09 20:39:13');
INSERT INTO `userlog` VALUES (37, 48, '127.0.0.1', '2018-04-10 10:57:10');
INSERT INTO `userlog` VALUES (38, 49, '127.0.0.1', '2018-04-14 19:06:32');
INSERT INTO `userlog` VALUES (39, 50, '127.0.0.1', '2018-04-15 23:01:40');

SET FOREIGN_KEY_CHECKS = 1;
