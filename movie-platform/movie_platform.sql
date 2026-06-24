/*
 Navicat Premium Data Transfer

 Source Server         : 1
 Source Server Type    : MySQL
 Source Server Version : 80012
 Source Host           : localhost:3306
 Source Schema         : movie_platform

 Target Server Type    : MySQL
 Target Server Version : 80012
 File Encoding         : 65001

 Date: 24/06/2026 15:40:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (1, 'admin');

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_group_permissions_group_id_permission_id_0cd325b0_uniq`(`group_id`, `permission_id`) USING BTREE,
  INDEX `auth_group_permissions_group_id_b120cbf9`(`group_id`) USING BTREE,
  INDEX `auth_group_permissions_permission_id_84c5c92e`(`permission_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 37 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------
INSERT INTO `auth_group_permissions` VALUES (1, 1, 1);
INSERT INTO `auth_group_permissions` VALUES (2, 1, 2);
INSERT INTO `auth_group_permissions` VALUES (3, 1, 3);
INSERT INTO `auth_group_permissions` VALUES (4, 1, 4);
INSERT INTO `auth_group_permissions` VALUES (5, 1, 5);
INSERT INTO `auth_group_permissions` VALUES (6, 1, 6);
INSERT INTO `auth_group_permissions` VALUES (7, 1, 7);
INSERT INTO `auth_group_permissions` VALUES (8, 1, 8);
INSERT INTO `auth_group_permissions` VALUES (9, 1, 9);
INSERT INTO `auth_group_permissions` VALUES (10, 1, 10);
INSERT INTO `auth_group_permissions` VALUES (11, 1, 11);
INSERT INTO `auth_group_permissions` VALUES (12, 1, 12);
INSERT INTO `auth_group_permissions` VALUES (13, 1, 13);
INSERT INTO `auth_group_permissions` VALUES (14, 1, 14);
INSERT INTO `auth_group_permissions` VALUES (15, 1, 15);
INSERT INTO `auth_group_permissions` VALUES (16, 1, 16);
INSERT INTO `auth_group_permissions` VALUES (17, 1, 17);
INSERT INTO `auth_group_permissions` VALUES (18, 1, 18);
INSERT INTO `auth_group_permissions` VALUES (19, 1, 19);
INSERT INTO `auth_group_permissions` VALUES (20, 1, 20);
INSERT INTO `auth_group_permissions` VALUES (21, 1, 21);
INSERT INTO `auth_group_permissions` VALUES (22, 1, 22);
INSERT INTO `auth_group_permissions` VALUES (23, 1, 23);
INSERT INTO `auth_group_permissions` VALUES (24, 1, 24);
INSERT INTO `auth_group_permissions` VALUES (25, 1, 25);
INSERT INTO `auth_group_permissions` VALUES (26, 1, 26);
INSERT INTO `auth_group_permissions` VALUES (27, 1, 27);
INSERT INTO `auth_group_permissions` VALUES (28, 1, 28);
INSERT INTO `auth_group_permissions` VALUES (29, 1, 29);
INSERT INTO `auth_group_permissions` VALUES (30, 1, 30);
INSERT INTO `auth_group_permissions` VALUES (31, 1, 31);
INSERT INTO `auth_group_permissions` VALUES (32, 1, 32);
INSERT INTO `auth_group_permissions` VALUES (33, 1, 33);
INSERT INTO `auth_group_permissions` VALUES (34, 1, 34);
INSERT INTO `auth_group_permissions` VALUES (35, 1, 35);
INSERT INTO `auth_group_permissions` VALUES (36, 1, 36);

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `auth_permission_content_type_id_codename_01ab375a_uniq`(`content_type_id`, `codename`) USING BTREE,
  INDEX `auth_permission_content_type_id_2f476e4b`(`content_type_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can view log entry', 1, 'view_logentry');
INSERT INTO `auth_permission` VALUES (5, 'Can add permission', 3, 'add_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can change permission', 3, 'change_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can delete permission', 3, 'delete_permission');
INSERT INTO `auth_permission` VALUES (8, 'Can view permission', 3, 'view_permission');
INSERT INTO `auth_permission` VALUES (9, 'Can add group', 2, 'add_group');
INSERT INTO `auth_permission` VALUES (10, 'Can change group', 2, 'change_group');
INSERT INTO `auth_permission` VALUES (11, 'Can delete group', 2, 'delete_group');
INSERT INTO `auth_permission` VALUES (12, 'Can view group', 2, 'view_group');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 4, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 4, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 4, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can view content type', 4, 'view_contenttype');
INSERT INTO `auth_permission` VALUES (17, 'Can add session', 5, 'add_session');
INSERT INTO `auth_permission` VALUES (18, 'Can change session', 5, 'change_session');
INSERT INTO `auth_permission` VALUES (19, 'Can delete session', 5, 'delete_session');
INSERT INTO `auth_permission` VALUES (20, 'Can view session', 5, 'view_session');
INSERT INTO `auth_permission` VALUES (21, 'Can add user', 6, 'add_user');
INSERT INTO `auth_permission` VALUES (22, 'Can change user', 6, 'change_user');
INSERT INTO `auth_permission` VALUES (23, 'Can delete user', 6, 'delete_user');
INSERT INTO `auth_permission` VALUES (24, 'Can view user', 6, 'view_user');
INSERT INTO `auth_permission` VALUES (25, 'Can add movie', 9, 'add_movie');
INSERT INTO `auth_permission` VALUES (26, 'Can change movie', 9, 'change_movie');
INSERT INTO `auth_permission` VALUES (27, 'Can delete movie', 9, 'delete_movie');
INSERT INTO `auth_permission` VALUES (28, 'Can view movie', 9, 'view_movie');
INSERT INTO `auth_permission` VALUES (29, 'Can add actor', 7, 'add_actor');
INSERT INTO `auth_permission` VALUES (30, 'Can change actor', 7, 'change_actor');
INSERT INTO `auth_permission` VALUES (31, 'Can delete actor', 7, 'delete_actor');
INSERT INTO `auth_permission` VALUES (32, 'Can view actor', 7, 'view_actor');
INSERT INTO `auth_permission` VALUES (33, 'Can add category', 8, 'add_category');
INSERT INTO `auth_permission` VALUES (34, 'Can change category', 8, 'change_category');
INSERT INTO `auth_permission` VALUES (35, 'Can delete category', 8, 'delete_category');
INSERT INTO `auth_permission` VALUES (36, 'Can view category', 8, 'view_category');
INSERT INTO `auth_permission` VALUES (37, 'Can add session', 11, 'add_session');
INSERT INTO `auth_permission` VALUES (38, 'Can change session', 11, 'change_session');
INSERT INTO `auth_permission` VALUES (39, 'Can delete session', 11, 'delete_session');
INSERT INTO `auth_permission` VALUES (40, 'Can view session', 11, 'view_session');
INSERT INTO `auth_permission` VALUES (41, 'Can add hall', 10, 'add_hall');
INSERT INTO `auth_permission` VALUES (42, 'Can change hall', 10, 'change_hall');
INSERT INTO `auth_permission` VALUES (43, 'Can delete hall', 10, 'delete_hall');
INSERT INTO `auth_permission` VALUES (44, 'Can view hall', 10, 'view_hall');
INSERT INTO `auth_permission` VALUES (45, 'Can add order', 12, 'add_order');
INSERT INTO `auth_permission` VALUES (46, 'Can change order', 12, 'change_order');
INSERT INTO `auth_permission` VALUES (47, 'Can delete order', 12, 'delete_order');
INSERT INTO `auth_permission` VALUES (48, 'Can view order', 12, 'view_order');
INSERT INTO `auth_permission` VALUES (49, 'Can add cinema', 13, 'add_cinema');
INSERT INTO `auth_permission` VALUES (50, 'Can change cinema', 13, 'change_cinema');
INSERT INTO `auth_permission` VALUES (51, 'Can delete cinema', 13, 'delete_cinema');
INSERT INTO `auth_permission` VALUES (52, 'Can view cinema', 13, 'view_cinema');
INSERT INTO `auth_permission` VALUES (53, 'Can add want record', 14, 'add_wantrecord');
INSERT INTO `auth_permission` VALUES (54, 'Can change want record', 14, 'change_wantrecord');
INSERT INTO `auth_permission` VALUES (55, 'Can delete want record', 14, 'delete_wantrecord');
INSERT INTO `auth_permission` VALUES (56, 'Can view want record', 14, 'view_wantrecord');
INSERT INTO `auth_permission` VALUES (57, 'Can add browse history', 15, 'add_browsehistory');
INSERT INTO `auth_permission` VALUES (58, 'Can change browse history', 15, 'change_browsehistory');
INSERT INTO `auth_permission` VALUES (59, 'Can delete browse history', 15, 'delete_browsehistory');
INSERT INTO `auth_permission` VALUES (60, 'Can view browse history', 15, 'view_browsehistory');

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `object_repr` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `django_admin_log_content_type_id_c4bce8eb`(`content_type_id`) USING BTREE,
  INDEX `django_admin_log_user_id_c564eba6`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 82 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------
INSERT INTO `django_admin_log` VALUES (1, '2026-05-19 16:21:52.030097', '1', 'admin', 1, '[{\"added\": {}}]', 2, 1);
INSERT INTO `django_admin_log` VALUES (2, '2026-05-19 16:27:35.832893', '1', '爱情', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (3, '2026-05-19 16:28:06.588775', '2', '动作', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (4, '2026-05-19 16:28:12.848832', '3', '科幻', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (5, '2026-05-19 16:29:27.154696', '1', '吴京', 1, '[{\"added\": {}}]', 7, 1);
INSERT INTO `django_admin_log` VALUES (6, '2026-05-19 16:32:12.726017', '1', '战狼', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (7, '2026-05-20 13:31:20.138659', '2', '大鱼海棠', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (8, '2026-05-20 14:11:54.258818', '1', '战狼', 2, '[{\"changed\": {\"fields\": [\"Score\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (9, '2026-05-20 14:22:22.220181', '1', 'Hall 1', 3, '', 10, 1);
INSERT INTO `django_admin_log` VALUES (10, '2026-05-20 14:22:40.531533', '2', 'CGV影城·国贸店', 1, '[{\"added\": {}}]', 10, 1);
INSERT INTO `django_admin_log` VALUES (11, '2026-05-20 14:31:25.052828', '2', 'CGV影城·国贸店', 2, '[]', 10, 1);
INSERT INTO `django_admin_log` VALUES (12, '2026-05-21 14:51:42.368005', '2', '大鱼海棠', 2, '[{\"changed\": {\"fields\": [\"Description\", \"Country\", \"Language\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (13, '2026-05-21 14:51:55.541853', '1', '战狼', 2, '[{\"changed\": {\"fields\": [\"Country\", \"Language\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (14, '2026-05-21 14:52:09.861016', '2', '大鱼海棠', 2, '[{\"changed\": {\"fields\": [\"Release time\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (15, '2026-05-21 14:52:30.849661', '4', '剧情', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (16, '2026-05-21 14:52:37.741124', '5', '动画', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (17, '2026-05-21 15:02:08.253092', '3', '楚门的世界', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (18, '2026-05-21 15:04:10.619252', '2', '大鱼海棠', 2, '[]', 9, 1);
INSERT INTO `django_admin_log` VALUES (19, '2026-05-21 15:31:37.397401', '1', '战狼', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (20, '2026-05-21 15:31:42.468768', '2', '大鱼海棠', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (21, '2026-05-21 15:32:09.307470', '3', '楚门的世界', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (22, '2026-05-21 16:06:53.710053', '4', '奶龙搞怪大作战2', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (23, '2026-05-21 16:08:10.698101', '5', '泰坦尼克号', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (24, '2026-05-21 16:09:38.160285', '6', '肖申克的救赎', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (25, '2026-05-21 16:09:51.340130', '6', '犯罪', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (26, '2026-05-21 16:12:11.145202', '7', '悬疑', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (27, '2026-05-21 16:12:16.439479', '8', '恐怖', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (28, '2026-05-21 16:12:24.840090', '7', '死寂', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (29, '2026-05-21 16:14:20.434666', '8', '蝙蝠侠：黑暗骑士', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (30, '2026-05-21 16:15:26.956593', '9', '喜剧', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (31, '2026-05-21 16:16:06.099179', '9', '功夫', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (32, '2026-05-21 16:18:42.175255', '10', '冒险', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (33, '2026-05-21 16:18:56.608917', '10', '哆啦A梦：大雄的新恐龙', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (34, '2026-05-21 16:20:24.113670', '11', '阿凡达', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (35, '2026-05-21 16:21:07.703216', '12', '阿凡达：水之道', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (36, '2026-05-21 16:22:06.527855', '13', '阿凡达：火与烬', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (37, '2026-05-21 16:23:05.873362', '14', '霸王别姬', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (38, '2026-05-21 16:26:55.373103', '15', '天书奇谭', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (39, '2026-05-21 16:27:58.529703', '16', '你的名字', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (40, '2026-05-21 16:29:46.032751', '17', '流浪地球', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (41, '2026-05-21 16:30:52.202985', '18', '流浪地球2', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (42, '2026-05-21 16:32:04.754543', '19', '流浪地球3', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (43, '2026-05-21 16:33:37.808203', '20', '鬼灭之刃：无限城篇 第一章 猗窝座再袭', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (44, '2026-05-21 16:35:56.621606', '21', '这个杀手不太冷', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (45, '2026-05-21 16:37:34.097203', '22', '哪吒', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (46, '2026-05-21 16:38:49.700621', '23', '哪吒之魔童闹海', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (47, '2026-05-21 16:40:09.935680', '24', '闪灵', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (48, '2026-05-21 16:41:35.684511', '25', '玩具总动员5', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (49, '2026-05-21 16:43:03.230684', '26', '玩具总动员4', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (50, '2026-05-21 16:44:24.579296', '27', '玩具总动员3', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (51, '2026-05-23 07:35:19.708727', '28', '盗梦空间', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (52, '2026-05-23 07:37:40.283817', '11', '历史', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (53, '2026-05-23 07:37:44.598998', '12', '战争', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (54, '2026-05-23 07:38:26.703460', '29', '长津湖', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (55, '2026-05-23 07:41:12.444272', '30', '釜山行', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (56, '2026-05-23 07:46:18.939897', '31', '南京照相馆', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (57, '2026-05-23 07:48:04.676678', '32', '戏台', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (58, '2026-05-23 07:49:42.895892', '33', '罗小黑战记2', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (59, '2026-05-23 07:52:27.248033', '34', '复仇者联盟5：毁灭之日', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (60, '2026-05-23 07:54:30.498956', '35', '复仇者联盟4：终局之战', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (61, '2026-05-23 07:57:09.279005', '36', '蜘蛛侠：崭新之日', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (62, '2026-05-23 07:58:35.572622', '37', '蜘蛛侠：英雄无归', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (63, '2026-05-23 08:32:54.830001', '13', '惊悚', 1, '[{\"added\": {}}]', 8, 1);
INSERT INTO `django_admin_log` VALUES (64, '2026-05-23 08:33:24.052978', '7', '死寂', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (65, '2026-05-23 08:34:59.432926', '49', '大白鲨', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (66, '2026-05-23 16:02:43.061826', '20', '鬼灭之刃 第一章 猗窝座再袭', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (67, '2026-05-23 16:05:02.802163', '1', '战狼', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (68, '2026-05-23 16:08:22.283827', '24', '闪灵', 2, '[{\"changed\": {\"fields\": [\"Categories\"]}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (69, '2026-05-23 16:12:37.421116', '24', 'C79A715ED5324C5CAB01 - user2', 3, '', 12, 1);
INSERT INTO `django_admin_log` VALUES (70, '2026-05-23 16:30:24.819759', '50', '误杀', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (71, '2026-05-23 16:32:09.468036', '51', '消失的她', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (72, '2026-05-23 16:34:41.697627', '52', '满江红', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (73, '2026-05-23 16:35:54.989404', '53', '你好，李焕英', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (74, '2026-05-23 16:37:10.269429', '54', '少年的你', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (75, '2026-05-23 16:38:24.665043', '55', '人生大事', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (76, '2026-05-23 16:39:57.982969', '56', '咒', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (77, '2026-05-23 16:41:25.643523', '57', '哭声', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (78, '2026-05-23 16:42:37.639276', '58', '昆池岩', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (79, '2026-05-23 16:44:28.424385', '59', '红海行动', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (80, '2026-05-23 16:45:45.544402', '60', '八佰', 1, '[{\"added\": {}}]', 9, 1);
INSERT INTO `django_admin_log` VALUES (81, '2026-05-23 16:47:39.153503', '61', '金刚川', 1, '[{\"added\": {}}]', 9, 1);

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `django_content_type_app_label_model_76bd3d3b_uniq`(`app_label`, `model`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (5, 'sessions', 'session');
INSERT INTO `django_content_type` VALUES (6, 'users', 'user');
INSERT INTO `django_content_type` VALUES (7, 'movies', 'actor');
INSERT INTO `django_content_type` VALUES (8, 'movies', 'category');
INSERT INTO `django_content_type` VALUES (9, 'movies', 'movie');
INSERT INTO `django_content_type` VALUES (10, 'movies', 'hall');
INSERT INTO `django_content_type` VALUES (11, 'movies', 'session');
INSERT INTO `django_content_type` VALUES (12, 'orders', 'order');
INSERT INTO `django_content_type` VALUES (13, 'movies', 'cinema');
INSERT INTO `django_content_type` VALUES (14, 'movies', 'wantrecord');
INSERT INTO `django_content_type` VALUES (15, 'movies', 'browsehistory');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 32 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2026-05-19 14:10:26.610308');
INSERT INTO `django_migrations` VALUES (2, 'contenttypes', '0002_remove_content_type_name', '2026-05-19 14:10:26.645018');
INSERT INTO `django_migrations` VALUES (3, 'auth', '0001_initial', '2026-05-19 14:10:26.757750');
INSERT INTO `django_migrations` VALUES (4, 'auth', '0002_alter_permission_name_max_length', '2026-05-19 14:10:26.771514');
INSERT INTO `django_migrations` VALUES (5, 'auth', '0003_alter_user_email_max_length', '2026-05-19 14:10:26.774933');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0004_alter_user_username_opts', '2026-05-19 14:10:26.777950');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0005_alter_user_last_login_null', '2026-05-19 14:10:26.794589');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0006_require_contenttypes_0002', '2026-05-19 14:10:26.796014');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0007_alter_validators_add_error_messages', '2026-05-19 14:10:26.798984');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0008_alter_user_username_max_length', '2026-05-19 14:10:26.802672');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0009_alter_user_last_name_max_length', '2026-05-19 14:10:26.805776');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0010_alter_group_name_max_length', '2026-05-19 14:10:26.823933');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0011_update_proxy_permissions', '2026-05-19 14:10:26.827877');
INSERT INTO `django_migrations` VALUES (14, 'auth', '0012_alter_user_first_name_max_length', '2026-05-19 14:10:26.831250');
INSERT INTO `django_migrations` VALUES (15, 'users', '0001_initial', '2026-05-19 14:10:26.960714');
INSERT INTO `django_migrations` VALUES (16, 'admin', '0001_initial', '2026-05-19 14:10:27.026780');
INSERT INTO `django_migrations` VALUES (17, 'admin', '0002_logentry_remove_auto_add', '2026-05-19 14:10:27.031200');
INSERT INTO `django_migrations` VALUES (18, 'admin', '0003_logentry_add_action_flag_choices', '2026-05-19 14:10:27.035575');
INSERT INTO `django_migrations` VALUES (19, 'sessions', '0001_initial', '2026-05-19 14:10:27.089925');
INSERT INTO `django_migrations` VALUES (20, 'movies', '0001_initial', '2026-05-19 15:44:07.529908');
INSERT INTO `django_migrations` VALUES (21, 'movies', '0002_hall_session', '2026-05-20 10:39:57.977880');
INSERT INTO `django_migrations` VALUES (22, 'orders', '0001_initial', '2026-05-20 10:57:03.820314');
INSERT INTO `django_migrations` VALUES (23, 'movies', '0003_cinema_remove_hall_name_hall_cinema', '2026-05-20 15:01:10.322739');
INSERT INTO `django_migrations` VALUES (24, 'movies', '0004_hall_name', '2026-05-20 15:40:21.140022');
INSERT INTO `django_migrations` VALUES (25, 'movies', '0005_remove_movie_actors_movie_country_movie_language', '2026-05-20 16:15:35.431256');
INSERT INTO `django_migrations` VALUES (26, 'movies', '0006_category_to_manytomany', '2026-05-21 15:28:20.846808');
INSERT INTO `django_migrations` VALUES (27, 'movies', '0007_remove_actor', '2026-05-21 15:35:36.669095');
INSERT INTO `django_migrations` VALUES (28, 'users', '0002_add_want_to_see', '2026-05-23 08:29:01.403202');
INSERT INTO `django_migrations` VALUES (29, 'movies', '0008_want_record_browse_history', '2026-05-23 09:03:06.261333');
INSERT INTO `django_migrations` VALUES (30, 'users', '0003_remove_want_m2m', '2026-05-23 09:04:08.220318');
INSERT INTO `django_migrations` VALUES (31, 'users', '0004_add_want_through', '2026-05-23 09:04:08.224432');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session`  (
  `session_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`) USING BTREE,
  INDEX `django_session_expire_date_a5c62663`(`expire_date`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('5yyc4znq9fzi5scx3bnknp1y5zjxkaqu', '.eJxVjEEOwiAQRe_C2pBCGRCX7j0DYYZBqgaS0q6Md7dNutDtf-_9twhxXUpYO89hSuIilDj9bhjpyXUH6RHrvUlqdZknlLsiD9rlrSV-XQ_376DEXrZasx8RNCdnkzkb8Co6sI68hhGiZY8JPbFD2iCZAYDY5ozGZDOMTonPF9nKN7w:1wPjP8:nJ7DNEpuWgX76MUO5kmqvg1S0pCb0RQ-ajSpz6po4MI', '2026-06-03 16:04:18.967816');

-- ----------------------------
-- Table structure for movies_browsehistory
-- ----------------------------
DROP TABLE IF EXISTS `movies_browsehistory`;
CREATE TABLE `movies_browsehistory`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movies_browsehistory_movie_id_eff2c0be`(`movie_id`) USING BTREE,
  INDEX `movies_browsehistory_user_id_e1e27aa0`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of movies_browsehistory
-- ----------------------------
INSERT INTO `movies_browsehistory` VALUES (1, '2026-05-23 15:27:14.278063', 1, 1);
INSERT INTO `movies_browsehistory` VALUES (2, '2026-05-23 15:37:28.052913', 2, 1);
INSERT INTO `movies_browsehistory` VALUES (3, '2026-05-23 15:37:31.766993', 23, 1);
INSERT INTO `movies_browsehistory` VALUES (4, '2026-05-23 15:37:38.907573', 23, 1);
INSERT INTO `movies_browsehistory` VALUES (5, '2026-05-23 15:37:47.427206', 26, 1);
INSERT INTO `movies_browsehistory` VALUES (6, '2026-05-23 15:37:56.196214', 26, 1);
INSERT INTO `movies_browsehistory` VALUES (7, '2026-05-23 15:40:25.550405', 16, 1);
INSERT INTO `movies_browsehistory` VALUES (8, '2026-05-23 15:48:47.430029', 4, 1);
INSERT INTO `movies_browsehistory` VALUES (9, '2026-05-23 16:06:22.717102', 7, 9);
INSERT INTO `movies_browsehistory` VALUES (10, '2026-05-23 16:08:04.354547', 7, 9);
INSERT INTO `movies_browsehistory` VALUES (11, '2026-05-23 16:08:08.252398', 24, 9);
INSERT INTO `movies_browsehistory` VALUES (12, '2026-05-23 16:08:29.283406', 24, 9);
INSERT INTO `movies_browsehistory` VALUES (13, '2026-05-23 16:50:58.039507', 57, 9);
INSERT INTO `movies_browsehistory` VALUES (14, '2026-05-23 16:52:47.376463', 7, 9);
INSERT INTO `movies_browsehistory` VALUES (15, '2026-06-23 13:51:28.971679', 59, 8);
INSERT INTO `movies_browsehistory` VALUES (16, '2026-06-23 13:51:31.672002', 31, 8);
INSERT INTO `movies_browsehistory` VALUES (17, '2026-06-23 13:51:34.089357', 61, 8);
INSERT INTO `movies_browsehistory` VALUES (18, '2026-06-23 13:57:41.663989', 6, 8);
INSERT INTO `movies_browsehistory` VALUES (19, '2026-06-23 13:57:43.677697', 6, 8);
INSERT INTO `movies_browsehistory` VALUES (20, '2026-06-23 13:57:46.225986', 6, 8);
INSERT INTO `movies_browsehistory` VALUES (21, '2026-06-23 13:58:06.484037', 60, 8);
INSERT INTO `movies_browsehistory` VALUES (22, '2026-06-23 14:02:01.356561', 29, 8);
INSERT INTO `movies_browsehistory` VALUES (23, '2026-06-23 14:02:05.750284', 35, 8);
INSERT INTO `movies_browsehistory` VALUES (24, '2026-06-23 14:02:12.061428', 35, 8);
INSERT INTO `movies_browsehistory` VALUES (25, '2026-06-23 14:02:13.840195', 12, 8);

-- ----------------------------
-- Table structure for movies_category
-- ----------------------------
DROP TABLE IF EXISTS `movies_category`;
CREATE TABLE `movies_category`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movies_category
-- ----------------------------
INSERT INTO `movies_category` VALUES (1, '爱情');
INSERT INTO `movies_category` VALUES (2, '动作');
INSERT INTO `movies_category` VALUES (3, '科幻');
INSERT INTO `movies_category` VALUES (4, '剧情');
INSERT INTO `movies_category` VALUES (5, '动画');
INSERT INTO `movies_category` VALUES (6, '犯罪');
INSERT INTO `movies_category` VALUES (7, '悬疑');
INSERT INTO `movies_category` VALUES (8, '恐怖');
INSERT INTO `movies_category` VALUES (9, '喜剧');
INSERT INTO `movies_category` VALUES (10, '冒险');
INSERT INTO `movies_category` VALUES (11, '历史');
INSERT INTO `movies_category` VALUES (12, '战争');
INSERT INTO `movies_category` VALUES (13, '惊悚');

-- ----------------------------
-- Table structure for movies_cinema
-- ----------------------------
DROP TABLE IF EXISTS `movies_cinema`;
CREATE TABLE `movies_cinema`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movies_cinema
-- ----------------------------
INSERT INTO `movies_cinema` VALUES (4, '万达影城·五角场店', '上海', '021-65758888');
INSERT INTO `movies_cinema` VALUES (3, 'CGV影城·国贸店', '北京', '010-85628888');
INSERT INTO `movies_cinema` VALUES (5, '大地影院·珠江新城店', '广州', '020-38268888');
INSERT INTO `movies_cinema` VALUES (6, '博纳影城·观澜湖店', '深圳', '0755-28889999');
INSERT INTO `movies_cinema` VALUES (7, '横店影视城·星光店', '广州', '028-86698888');
INSERT INTO `movies_cinema` VALUES (14, '万达影城', '市中心商业广场5楼', '010-88880001');
INSERT INTO `movies_cinema` VALUES (15, 'CGV星聚汇', '万象城购物中心4楼', '010-88880002');
INSERT INTO `movies_cinema` VALUES (16, '博纳国际影城', '科技园路128号', '010-88880003');

-- ----------------------------
-- Table structure for movies_hall
-- ----------------------------
DROP TABLE IF EXISTS `movies_hall`;
CREATE TABLE `movies_hall`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `capacity` int(11) NOT NULL,
  `description` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cinema_id` bigint(20) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movies_hall_cinema_id_7f80fd82`(`cinema_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movies_hall
-- ----------------------------
INSERT INTO `movies_hall` VALUES (10, 100, NULL, 3, '一号厅');
INSERT INTO `movies_hall` VALUES (8, 50, '', 4, 'IMAX厅');
INSERT INTO `movies_hall` VALUES (11, 100, NULL, 4, '一号厅');
INSERT INTO `movies_hall` VALUES (15, 120, '', 14, '1号厅');
INSERT INTO `movies_hall` VALUES (16, 150, '', 15, '2号厅');
INSERT INTO `movies_hall` VALUES (17, 100, '', 15, '3号厅');
INSERT INTO `movies_hall` VALUES (18, 80, '', 16, '4号厅');
INSERT INTO `movies_hall` VALUES (19, 150, '', 16, '5号厅');
INSERT INTO `movies_hall` VALUES (20, 200, '', 16, 'IMAX厅');
INSERT INTO `movies_hall` VALUES (21, 40, '', 15, 'VIP厅');
INSERT INTO `movies_hall` VALUES (22, 150, '', 16, '杜比全景声厅');
INSERT INTO `movies_hall` VALUES (23, 120, '', 14, '2号厅');
INSERT INTO `movies_hall` VALUES (24, 100, '', 14, '3号厅');
INSERT INTO `movies_hall` VALUES (25, 200, '', 15, 'IMAX厅');
INSERT INTO `movies_hall` VALUES (26, 40, '', 16, 'VIP厅');
INSERT INTO `movies_hall` VALUES (27, 80, '', 14, '杜比全景声厅');

-- ----------------------------
-- Table structure for movies_movie
-- ----------------------------
DROP TABLE IF EXISTS `movies_movie`;
CREATE TABLE `movies_movie`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `poster` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `score` double NOT NULL,
  `duration` int(11) NOT NULL,
  `release_time` date NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_time` datetime(6) NOT NULL,
  `country` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movies_movie
-- ----------------------------
INSERT INTO `movies_movie` VALUES (1, '战狼', '在南疆围捕贩毒分子的行动中，特种部队狙击手冷锋（吴京 饰）公然违抗上级的命令，开枪射杀伤害了战友的暴徒武吉（周晓鸥 饰）。这一行动令冷锋遭到军方禁闭甚至强制退伍的处罚，不过各特种部队精英组成超级特种部队战狼中队的中队长龙小云（余男 饰），却十分欣赏这个敢作敢为且业务过硬的血性男儿，于是将其召入自己的麾下。在新近的一次演习中，冷锋凭借冷静的判断力从老首长处拔得一城，并且成功击退了突然出现的狼群。谁知在毫无准备的情况下，战狼遭到了一伙荷枪实弹分子的袭击。原来武吉的哥哥敏登（倪大红 饰）是一个冷酷无情的国际通缉犯，他手下豢养了一大批身怀绝技的雇佣兵。', 'movies/p2225660666.webp', 9.1, 120, '2026-05-19', 'hot', '2026-05-19 16:32:12.722884', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (2, '大鱼海棠', '所有活着的人类，都是海里一条巨大的鱼；出生的时候他们从海的此岸出发。他们的生命就像横越大海，有时相遇，有时分开……死的时候，他们便到了岸，各去各的世界。\r\n　　四十五亿年前，这个星球上，只有一片汪洋大海，和一群古老的大鱼。在与人类世界平行的空间里，生活着一个规规矩矩、遵守秩序的族群，他们为神工作，掌管世界万物运行规律，也掌管人类的灵魂。他们的天空与人类世界的大海相连。他们既不是神，也不是人，他们是“其他人”。\r\n　　十六岁生日那天，居住在“神之围楼”里的一个名叫椿（季冠霖 配音）的女孩变作一条海豚到人间巡礼，被大海中的一张网困住，一个人类男孩因为救她而落入深海死去。为了报恩，为了让人类男孩复活，她需要在自己的世界里，历经种种困难与阻碍，帮助死后男孩的灵魂——一条拇指那么大的小鱼，成长为一条比鲸更巨大的鱼并回归大海。', 'movies/p2361411967.webp', 8, 124, '2016-07-08', 'hot', '2026-05-20 13:31:20.135586', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (3, '楚门的世界', '楚门（金•凯瑞 Jim Carrey 饰）是一个平凡得不能再平凡的人，除了一些有些稀奇的经历之外——初恋女友突然失踪、溺水身亡的父亲忽然似乎又出现在眼前，他和绝大多数30多岁的美国男人绝无异样。这令他倍感失落。他也曾试过离开自己生活了多年的地方，但总因种种理由而不能成行。\r\n　　直到有一天，他忽然发觉自己似乎一直在被人跟踪，无论他走到哪里，干什么事情。这种感觉愈来愈强烈。楚门决定不惜一切代价逃离这个他生活了30多年的地方，去寻找他的初恋女友。\r\n　　但他却发现自己怎样也逃不出去。真相其实很残忍。', 'movies/p479682972.webp', 9.7, 103, '1998-06-05', 'offline', '2026-05-21 15:02:08.251887', '美国', '英语');
INSERT INTO `movies_movie` VALUES (4, '奶龙搞怪大作战2', '这次奶龙与小七不仅要解决日常难题，还要遇见迷路的麋鹿哥、脚滑的狐狸妹、爱做甜品的小羊…还有神秘外星人出没？', 'movies/p2929356332.webp', 7.9, 102, '2026-01-28', 'coming', '2026-05-21 16:06:53.707563', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (5, '泰坦尼克号', '1912年4月10日，号称 “世界工业史上的奇迹”的豪华客轮泰坦尼克号开始了它完工后的首次商业航行，从英国的南安普顿出发驶往美国纽约。富家少女罗丝（凯特·温丝莱特）与母亲及未婚夫卡尔坐上了头等舱；另一边，放荡不羁的少年画家杰克（莱昂纳多·迪卡普里奥）也在码头的一场赌博中 赢得了下等舱的船票。\r\n　　罗丝厌倦了上流社会虚伪的生活，不愿嫁给卡尔，打算投海自尽，被杰克救起。很快，美丽活泼的罗丝与英俊开朗的杰克相爱，杰克带罗丝参加下等舱的舞会、为她画像，二人的感情逐渐升温。\r\n　　1912年4月14日，星期天晚上，一个风平浪静的夜晚。泰坦尼克号撞上了冰山，“永不沉没的”泰坦尼克号面临沉船的命运，罗丝和杰克刚萌芽的爱情也将经历生死的考验。', 'movies/p457760035.webp', 9.5, 194, '1998-04-03', 'offline', '2026-05-21 16:08:10.695436', '美国', '英语 / 意大利语 / 德语 / 俄语');
INSERT INTO `movies_movie` VALUES (6, '肖申克的救赎', '一场谋杀案使银行家安迪（蒂姆•罗宾斯 Tim Robbins 饰）蒙冤入狱，谋杀妻子及其情人的指控将囚禁他终生。在肖申克监狱的首次现身就让监狱“大哥”瑞德（摩根•弗里曼 Morgan Freeman 饰）对他另眼相看。瑞德帮助他搞到一把石锤和一幅女明星海报，两人渐成患难 之交。很快，安迪在监狱里大显其才，担当监狱图书管理员，并利用自己的金融知识帮助监狱官避税，引起了典狱长的注意，被招致麾下帮助典狱长洗黑钱。偶然一次，他得知一名新入狱的小偷能够作证帮他洗脱谋杀罪。燃起一丝希望的安迪找到了典狱长，希望他能帮自己翻案。阴险伪善的狱长假装答应安迪，背后却派人杀死小偷，让他唯一能合法出狱的希望泯灭。沮丧的安迪并没有绝望，在一个电闪雷鸣的风雨夜，一场暗藏几十年的越狱计划让他自我救赎，重获自由！老朋友瑞德在他的鼓舞和帮助下，也勇敢地奔向自由。', 'movies/p480747492.webp', 9.7, 142, '1994-09-10', 'hot', '2026-05-21 16:09:38.158229', '美国', '英语');
INSERT INTO `movies_movie` VALUES (7, '死寂', '童谣本应该充满欢声笑语，但世界上偏偏有这么一些童谣，让人听了毛骨悚然。小镇拉文斯•法尔就流传着这样一个恐怖的童谣：小心来自玛丽•肖的凝视；她没有孩子，只有玩偶；如果你看到她，不要尖叫；否则她会扯开你的嘴巴撕掉你的舌头。这个小镇一直就在笼罩在这个童谣的诅咒之下，只要有玩偶出现的地方，就有人遇害，死状一样，都是舌头被割下。\r\n　　吉米（瑞恩•科万顿 Ryan Kwanten 饰）和萨丽新婚不久，就决定搬离这个受诅咒的地方，但最终萨丽还是没有逃脱这个诅咒。悲伤不已的吉米决定送妻子的尸骸返回家乡，并着手调查这个笼罩在整个小镇头上的恐怖诅咒。随着调查的深入，吉米发现了这首童谣背后的另一个真相。', 'movies/p1235830609.webp', 7.9, 89, '2007-03-16', 'hot', '2026-05-21 16:12:24.837583', '美国', '英语');
INSERT INTO `movies_movie` VALUES (8, '蝙蝠侠：黑暗骑士', '从亲眼目睹父母被人杀死的阴影中走出来的“蝙蝠侠”，经历了成长之后，已经不再是那个桀骜不的孤单英雄了。在警官吉姆·戈登和检查官哈维·登特的通力帮助下，“蝙蝠侠”无后顾之忧地继续满世界的奔波，与日益增长起来的犯罪威胁做着永无休止的争斗，而他所在的高谭市，也是进展最为明显的地方，犯罪率以一种惊人的速度持续下降着，毕竟对方是能够上天入地的“蝙蝠侠”，不借两个胆子谁还敢造次呢？不过像高谭这种科技与污秽并存的城市，平静是不可能维持太久的，果不其然，新一轮的混乱很快就席卷了整个城市，人们再一被被恐慌所笼罩着，而声称愿意为这一切负责的，自然就是所有混乱的源头以及支配者--“小丑”了。\r\n　　先不管“小丑”掀起一个又一个犯罪的狂潮的最终目的为何，他的企图都是邪恶的，所作所为更是早就危害到了高谭市民的正常生活……其中自然包括了“蝙蝠侠”身边几个非常重要的人，而他需要做的，就是将这股新的危机全部亲自用手捏得粉碎。然而在面对着这个有史以来最具针对性、最恶毒的对手时，“蝙蝠侠”却不得不从他的地下军械库里搬出每一件能够用得上的高科技武器，还得时刻纠结着为他曾经信仰的一切寻找答案。', 'movies/p1659305038.webp', 9.2, 152, '2008-07-14', 'hot', '2026-05-21 16:14:20.432581', '美国 / 英国', '英语 / 意大利语 / 德语 / 俄语');
INSERT INTO `movies_movie` VALUES (9, '功夫', '1940年代的上海，自小受尽欺辱的街头混混阿星（周星驰）为了能出人头地，可谓窥见机会的缝隙就往里钻，今次他盯上行动日益猖獗的黑道势力“斧头帮”，想借之大名成就大业。\r\n　　阿星假冒“斧头帮”成员试图在一个叫“猪笼城寨”的地方对居民敲诈，不想引来真的“斧头帮”与“猪笼城寨”居民的恩怨。“猪笼城寨”原是藏龙卧虎之处，居民中有许多身怀绝技者（元华、梁小龙等），他们隐藏于此本是为远离江湖恩怨，不想麻烦自动上身，躲都躲不及。而在观战正邪两派的斗争中，阿星逐渐领悟功夫的真谛。', 'movies/p2170788277.webp', 8.9, 100, '2004-12-23', 'hot', '2026-05-21 16:16:06.097042', '中国大陆 / 中国香港', '汉语普通话 / 粤语');
INSERT INTO `movies_movie` VALUES (10, '哆啦A梦：大雄的新恐龙', '阳光明媚的日子里，大雄、静香、胖虎和小夫一起去参加恐龙博物展。由于被胖虎和小夫嘲笑，大雄情急之下又再次胡说八道，发誓要找到真正的恐龙给他们看。在儿童考古体验现场，大雄找到一枚蛋状石头，于是他将其当作恐龙蛋化石，宝贝一样带回家中，拜托哆啦A梦用时间包袱皮孵化。令人意想不到的是，经过一天一夜孵化，那枚彩色蛋中居然真的钻出两只从没见过的小恐龙。这两只被命名为小咪和小啾的小家伙给大雄带来无限乐趣，可是在现代社会养恐龙又怎会是一件容易的事。万般无奈之下，好朋友们结伴坐上时光机，把小恐龙们带回白垩纪时代，而他们的大冒险就此展开……\r\n　　本片是《哆啦A梦》漫画连载50周年纪念作品，同时也是《哆啦A梦》系列电影的第40部作品。', 'movies/p2519543937.webp', 7.1, 110, '2020-12-11', 'hot', '2026-05-21 16:18:56.606838', '日本', '日语');
INSERT INTO `movies_movie` VALUES (11, '阿凡达', '战斗中负伤而下身瘫痪的前海军战士杰克·萨利（萨姆·沃辛顿 Sam Worthington 饰）决定替死去的同胞哥哥来到潘多拉星操纵格蕾丝博士（西格妮·韦弗 Sigourney Weaver 饰）用人类基因与当地纳美部族基因结合创造出的 “阿凡达” 混血生物。杰克的目的是打入纳美部落，外交说服他们自愿离开世代居住的家园，从而SecFor公司可砍伐殆尽该地区的原始森林，开采地下昂贵的“不可得”矿。在探索潘多拉星的过程中，杰克遇到了纳美部落的公主娜蒂瑞（佐伊·索尔达娜 Zoe Saldana 饰），向她学习了纳美人的生存技能与对待自然的态度。与此同时，SecFor公司的经理和军方代表上校迈尔斯（史蒂芬·朗 Stephen Lang 饰）逐渐丧失耐心，决定诉诸武力驱赶纳美人……\r\n　　本片采用3D技术拍摄，共耗资5亿美元制作发行，是电影史上最为昂贵的作品。本片荣获第82届奥斯卡最佳摄影、最佳视觉效果、最佳艺术指导等3项大奖。', 'movies/p2573226643.webp', 8.8, 162, '2010-01-04', 'offline', '2026-05-21 16:20:24.111383', '美国', '英语 / 西班牙语');
INSERT INTO `movies_movie` VALUES (12, '阿凡达：水之道', '影片设定在《阿凡达》的剧情落幕十余年后，讲述了萨利一家（杰克、奈蒂莉和孩子们）的故事：危机未曾消散，一家人拼尽全力彼此守护、奋力求生，并历经艰险磨难。\r\n　　杰克和奈蒂莉组建了家庭，他们的孩子也逐渐成长，为这个家庭带来了许多欢乐。然而危机未曾消散，萨利一家拼尽全力彼此守护、奋力求生，最终来到潘多拉星球临海的岛礁族寻求庇护。岛礁族首领特诺瓦里与罗娜尔为萨利一家提供了庇护所，这个部族的成员都是天生的潜水好手，也和海洋中的各种生物建立了密切联系。', 'movies/p2884182275.webp', 7.8, 192, '2022-12-16', 'hot', '2026-05-21 16:21:07.700704', '美国', '英语');
INSERT INTO `movies_movie` VALUES (13, '阿凡达：火与烬', '影片聚焦杰克·萨利与奈蒂莉一家的命运起伏，在前作的情感余波之上，深刻描绘一个家族在战火中如何成长、并共同守护血脉相连的情感纽带的历程，从而将故事推向更具张力的全新维度。此外，潘多拉的全新领域也即将揭晓——观众将首次邂逅“风之商人”这个崇尚和平的全新游牧民族，他们乘坐独特的浮空生物飞船穿梭于各部落间，交易货物、传递信息。\r\n　　而更具颠覆性的是“灰烬族”的登场，这个以掠夺为生、性情凶猛的族群，与大地之母爱娃之间有着深刻的矛盾。他们的出现，将撕开潘多拉不为人知的黑暗传说。当弑亲之仇与部落恩怨交织，潘多拉的命运悬于一线——在这场跨文明的复仇之战中，人类与纳威族将如何抉择，才能真正守护各自的家园与未来？', 'movies/p2925983114.webp', 7.6, 198, '2025-12-19', 'hot', '2026-05-21 16:22:06.525310', '美国', '英语');
INSERT INTO `movies_movie` VALUES (14, '霸王别姬', '段小楼（张丰毅）与程蝶衣（张国荣）是一对打小一起长大的师兄弟，两人一个演生，一个饰旦，一向配合天衣无缝，尤其一出《霸王别姬》，更是誉满京城，为此，两人约定合演一辈子《霸王别姬》。但两人对戏剧与人生关系的理解有本质不同，段小楼深知戏非人生，程蝶衣则是人戏不分。\r\n　　段小楼在认为该成家立业之时迎娶了名妓菊仙（巩俐），致使程蝶衣认定菊仙是可耻的第三者，使段小楼做了叛徒，自此，三人围绕一出《霸王别姬》生出的爱恨情仇战开始随着时代风云的变迁不断升级，终酿成悲剧。', 'movies/p2585897495.webp', 9.6, 171, '1993-07-26', 'offline', '2026-05-21 16:23:05.871260', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (15, '天书奇谭', '天庭有珍奇书籍“天书”，被锁在石龛门里三千年。看守天书的袁公对天书的内容好奇不已，他乘无人之际，偷偷拿出观看。原来，天书上记录了一百〇八条法术，袁公偷偷下凡，把天书上的内容刻在石壁上。但本意造福人类的袁公此举却触犯了天条，遭到了玉帝的惩罚。\r\n　　炼丹炉里的仙丹不慎被三条狐狸偷吃了，她们变成精下凡骗人钱财，还假扮仙姑和官府勾结，欺压百姓，祸害人间。袁公便指引天赋异禀的蛋生——一个从蛋里跳出来的孩子修习天书上的法术，和狐狸精斗智斗勇，为民除害。', 'movies/p2717808941.webp', 9.2, 89, '2021-11-05', 'hot', '2026-05-21 16:26:55.370772', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (16, '你的名字', '在远离大都会的小山村，住着巫女世家出身的高中女孩宫水三叶（上白石萌音 配音）。校园和家庭的原因本就让她充满烦恼，而近一段时间发生的奇怪事件，又让三叶摸不清头脑。不知从何时起，三叶在梦中就会变成一个住在东京的高中男孩。那里有陌生的同学和朋友，有亲切的前辈和繁华的街道，一切都是如此诱人而真实。另一方面，住在东京的高中男孩立花泷（神木隆之介 配音）则总在梦里来到陌生的小山村，以女孩子的身份过着全新的生活。许是受那颗神秘彗星的影响，立花和三叶在梦中交换了身份。他们以他者的角度体验着对方的人生，这期间有愤怒、有欢笑也有暖心。只是两人并不知道，身份交换的背后隐藏着重大而锥心的秘密……', 'movies/p2890285200.webp', 8.5, 106, '2016-12-02', 'offline', '2026-05-21 16:27:58.527541', '日本', '日语');
INSERT INTO `movies_movie` VALUES (17, '流浪地球', '近未来，科学家们发现太阳急速衰老膨胀，短时间内包括地球在内的整个太阳系都将被太阳所吞没。为了自救，人类提出一个名为“流浪地球”的大胆计划，即倾全球之力在地球表面建造上万座发动机和转向发动机，推动地球离开太阳系，用2500年的时间奔往另外一个栖息之地。中国航天员刘培强（吴京 饰）在儿子刘启四岁那年前往国际空间站，和国际同侪肩负起领航者的重任。转眼刘启（屈楚萧 饰）长大，他带着妹妹朵朵（赵今麦 饰）偷偷跑到地表，偷开外公韩子昂（吴孟达 饰）的运输车，结果不仅遭到逮捕，还遭遇了全球发动机停摆的事件。为了修好发动机，阻止地球坠入木星，全球开始展开饱和式营救，连刘启他们的车也被强征加入。在与时间赛跑的过程中，无数的人前仆后继，奋不顾身，只为延续百代子孙生存的希望……', 'movies/p2545472803.webp', 8, 125, '2019-02-05', 'offline', '2026-05-21 16:29:46.030518', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (18, '流浪地球2', '在并不遥远的未来，太阳急速衰老与膨胀，再过几百年整个太阳系将被它吞噬毁灭。为了应对这场史无前例的危机，地球各国放下芥蒂，成立联合政府，试图寻找人类存续的出路。通过摸索与考量，最终推着地球逃出太阳系的“移山计划”获得压倒性胜利。人们着手建造上万台巨大的行星发动机，带着地球踏上漫漫征程。满腔赤诚的刘培强（吴京 饰）和韩朵朵（王智 饰）历经层层考验成为航天员大队的一员，并由此相知相恋。但是漫漫征途的前方，仿佛有一股神秘的力量不断破坏者人类的自救计划。看似渺小的刘培强、量子科学家图恒宇（刘德华 饰）、联合政府中国代表周喆直（李雪健 饰）以及无数平凡的地球人，构成了这项伟大计划的重要一环……', 'movies/p2885955777.webp', 8.3, 173, '2023-01-22', 'hot', '2026-05-21 16:30:52.200798', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (51, '消失的她', '东南亚某国，年轻男子何非（朱一龙 饰）疯狂寻找失踪的妻子李木子，然而当地警局视若罔闻，令他出离愤怒。可就在某个清晨，何非突然发现身边躺着一名陌生女子，更令他毛骨悚然的是，女子居然声称是他的妻子李木子（文咏珊 饰）。慌乱之余，何找来华人警察郑成（杜江 饰），试图揭穿假冒者的骗局，谁知种种迹象表明，对面的陌生人真实不虚。隐隐之中，何非认为妻子被犯罪团伙绑架，他只得求助干练的金牌律师陈麦（倪妮 饰）追索真相。在调查中过程中，细微线索逐渐浮出水面，而更加黑暗的真相也开始暴露在阳光之下', 'movies/p2887544444.webp', 6.2, 121, '2023-06-22', 'hot', '2026-05-23 16:32:09.465045', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (20, '鬼灭之刃 第一章 猗窝座再袭', '为了让变成鬼的妹妹祢豆子重新变回人类，灶门炭治郎加入了猎鬼组织“鬼杀队”，与同伴我妻善逸、嘴平伊之助一同对抗各类恶鬼，在成长的过程中彼此间的友情与羁绊也日益加深。此后，炭治郎与“鬼杀队”中最高级别的剑士“柱”们数次并肩作战。为备战即将到来的决战，炭治郎正与队员们一同挑战由“柱”们主持的联合强化训练时，鬼舞辻无惨突然现身于产屋敷宅邸。炭治郎与众“柱”虽为解救身处危机的主公大人而火速赶到，却遭无惨之手打入了一个神秘空间。炭治郎等人坠落之处，正是鬼的大本营“无限城”——“鬼杀队”与“鬼”的决战，就此拉开序幕。', 'movies/p2922908971.webp', 8.5, 155, '2025-07-18', 'hot', '2026-05-21 16:33:37.805896', '日本', '日语');
INSERT INTO `movies_movie` VALUES (21, '这个杀手不太冷', '里昂（让·雷诺饰）是名孤独的职业杀手，受人雇佣。一天，邻居家小姑娘马蒂尔达（纳塔丽·波特曼饰)敲开他的房门，要求在他那里暂避杀身之祸。原来邻居家的主人是警方缉毒组的眼线，只因贪污了一小包毒品而遭恶警（加里·奥德曼饰）杀害全家的惩罚。马蒂尔达得到里昂的留救，幸免于难，并留在里昂那里。里昂教小女孩使枪，她教里昂法文，两人关系日趋亲密，相处融洽。\r\n　　女孩想着去报仇，反倒被抓，里昂及时赶到，将女孩救回。混杂着哀怨情仇的正邪之战渐次升级，更大的冲突在所难免……', 'movies/p2913554676.webp', 9.4, 133, '2024-11-01', 'hot', '2026-05-21 16:35:56.619153', '美国', '英语 / 意大利语 / 德语 / 俄语');
INSERT INTO `movies_movie` VALUES (22, '哪吒', '天地灵气孕育出一颗能量巨大的混元珠，元始天尊将混元珠提炼成灵珠和魔丸，灵珠投胎为人，助周伐纣时可堪大用；而魔丸则会诞出魔王，为祸人间。元始天尊启动了天劫咒语，3年后天雷将会降临，摧毁魔丸。太乙受命将灵珠托生于陈塘关李靖家的儿子哪吒身上。然而阴差阳错，灵珠和魔丸竟然被掉包。本应是灵珠英雄的哪吒却成了混世大魔王。调皮捣蛋顽劣不堪的哪吒却徒有一颗做英雄的心。然而面对众人对魔丸的误解和即将来临的天雷的降临，哪吒是否命中注定会立地成魔？他将何去何从？', 'movies/p2563780504.webp', 0, 110, '2019-07-26', 'coming', '2026-05-21 16:37:34.095087', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (23, '哪吒之魔童闹海', '天劫之后，哪吒、敖丙的灵魂虽保住了，但肉身很快会魂飞魄散。太乙真人打算用七色宝莲给二人重塑肉身。但是在重塑肉身的过程中却遇到重重困难，哪吒、敖丙的命运将走向何方？', 'movies/p2916323189.webp', 8.4, 144, '2025-01-29', 'hot', '2026-05-21 16:38:49.698518', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (24, '闪灵', '杰克（杰克·尼科尔森 Jack Nicholson 饰）是一个作家。一个冬天，他得到了一个看管山顶酒店的差事。这正合杰克的意思，他正好可以有一个幽静的地方写作。于是杰克带着妻儿搬进了酒店。\r\n　　冬天大雪封路，山顶酒店只有杰克一家三口。从他们一搬进来，杰克的妻子温蒂（谢莉·杜 瓦尔 Shelley Duvall 饰）就发现这里气氛诡异，杰克的儿子丹尼（丹尼·劳埃德 Danny Lloyd 饰）经常看到一些他不认识的人，但这里除了他们一家别无他人。而杰克除了一整天闷头写作外，脾气亦变得越来越古怪。\r\n　　直到有一天，温蒂发现丈夫这些天来一直写就只有一句话：杰克发疯了！', 'movies/p2928985187.webp', 8.3, 119, '2026-01-30', 'hot', '2026-05-21 16:40:09.933422', '美国', '英语');
INSERT INTO `movies_movie` VALUES (25, '玩具总动员5', '本部续作中，胡迪、巴斯光年、翠斯等“元老级”玩具将跟随小主人邦妮的成长脚步，共同迎接数字时代下的全新挑战。随着无所不能的科技产品逐渐走进童年世界，一批充满科技感的崭新角色也随之重磅亮相：青蛙造型的智能平板小荷、憨态可掬的导航玩具小不丢、活力十足的抓拍好手小拍侠，以及自带笑点的臭屁小机灵。\r\n　　当身边的同龄朋友们开始沉浸在科技玩具带来的“电子陪伴”中，而玩具伙伴们也迎来了前所未有的生存难题：在屏幕占据注意力的时代，玩具的时代真的结束了吗？在“被取代”危机的当下，这群玩具伙伴还能否携手，帮助邦妮找回属于自己的真实友谊与快乐？', 'movies/p2932203122.webp', 0, 90, '2026-06-19', 'coming', '2026-05-21 16:41:35.682139', '美国', '英语');
INSERT INTO `movies_movie` VALUES (26, '玩具总动员4', '自从与小主人安迪告别后，胡迪（汤姆·汉克斯 Tom Hanks 配音）和他的伙伴们在小女孩邦妮家安顿下来，不仅成为了邦妮（玛德琳·麦格劳 Madeleine McGraw 配音）的心爱之物，还结识了一批新伙伴。转眼之间，邦妮也要进入幼儿园啦，她用灵巧的小手把一个餐叉做成了玩具带了回来，并且热爱有加。胡迪虽然稍感失落，却还能欣然接受。只不过叉叉（托尼·海尔 Tony Hale 配音）似乎认定自己只是垃圾，一次次逃走跳进垃圾桶里，这可给胡迪找了不少麻烦。不久，邦妮一家外出旅行。叉叉故技重施，想方设法逃走，结果在追逐他的过程中，胡迪和叉叉便与邦妮家失散了。', 'movies/p2557284230.webp', 8.5, 100, '2019-06-21', 'hot', '2026-05-21 16:43:03.228451', '美国', '英语 / 意大利语 / 德语 / 俄语');
INSERT INTO `movies_movie` VALUES (27, '玩具总动员3', '距上一次的冒险已经过去11个年头，转眼间安迪（约翰·莫里斯 John Morris 配音）变成了17岁的阳光男孩。这年夏天，安迪即将开始大学生活，他必须将自己的房间收拾整齐留给妹妹。此前，伍迪（汤姆·汉克斯 Tom Hanks 配音）与巴斯光年（蒂姆·艾伦 Tim Allen 配音）等玩具一直期待安迪再和他们玩耍，但是随着岁月的流逝，他们被冷落在箱子里很久了。安迪十分珍惜这些童年的玩伴，于是准备将他们收在阁楼。谁曾想，妈妈却把玩具们当作废物扔到街道上。玩具们误解了安迪，于是愤然出走，宁可被捐赠到阳光之家幼儿园。', 'movies/p2896589481.webp', 8.9, 103, '2010-06-16', 'offline', '2026-05-21 16:44:24.577234', '美国', '英语');
INSERT INTO `movies_movie` VALUES (28, '盗梦空间', '道姆·柯布（莱昂纳多·迪卡普里奥 Leonardo DiCaprio 饰）与同事阿瑟（约瑟夫·戈登-莱维特 Joseph Gordon-Levitt 饰）和纳什（卢卡斯·哈斯 Lukas Haas 饰）在一次针对日本能源大亨齐藤（渡边谦 饰）的盗梦行动中失败，反被齐藤利用。齐藤威逼利诱因遭通缉而流亡海外的柯布帮他拆分他竞争对手的公司，采取极端措施在其唯一继承人罗伯特·费希尔（希里安·墨菲 Cillian Murphy 饰）的深层潜意识中种下放弃家族公司、自立门户的想法。为了重返美国，柯布偷偷求助于岳父迈尔斯（迈克尔·凯恩 Michael Caine 饰），吸收了年轻的梦境设计师艾里阿德妮（艾伦·佩吉 Ellen Page 饰）、梦境演员艾姆斯（汤姆·哈迪 Tom Hardy 饰）和药剂师约瑟夫（迪利普·劳 Dileep Rao 饰）加入行动。在一层层递进的梦境中，柯布不仅要对付费希尔潜意识的本能反抗，还必须直面已逝妻子梅尔（玛丽昂·歌迪亚 Marion Cotillard 饰）的处处破坏，实际情况远比预想危险得多', 'movies/p2616355133.webp', 9.4, 148, '2010-09-01', 'hot', '2026-05-23 07:35:19.705828', '英国 / 美国', '英语 / 意大利语 / 德语 / 俄语');
INSERT INTO `movies_movie` VALUES (29, '长津湖', '电影以抗美援朝战争第二次战役中的长津湖战役为背景，讲述了一段波澜壮阔的历史：71年前，中国人民志愿军赴朝作战，在极寒严酷环境下，东线作战部队凭着钢铁意志和英勇无畏的战斗精神一路追击，奋勇杀敌，扭转了战场态势，打出了军威国威。', 'movies/p2681329386.webp', 7.4, 176, '2021-09-30', 'hot', '2026-05-23 07:38:26.701106', '中国大陆 / 中国香港', '汉语普通话 / 英语');
INSERT INTO `movies_movie` VALUES (30, '釜山行', '证券公司基金管理人石宇（孔刘 饰）光鲜精干，却也是个重利轻义之徒。妻子为此与之决裂，女儿秀安（金秀安 饰）则对如此自私的父亲越来越失望，决定前往釜山和母亲生活。在秀安生日这天，石宇抽出时间陪伴女儿登上开往釜山的特快列车。而与此同时，城市四处出现了极为可疑的暴动事件。政府 极力洗白无法掩盖丧尸肆虐的事实，即便懵然无知的列车乘客也因为不速之客的到来而堕入恐慌绝望的地狱中。开车的刹那，一名感染者冲入车厢，而她很快尸变并对目光所及之处的健康人展开血腥屠杀。未过多久，丧尸便呈几何数爆发性地增长。石宇被迫和幸存者的乘客们在逼仄的空间中奋力求生。\r\n　　通往釜山的遥遥旅途布满杀机，危难时刻每个幸存者的人性也承受巨大的考验', 'movies/p2360940399.webp', 8.6, 118, '2016-05-13', 'hot', '2026-05-23 07:41:12.442201', '韩国', '韩语');
INSERT INTO `movies_movie` VALUES (31, '南京照相馆', '影片故事取材于南京大屠杀期间日军真实罪证影像。一群生活在南京的百姓躲在吉祥照相馆中避难，为了尽可能的多活一日，他们被迫帮助日军摄影师冲洗底片，却意外冲印出了能证明日军屠城的罪证照片。他们原本只想在大屠杀中保命活下去，面对日军在南京城内的暴行，他们决定让这些底片留存下去……', 'movies/p2924276740.webp', 8.8, 137, '2025-07-25', 'hot', '2026-05-23 07:46:18.937702', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (32, '戏台', '民国年间，战乱频发。五庆班班主侯喜亭（陈佩斯 饰）带着一众名角儿来到德祥大戏院演出，谁成想首演压轴登场的却是包子铺的伙计大嗓儿（黄渤 饰）？全场观众都在翘首以盼名角儿金啸天（尹正 饰）亮相，可刚攻城称王的洪大帅（姜武 饰）却偏偏指名让大嗓儿唱这出《霸王别姬》！眼看戏班的招牌就要砸了，前台戏迷退票砸场让戏院吴经理（杨皓宇 饰）苦不堪言，后台洪大帅持枪闹事更是让人吓破了胆！台前台后都乱了套，男旦凤小桐（余少群 饰）、教化处处长徐明礼（陈大愚 饰）、怀有异心的六姨太（徐卓儿 饰）等人也被卷入这场令人啼笑皆非的闹剧之中……台上霸王声声唱，台下荒唐众生相，既要保住戏班饭碗，又要哄好台下观众，大幕拉开之后，这场戏到底要怎么唱？\r\n　　影片改编自同名话剧。', 'movies/p2923749086.webp', 7.9, 142, '2025-07-25', 'hot', '2026-05-23 07:48:04.674376', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (33, '罗小黑战记2', '小黑跟随师父在小镇上过着安宁日子，分会馆遇袭，打破了妖精世界维系多年的和平，来自妖灵会馆的“全新任务”也让两人陷入分离危机，更让师父无限的处境发生翻天覆地的变化。面对环环相扣的谜团，小黑与师姐鹿野共同开启了寻找真相的新冒险。这一次小黑能否经受住考验，顺利保护师父化险为夷？', 'movies/p2923537864.webp', 8.7, 153, '2025-07-18', 'hot', '2026-05-23 07:49:42.893756', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (34, '复仇者联盟5：毁灭之日', '小罗伯特·唐尼回归漫威电影宇宙，将在罗素兄弟执导的《复仇者联盟5》中饰演毁灭博士（Doctor Doom）。影片讲述复仇者联盟一行人对抗试图征服多元宇宙的反派的故事。本片将于2025年第二季度在伦敦开拍。《复仇者联盟5》和《复仇者联盟6》将背靠背在伦敦拍摄。', 'movies/p2928634568.webp', 0, 153, '2026-12-16', 'coming', '2026-05-23 07:52:27.245896', '美国', '英语');
INSERT INTO `movies_movie` VALUES (35, '复仇者联盟4：终局之战', '一声响指，宇宙间半数生命灰飞烟灭。几近绝望的复仇者们在惊奇队长（布丽·拉尔森 Brie Larson 饰）的帮助下找到灭霸（乔什·布洛林 Josh Brolin 饰）归隐之处，却得知六颗无限宝石均被销毁，希望彻底破灭。如是过了五年，迷失在量子领域的蚁人（保罗·路德 Paul Rudd 饰）意外回到现实世界，他的出现为幸存的复仇者们点燃了希望。与美国队长（克里斯·埃文斯 Chris Evans 饰）冰释前嫌的托尼（小罗伯特·唐尼 Robert Downey Jr. 饰）找到了穿越时空的方法，星散各地的超级英雄再度集结，他们分别穿越不同的时代去搜集无限宝石。而在这一过程中，平行宇宙的灭霸察觉了他们的计划。\r\n　　注定要载入史册的最终决战，超级英雄们为了心中恪守的信念前仆后继', 'movies/p2552058346.webp', 8.5, 162, '2019-04-24', 'hot', '2026-05-23 07:54:30.496866', '美国', '英语');
INSERT INTO `movies_movie` VALUES (36, '蜘蛛侠：崭新之日', '彼得·帕克（汤姆·霍兰德 饰）自愿让全世界遗忘自己，转眼已是四年。失去挚友、挚爱与亲人的陪伴，他独自重返街头，以全职蜘蛛侠的身份坚守使命，守护整座城市。\r\n　　然而，日益沉重的责任与无尽压力，意外引发了一场骇人的身体异变，直接威胁到蜘蛛侠的生命，迫使他向“绿巨人”班纳博士寻求帮助。与此同时，多方邪恶势力趁虚而入，纽约再度陷入危机。面对前所未有的强敌，蜘蛛侠能否绝境破局，完成破茧重生？', 'movies/p2932423533.webp', 0, 136, '2026-07-29', 'coming', '2026-05-23 07:57:09.276721', '美国', '英语');
INSERT INTO `movies_movie` VALUES (37, '蜘蛛侠：英雄无归', '在费了九牛二虎之力好不容易打败了神秘客之后，蜘蛛侠彼得·帕克（汤姆·赫兰德 Tom Holland 饰）却被濒死之际的神秘客揭露了真实身份。随后主流媒体对超能力者滥用权力造成普通平民生活无数困扰的行为大加挞伐，一时间彼得的生活乱作一团，甚至影响到了MJ（赞达亚 Zendaya 饰）和好朋友内德（雅各布·巴特朗 Jacob Batalon 饰）的生活。备受困扰的彼得找到了奇异博士（本尼迪克特·康伯巴奇 Benedict Cumberbatch 饰），希望对方施展一条能够让世人忘记他真实身份的咒语。谁知乱中出错，这条咒语将其他宇宙中认识彼得·帕克的人陆续带来，其中包括章鱼博士、绿魔、沙人等其他蜘蛛侠的死对头。\r\n　　担心这些“对手”回到各自宇宙后迎来灭亡的命运，彼得决定拯救他们，却无意中带来让他无法承受的因果', 'movies/p2730024046.webp', 7.8, 148, '2021-12-15', 'hot', '2026-05-23 07:58:35.570246', '美国', '英语');
INSERT INTO `movies_movie` VALUES (50, '误杀', '李维杰（肖央 饰）与妻子阿玉（谭卓 饰）来泰打拼17年，膝下育有两个女儿，年届四十的他靠开设网络公司为生，为人也颇得小镇居民的好感，而这一切美好却被突如其来的不速之客打破。这个充斥走私，贩毒活动的边陲小镇，各种权力交织碾压公平正义。李维杰的大女儿平平（许文珊 饰）被督察长拉韫（陈冲 饰）的儿子素察（边天扬 饰）迷奸，因反抗误杀对方。李维杰曾亲眼目睹督察长滥用私刑，深知法律无用，为了维护女儿，捍卫家人，李维杰埋尸掩盖一切证据，在时间与空间的交错缝隙中，与警方在身心层面，展开了殊死一搏的较量。', 'movies/p2614628862.webp', 7.5, 112, '2019-12-13', 'hot', '2026-05-23 16:30:24.815665', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (49, '大白鲨', '艾米蒂岛是一个旅游度假胜地，有大批的游客来这里游泳。然而，大白鲨的出现却改变了这一切。事故从一对情侣开始，他们下海游泳，女的不幸成为了第一个牺牲者，支离破碎的尸体令人惨不忍睹。当地官员却不愿意封场调查，他们怕影响旅游收入，于是请来了生物学家胡珀（理查德•德莱福斯 Ric hard Dreyfuss 饰）。\r\n　　胡珀断定，这是一只非比寻常的巨大白鲨。他的提醒并没有引起当局的足够重视，紧接着又有人死于非命，事态才变得越发严重。当地一个熟练捕鱼手、警察和胡珀一共三人，决心要捕杀大白鲨，凶险重重的搏斗开始了，谁才是最后的胜者？要获得这场战斗的胜利，又要付出怎样的代价？', 'movies/p2932006122.webp', 7.8, 125, '2026-05-15', 'hot', '2026-05-23 08:34:59.430076', '美国', '英语');
INSERT INTO `movies_movie` VALUES (52, '满江红', '南宋绍兴年间，一代忠良岳鹏举物故，引无数良臣赤子扼腕叹息。四年后，奸相秦桧（雷佳音 饰）率兵与金国相约会谈。谁知会谈前夜，金国使者在秦桧驻地为人所害。事态紧急，亲兵营副统领孙均（易烊千玺 饰）得知不成器的老舅——小兵张大（沈腾 饰）了解线索，遂将其带到秦桧处。秦桧命二人一个时辰内找出真凶，否则一律处死。时间飞速流逝，舞姬瑶琴（王佳怡 饰）、更夫丁三旺（潘斌龙 饰）、马夫刘喜（余皑磊 饰）接连卷入其中，而宰相府总管何立（张译 饰）与副总管武义淳（岳云鹏 饰）相继入场，又将这场波谲云诡的调查涂满血腥。\r\n　　谁是真正凶手？他们行刺所为何事？奸相内心深处又藏着什么不可告人的秘密？', 'movies/p2887555071.webp', 8, 159, '2023-01-22', 'hot', '2026-05-23 16:34:41.695323', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (53, '你好，李焕英', '一场意外，改变了一对母女的命运。病床上的母亲李焕英（刘佳 饰）昏迷不醒，女儿贾晓玲（贾玲 饰）涕泗横流，唯恐与母亲阴阳两隔。恍惚之中，晓玲突然穿越到久远以前的陌生时代，并在那里意外邂逅尚待字闺中的青年李焕英（张小斐 饰）。在此之后，晓玲以远亲相称，成为妈妈形影不离的好姐妹。许是见证了妈妈数十年来的劳苦辛酸，晓玲希望通过努力改变妈妈的命运，让她变成一个幸福快乐、富足无忧的女人。而一系列搞笑、感人的小故事，就围绕这对姐妹花母女', 'movies/p2629056068.webp', 7.7, 128, '2021-02-12', 'hot', '2026-05-23 16:35:54.987894', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (54, '少年的你', '陈念（周冬雨 饰）是一名即将参加高考的高三学生，同校女生胡晓蝶（张艺凡 饰）的跳楼自杀让她的生活陷入了困顿之中。胡晓蝶死后，陈念遭到了以魏莱（周也 饰）为首的三人组的霸凌，魏莱虽然表面上看来是乖巧的优等生，实际上却心思毒辣，胡晓蝶的死和她有着千丝万缕的联系。\r\n　　一次偶然中，陈念邂逅了名为小北（易烊千玺 饰）的小混混，随着时间的推移，心心相惜的两人之间产生了真挚的感情。小北答应陈念在暗中保护她免受魏莱的欺凌，没想到这一决定引发了一连串的连锁反应。负责调查胡晓蝶死因的警官郑易（尹昉 饰）隐隐察觉到校园里的古怪气氛，可他的调查却屡屡遭到校方的阻挠。', 'movies/p2572166063.webp', 8.2, 135, '2019-10-25', 'hot', '2026-05-23 16:37:10.266088', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (55, '人生大事', '莫三妹是一个刑满释放后子承父业，经营殡葬店的“殡葬师”。他玩世不恭，对生活和职业充满厌倦。一次出殡中，他遇到了孤儿武小文。小文的外婆去世，她无法理解“死亡”的含义，固执地缠着三哥要找回外婆。两人的意外相遇，搅黄了三哥的生意，也给他的生活带来一连串麻烦。但在不断的争吵和磨合中，毫无血缘关系的两人逐渐产生了类似父女的亲情。', 'movies/p2874262709.webp', 7.4, 112, '2022-06-24', 'hot', '2026-05-23 16:38:24.661787', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (56, '咒', '六年前，怀孕的李若男（蔡亘宴 饰）、陈立东（林敬伦 饰）和陈振原（温庆禹 饰）秉着破除迷信的态度进入了陈家村，据说那里供奉着不可冒犯的神明。陈立东和陈振原因为传入了祭坛所在的禁地而招致了灭顶之灾，李若男虽然逃过一死，精神却受到了极大的冲击。\r\n　　此事过后，李若男生下了一个女儿，因为怕触犯禁忌，李若男将女儿寄养在孤儿院中。之后，李若男一直接受着心理治疗，一晃眼就是六年过去。当李若男觉得一切都已经平息之后，她将女儿陈乐瞳（黄歆庭 饰）接回了自己身边，哪知道女儿刚到家没多久，家中便屡屡出现可怕的异像，年幼的陈乐瞳似乎和曾经陈家村所供奉的神明有着千丝万缕的联系。', 'movies/p2871258860.webp', 7.9, 112, '2022-03-18', 'hot', '2026-05-23 16:39:57.980418', '中国台湾', '汉语普通话 / 闽南语');
INSERT INTO `movies_movie` VALUES (57, '哭声', '在韩国某个偏远的山村，虽然这里生活并不富足，但长久以来安宁无忧，人们仿佛不知危险的逼近。直到某晚，村中突发杀人事件，彻底打破了这里的宁静。在村里担任警察的钟九（郭度沅 饰）与同侪迅速赶往现场调查，他初步推断这是一起恶性杀人事件，只不过当地人私下猜测，认为那个不知何时出现在村边树林的日本人（国村隼 饰）有最大嫌疑。这个日本人可能会某种巫术，他通过妖邪的手段将人诅咒之死。\r\n　　在此之后，接二连三离奇非常却又有着共通之处的死亡事件接连发生，甚至连钟九的女儿也被置身危险之中。万般无奈之下，钟九只得求助巫师（黄正民 饰），以禳解降临在村人和女儿头上的可怕诅咒', 'movies/p2339592703.webp', 7.4, 156, '2016-05-11', 'hot', '2026-05-23 16:41:25.640977', '韩国', '韩语');
INSERT INTO `movies_movie` VALUES (58, '昆池岩', '原名南营神经精神医院的昆池岩精神病院，最早建立于20世纪60年代。在特殊的时代它曾经历了无比的辉煌，然而更为人熟知的则是该医院身上所发生的各类恐怖事件。现如今，早已废弃的昆池岩医院被CNN票选为全球七大恐怖之地之一，更由此吸引无数寻求刺激的青年男女来此探险。三个月前，两名青少年来此探险，结果在直播中遭遇诡异事件，下落不明。此后，《恐怖世代》剧组在魏河俊的召集下，网罗了吴雅妍、朴智贤、夏洛特（文艺媛 饰）、李丞旭、朴成勋、刘帝允等人前往昆池岩，更试图打开备受诅咒的402室。', 'movies/p2513360824.webp', 7.6, 145, '2018-03-28', 'hot', '2026-05-23 16:42:37.637277', '韩国', '韩语');
INSERT INTO `movies_movie` VALUES (59, '红海行动', '中东国家伊维亚共和国发生政变，武装冲突不断升级。刚刚在索马里执行完解救人质任务的海军护卫舰临沂号，受命前往伊维亚执行撤侨任务。舰长高云（张涵予 饰）派出杨锐（张译 饰）率领的蛟龙突击队登陆战区，护送华侨安全撤离。谁知恐怖组织扎卡却将撤侨部队逼入交火区，一场激烈的战斗在所难免。与此同时，法籍华人记者夏楠（海清 饰）正在伊维亚追查威廉·柏森博士贩卖核原料的事实，而扎卡则突袭柏森博士所在的公司，意图抢走核原料。混战中，一名隶属柏森博士公司的中国员工成为人质。为了解救该人质，八名蛟龙队员必须潜入有150名恐怖分子的聚集点，他们用自己的信念和鲜血铸成中国军人顽强不屈的丰碑！', 'movies/p2514119443.webp', 8.2, 138, '2018-02-16', 'hot', '2026-05-23 16:44:28.421854', '中国大陆 / 中国香港', '汉语普通话');
INSERT INTO `movies_movie` VALUES (60, '八佰', '1937年，日本帝国主义全面入侵中国。同年，淞沪会战打响。经过三个月激烈交战，上海沦陷在即。值此危亡时刻，中国国民革命军第三战区88师524团团副谢晋元（杜淳 饰）奉命率领一个加强营固守苏州河畔的四行仓库。吊诡的是，苏州河的对岸便是租界，因此租界内的中外人士围观了这场惊心动魄的保卫战。在接下来的4天5夜里，作为“八佰壮士”的一员，羊拐（王千源 饰）、端午（欧豪 饰）、老铁（姜武 饰）、老算盘（张译 饰）在生死考验中各自展现了人性最真实的一面，而他们的功绩注定将在历史上留下浓重的一笔', 'movies/p2615925279.webp', 7.5, 147, '2020-08-21', 'hot', '2026-05-23 16:45:45.540835', '中国大陆', '汉语普通话');
INSERT INTO `movies_movie` VALUES (61, '金刚川', '1953年，惨烈的抗美援朝战争进入最后的阶段。是时，志愿军战士奉命以最快的速度赶往金城，参加夏季反击战役中、同时也是整个抗美援朝战争的最后一场战役。而这场战役的胜负，也将极大左右整场战争的成败走向。为此，志愿军战士日夜兼程，马不停蹄，可是名为金刚川的河流挡住了他们的去路。工兵战士通力合作，一次次搭起临时桥梁，可是美军轰炸机却一次次炸毁桥梁，屠杀志愿军士兵。眼看时间一分一秒过去，关磊（吴京 饰）、张飞（张译 饰）、高福来（邓超 饰）等铁血军人不惜用自己的血肉之躯换取道路的畅行。', 'movies/p2623301908.webp', 7.3, 134, '2020-10-23', 'hot', '2026-05-23 16:47:39.151503', '中国大陆', '汉语普通话');

-- ----------------------------
-- Table structure for movies_movie_categories
-- ----------------------------
DROP TABLE IF EXISTS `movies_movie_categories`;
CREATE TABLE `movies_movie_categories`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `movie_id` bigint(20) NOT NULL,
  `category_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `movies_movie_categories_movie_id_category_id_c0beab68_uniq`(`movie_id`, `category_id`) USING BTREE,
  INDEX `movies_movie_categories_movie_id_24fd2991`(`movie_id`) USING BTREE,
  INDEX `movies_movie_categories_category_id_b69736a9`(`category_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 149 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of movies_movie_categories
-- ----------------------------
INSERT INTO `movies_movie_categories` VALUES (1, 1, 2);
INSERT INTO `movies_movie_categories` VALUES (2, 2, 1);
INSERT INTO `movies_movie_categories` VALUES (3, 2, 4);
INSERT INTO `movies_movie_categories` VALUES (4, 2, 5);
INSERT INTO `movies_movie_categories` VALUES (5, 3, 3);
INSERT INTO `movies_movie_categories` VALUES (6, 3, 4);
INSERT INTO `movies_movie_categories` VALUES (7, 4, 4);
INSERT INTO `movies_movie_categories` VALUES (8, 4, 5);
INSERT INTO `movies_movie_categories` VALUES (9, 5, 1);
INSERT INTO `movies_movie_categories` VALUES (10, 5, 4);
INSERT INTO `movies_movie_categories` VALUES (11, 6, 4);
INSERT INTO `movies_movie_categories` VALUES (12, 7, 8);
INSERT INTO `movies_movie_categories` VALUES (13, 7, 7);
INSERT INTO `movies_movie_categories` VALUES (14, 8, 3);
INSERT INTO `movies_movie_categories` VALUES (15, 8, 4);
INSERT INTO `movies_movie_categories` VALUES (16, 8, 6);
INSERT INTO `movies_movie_categories` VALUES (17, 9, 9);
INSERT INTO `movies_movie_categories` VALUES (18, 9, 2);
INSERT INTO `movies_movie_categories` VALUES (19, 9, 6);
INSERT INTO `movies_movie_categories` VALUES (20, 10, 10);
INSERT INTO `movies_movie_categories` VALUES (21, 10, 3);
INSERT INTO `movies_movie_categories` VALUES (22, 10, 5);
INSERT INTO `movies_movie_categories` VALUES (23, 11, 10);
INSERT INTO `movies_movie_categories` VALUES (24, 11, 2);
INSERT INTO `movies_movie_categories` VALUES (25, 11, 3);
INSERT INTO `movies_movie_categories` VALUES (26, 12, 10);
INSERT INTO `movies_movie_categories` VALUES (27, 12, 2);
INSERT INTO `movies_movie_categories` VALUES (28, 12, 3);
INSERT INTO `movies_movie_categories` VALUES (29, 13, 10);
INSERT INTO `movies_movie_categories` VALUES (30, 13, 2);
INSERT INTO `movies_movie_categories` VALUES (31, 13, 3);
INSERT INTO `movies_movie_categories` VALUES (32, 14, 1);
INSERT INTO `movies_movie_categories` VALUES (33, 14, 4);
INSERT INTO `movies_movie_categories` VALUES (34, 15, 5);
INSERT INTO `movies_movie_categories` VALUES (35, 16, 1);
INSERT INTO `movies_movie_categories` VALUES (36, 16, 4);
INSERT INTO `movies_movie_categories` VALUES (37, 16, 5);
INSERT INTO `movies_movie_categories` VALUES (38, 17, 10);
INSERT INTO `movies_movie_categories` VALUES (39, 17, 3);
INSERT INTO `movies_movie_categories` VALUES (40, 18, 10);
INSERT INTO `movies_movie_categories` VALUES (41, 18, 3);
INSERT INTO `movies_movie_categories` VALUES (140, 57, 7);
INSERT INTO `movies_movie_categories` VALUES (141, 58, 8);
INSERT INTO `movies_movie_categories` VALUES (44, 20, 2);
INSERT INTO `movies_movie_categories` VALUES (45, 20, 10);
INSERT INTO `movies_movie_categories` VALUES (46, 20, 5);
INSERT INTO `movies_movie_categories` VALUES (47, 21, 2);
INSERT INTO `movies_movie_categories` VALUES (48, 21, 4);
INSERT INTO `movies_movie_categories` VALUES (49, 21, 6);
INSERT INTO `movies_movie_categories` VALUES (50, 22, 9);
INSERT INTO `movies_movie_categories` VALUES (51, 22, 4);
INSERT INTO `movies_movie_categories` VALUES (52, 22, 5);
INSERT INTO `movies_movie_categories` VALUES (53, 23, 9);
INSERT INTO `movies_movie_categories` VALUES (54, 23, 4);
INSERT INTO `movies_movie_categories` VALUES (55, 23, 5);
INSERT INTO `movies_movie_categories` VALUES (56, 24, 8);
INSERT INTO `movies_movie_categories` VALUES (57, 25, 9);
INSERT INTO `movies_movie_categories` VALUES (58, 25, 10);
INSERT INTO `movies_movie_categories` VALUES (59, 25, 4);
INSERT INTO `movies_movie_categories` VALUES (60, 25, 5);
INSERT INTO `movies_movie_categories` VALUES (61, 26, 9);
INSERT INTO `movies_movie_categories` VALUES (62, 26, 10);
INSERT INTO `movies_movie_categories` VALUES (63, 26, 5);
INSERT INTO `movies_movie_categories` VALUES (64, 27, 9);
INSERT INTO `movies_movie_categories` VALUES (65, 27, 10);
INSERT INTO `movies_movie_categories` VALUES (66, 27, 5);
INSERT INTO `movies_movie_categories` VALUES (67, 28, 10);
INSERT INTO `movies_movie_categories` VALUES (68, 28, 3);
INSERT INTO `movies_movie_categories` VALUES (69, 28, 4);
INSERT INTO `movies_movie_categories` VALUES (70, 28, 7);
INSERT INTO `movies_movie_categories` VALUES (71, 29, 11);
INSERT INTO `movies_movie_categories` VALUES (72, 29, 4);
INSERT INTO `movies_movie_categories` VALUES (73, 29, 12);
INSERT INTO `movies_movie_categories` VALUES (74, 30, 8);
INSERT INTO `movies_movie_categories` VALUES (75, 30, 2);
INSERT INTO `movies_movie_categories` VALUES (76, 31, 11);
INSERT INTO `movies_movie_categories` VALUES (77, 31, 4);
INSERT INTO `movies_movie_categories` VALUES (78, 31, 12);
INSERT INTO `movies_movie_categories` VALUES (79, 32, 9);
INSERT INTO `movies_movie_categories` VALUES (80, 32, 4);
INSERT INTO `movies_movie_categories` VALUES (81, 33, 10);
INSERT INTO `movies_movie_categories` VALUES (82, 33, 5);
INSERT INTO `movies_movie_categories` VALUES (83, 34, 10);
INSERT INTO `movies_movie_categories` VALUES (84, 34, 2);
INSERT INTO `movies_movie_categories` VALUES (85, 34, 3);
INSERT INTO `movies_movie_categories` VALUES (86, 35, 10);
INSERT INTO `movies_movie_categories` VALUES (87, 35, 2);
INSERT INTO `movies_movie_categories` VALUES (88, 35, 3);
INSERT INTO `movies_movie_categories` VALUES (89, 35, 4);
INSERT INTO `movies_movie_categories` VALUES (90, 36, 10);
INSERT INTO `movies_movie_categories` VALUES (91, 36, 2);
INSERT INTO `movies_movie_categories` VALUES (92, 36, 3);
INSERT INTO `movies_movie_categories` VALUES (93, 37, 10);
INSERT INTO `movies_movie_categories` VALUES (94, 37, 2);
INSERT INTO `movies_movie_categories` VALUES (95, 37, 3);
INSERT INTO `movies_movie_categories` VALUES (139, 57, 8);
INSERT INTO `movies_movie_categories` VALUES (138, 56, 13);
INSERT INTO `movies_movie_categories` VALUES (137, 56, 8);
INSERT INTO `movies_movie_categories` VALUES (136, 55, 4);
INSERT INTO `movies_movie_categories` VALUES (135, 54, 4);
INSERT INTO `movies_movie_categories` VALUES (134, 54, 1);
INSERT INTO `movies_movie_categories` VALUES (133, 53, 4);
INSERT INTO `movies_movie_categories` VALUES (132, 53, 9);
INSERT INTO `movies_movie_categories` VALUES (131, 52, 7);
INSERT INTO `movies_movie_categories` VALUES (130, 52, 4);
INSERT INTO `movies_movie_categories` VALUES (128, 51, 7);
INSERT INTO `movies_movie_categories` VALUES (129, 52, 9);
INSERT INTO `movies_movie_categories` VALUES (126, 50, 7);
INSERT INTO `movies_movie_categories` VALUES (127, 51, 6);
INSERT INTO `movies_movie_categories` VALUES (124, 50, 4);
INSERT INTO `movies_movie_categories` VALUES (125, 50, 6);
INSERT INTO `movies_movie_categories` VALUES (122, 1, 12);
INSERT INTO `movies_movie_categories` VALUES (123, 24, 13);
INSERT INTO `movies_movie_categories` VALUES (121, 49, 13);
INSERT INTO `movies_movie_categories` VALUES (120, 49, 4);
INSERT INTO `movies_movie_categories` VALUES (119, 49, 10);
INSERT INTO `movies_movie_categories` VALUES (118, 7, 13);
INSERT INTO `movies_movie_categories` VALUES (142, 59, 2);
INSERT INTO `movies_movie_categories` VALUES (143, 59, 12);
INSERT INTO `movies_movie_categories` VALUES (144, 60, 11);
INSERT INTO `movies_movie_categories` VALUES (145, 60, 4);
INSERT INTO `movies_movie_categories` VALUES (146, 60, 12);
INSERT INTO `movies_movie_categories` VALUES (147, 61, 11);
INSERT INTO `movies_movie_categories` VALUES (148, 61, 12);

-- ----------------------------
-- Table structure for movies_session
-- ----------------------------
DROP TABLE IF EXISTS `movies_session`;
CREATE TABLE `movies_session`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `start_time` datetime(6) NOT NULL,
  `price` decimal(10, 2) NOT NULL,
  `total_tickets` int(11) NOT NULL,
  `sold_tickets` int(11) NOT NULL,
  `hall_id` bigint(20) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `movies_session_movie_id_hall_id_start_time_03a34a3b_uniq`(`movie_id`, `hall_id`, `start_time`) USING BTREE,
  INDEX `movies_session_hall_id_cc4c4070`(`hall_id`) USING BTREE,
  INDEX `movies_session_movie_id_48ec7c4f`(`movie_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 938 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of movies_session
-- ----------------------------
INSERT INTO `movies_session` VALUES (6, '2026-05-21 20:00:00.000000', 49.90, 100, 17, 8, 1);
INSERT INTO `movies_session` VALUES (8, '2026-05-21 00:01:52.000000', 70.00, 76, 0, 8, 2);
INSERT INTO `movies_session` VALUES (12, '2026-05-21 23:06:44.000000', 49.90, 70, 0, 11, 1);
INSERT INTO `movies_session` VALUES (937, '2026-09-05 16:30:00.000000', 149.90, 80, 72, 18, 37);
INSERT INTO `movies_session` VALUES (936, '2026-08-15 10:45:00.000000', 139.90, 100, 82, 17, 37);
INSERT INTO `movies_session` VALUES (935, '2026-07-23 21:30:00.000000', 89.90, 100, 68, 10, 37);
INSERT INTO `movies_session` VALUES (934, '2026-09-04 11:15:00.000000', 119.90, 80, 44, 18, 37);
INSERT INTO `movies_session` VALUES (933, '2026-08-28 13:30:00.000000', 139.90, 80, 39, 18, 37);
INSERT INTO `movies_session` VALUES (932, '2026-07-06 22:30:00.000000', 129.90, 100, 43, 11, 37);
INSERT INTO `movies_session` VALUES (931, '2026-09-02 21:00:00.000000', 79.90, 40, 22, 26, 37);
INSERT INTO `movies_session` VALUES (930, '2026-07-03 21:00:00.000000', 99.90, 100, 69, 10, 37);
INSERT INTO `movies_session` VALUES (929, '2026-07-15 14:30:00.000000', 69.90, 100, 33, 11, 35);
INSERT INTO `movies_session` VALUES (928, '2026-07-28 15:30:00.000000', 149.90, 120, 59, 15, 35);
INSERT INTO `movies_session` VALUES (927, '2026-06-28 10:30:00.000000', 69.90, 100, 84, 10, 35);
INSERT INTO `movies_session` VALUES (926, '2026-07-22 21:45:00.000000', 99.90, 150, 118, 19, 35);
INSERT INTO `movies_session` VALUES (917, '2026-07-11 11:00:00.000000', 99.90, 100, 84, 17, 33);
INSERT INTO `movies_session` VALUES (916, '2026-08-10 22:45:00.000000', 109.90, 50, 41, 8, 33);
INSERT INTO `movies_session` VALUES (915, '2026-06-14 11:30:00.000000', 149.90, 200, 118, 25, 33);
INSERT INTO `movies_session` VALUES (914, '2026-07-21 19:30:00.000000', 79.90, 120, 100, 23, 33);
INSERT INTO `movies_session` VALUES (913, '2026-07-06 13:45:00.000000', 69.90, 80, 67, 18, 33);
INSERT INTO `movies_session` VALUES (912, '2026-07-26 16:15:00.000000', 69.90, 100, 33, 17, 33);
INSERT INTO `movies_session` VALUES (911, '2026-08-26 16:15:00.000000', 119.90, 80, 39, 18, 32);
INSERT INTO `movies_session` VALUES (910, '2026-06-28 14:15:00.000000', 149.90, 100, 72, 24, 32);
INSERT INTO `movies_session` VALUES (909, '2026-08-12 14:45:00.000000', 129.90, 80, 65, 18, 32);
INSERT INTO `movies_session` VALUES (897, '2026-07-28 20:45:00.000000', 99.90, 40, 26, 21, 31);
INSERT INTO `movies_session` VALUES (896, '2026-09-06 10:15:00.000000', 129.90, 150, 55, 16, 31);
INSERT INTO `movies_session` VALUES (895, '2026-08-14 18:15:00.000000', 79.90, 80, 34, 18, 31);
INSERT INTO `movies_session` VALUES (894, '2026-07-17 18:15:00.000000', 109.90, 100, 58, 17, 30);
INSERT INTO `movies_session` VALUES (893, '2026-09-05 21:45:00.000000', 89.90, 40, 13, 21, 30);
INSERT INTO `movies_session` VALUES (892, '2026-06-23 11:45:00.000000', 79.90, 150, 45, 19, 30);
INSERT INTO `movies_session` VALUES (891, '2026-08-09 21:30:00.000000', 129.90, 100, 76, 24, 30);
INSERT INTO `movies_session` VALUES (890, '2026-08-03 21:00:00.000000', 149.90, 80, 58, 27, 30);
INSERT INTO `movies_session` VALUES (889, '2026-08-02 14:15:00.000000', 109.90, 80, 50, 18, 30);
INSERT INTO `movies_session` VALUES (881, '2026-09-14 14:30:00.000000', 119.90, 80, 66, 27, 29);
INSERT INTO `movies_session` VALUES (880, '2026-07-01 10:45:00.000000', 79.90, 120, 39, 15, 29);
INSERT INTO `movies_session` VALUES (879, '2026-09-26 11:30:00.000000', 129.90, 100, 37, 10, 28);
INSERT INTO `movies_session` VALUES (878, '2026-08-28 19:00:00.000000', 89.90, 150, 84, 19, 28);
INSERT INTO `movies_session` VALUES (877, '2026-08-20 09:15:00.000000', 69.90, 150, 64, 22, 28);
INSERT INTO `movies_session` VALUES (876, '2026-07-07 16:15:00.000000', 149.90, 150, 105, 22, 28);
INSERT INTO `movies_session` VALUES (875, '2026-06-15 21:00:00.000000', 89.90, 120, 73, 23, 28);
INSERT INTO `movies_session` VALUES (874, '2026-08-16 11:15:00.000000', 109.90, 100, 62, 10, 28);
INSERT INTO `movies_session` VALUES (873, '2026-08-23 09:00:00.000000', 139.90, 40, 24, 21, 28);
INSERT INTO `movies_session` VALUES (872, '2026-09-28 09:45:00.000000', 119.90, 200, 131, 20, 28);
INSERT INTO `movies_session` VALUES (859, '2026-06-14 16:15:00.000000', 69.90, 120, 77, 15, 24);
INSERT INTO `movies_session` VALUES (858, '2026-08-01 21:30:00.000000', 79.90, 150, 129, 16, 24);
INSERT INTO `movies_session` VALUES (857, '2026-06-28 09:00:00.000000', 69.90, 100, 80, 24, 24);
INSERT INTO `movies_session` VALUES (856, '2026-07-14 09:15:00.000000', 149.90, 120, 106, 15, 24);
INSERT INTO `movies_session` VALUES (855, '2026-07-01 19:30:00.000000', 109.90, 100, 58, 10, 24);
INSERT INTO `movies_session` VALUES (854, '2026-06-11 09:30:00.000000', 89.90, 100, 85, 24, 24);
INSERT INTO `movies_session` VALUES (853, '2026-09-11 11:15:00.000000', 79.90, 150, 45, 22, 23);
INSERT INTO `movies_session` VALUES (852, '2026-07-02 19:30:00.000000', 139.90, 80, 50, 27, 23);
INSERT INTO `movies_session` VALUES (851, '2026-09-09 15:30:00.000000', 119.90, 100, 40, 11, 23);
INSERT INTO `movies_session` VALUES (850, '2026-09-27 22:45:00.000000', 79.90, 150, 49, 19, 23);
INSERT INTO `movies_session` VALUES (849, '2026-08-02 14:30:00.000000', 79.90, 80, 57, 18, 23);
INSERT INTO `movies_session` VALUES (848, '2026-06-10 19:30:00.000000', 99.90, 150, 102, 19, 23);
INSERT INTO `movies_session` VALUES (847, '2026-08-12 10:00:00.000000', 69.90, 100, 66, 17, 23);
INSERT INTO `movies_session` VALUES (846, '2026-09-23 18:15:00.000000', 119.90, 200, 96, 20, 23);
INSERT INTO `movies_session` VALUES (845, '2026-08-05 14:00:00.000000', 119.90, 100, 79, 17, 23);
INSERT INTO `movies_session` VALUES (844, '2026-06-12 13:00:00.000000', 139.90, 120, 107, 23, 23);
INSERT INTO `movies_session` VALUES (843, '2026-08-06 11:15:00.000000', 89.90, 100, 41, 24, 21);
INSERT INTO `movies_session` VALUES (842, '2026-09-04 22:00:00.000000', 109.90, 40, 15, 26, 21);
INSERT INTO `movies_session` VALUES (841, '2026-06-16 19:30:00.000000', 129.90, 100, 63, 11, 21);
INSERT INTO `movies_session` VALUES (828, '2026-06-15 11:30:00.000000', 99.90, 120, 61, 15, 20);
INSERT INTO `movies_session` VALUES (827, '2026-06-16 10:15:00.000000', 129.90, 120, 41, 15, 20);
INSERT INTO `movies_session` VALUES (826, '2026-09-07 09:00:00.000000', 119.90, 80, 42, 27, 20);
INSERT INTO `movies_session` VALUES (825, '2026-08-19 13:30:00.000000', 129.90, 50, 17, 8, 20);
INSERT INTO `movies_session` VALUES (824, '2026-07-08 09:15:00.000000', 129.90, 150, 101, 22, 20);
INSERT INTO `movies_session` VALUES (823, '2026-09-18 15:00:00.000000', 79.90, 40, 12, 21, 20);
INSERT INTO `movies_session` VALUES (822, '2026-07-01 10:15:00.000000', 99.90, 50, 25, 8, 20);
INSERT INTO `movies_session` VALUES (821, '2026-06-26 11:30:00.000000', 79.90, 150, 114, 22, 18);
INSERT INTO `movies_session` VALUES (820, '2026-06-06 15:15:00.000000', 129.90, 100, 33, 10, 18);
INSERT INTO `movies_session` VALUES (819, '2026-06-18 15:45:00.000000', 89.90, 100, 47, 11, 18);
INSERT INTO `movies_session` VALUES (818, '2026-08-02 13:45:00.000000', 129.90, 100, 62, 24, 18);
INSERT INTO `movies_session` VALUES (817, '2026-07-27 11:00:00.000000', 79.90, 100, 43, 10, 18);
INSERT INTO `movies_session` VALUES (816, '2026-07-11 20:45:00.000000', 69.90, 200, 153, 25, 18);
INSERT INTO `movies_session` VALUES (815, '2026-07-23 14:30:00.000000', 109.90, 150, 124, 22, 18);
INSERT INTO `movies_session` VALUES (814, '2026-07-10 13:00:00.000000', 149.90, 40, 33, 26, 18);
INSERT INTO `movies_session` VALUES (813, '2026-08-09 22:45:00.000000', 69.90, 120, 106, 23, 18);
INSERT INTO `movies_session` VALUES (812, '2026-08-16 20:45:00.000000', 109.90, 40, 31, 21, 18);
INSERT INTO `movies_session` VALUES (811, '2026-09-06 21:15:00.000000', 129.90, 40, 35, 26, 15);
INSERT INTO `movies_session` VALUES (810, '2026-06-02 18:15:00.000000', 149.90, 100, 56, 10, 15);
INSERT INTO `movies_session` VALUES (801, '2026-07-05 10:00:00.000000', 139.90, 100, 72, 17, 13);
INSERT INTO `movies_session` VALUES (800, '2026-07-04 16:30:00.000000', 69.90, 40, 35, 26, 13);
INSERT INTO `movies_session` VALUES (799, '2026-08-06 10:00:00.000000', 109.90, 150, 67, 22, 13);
INSERT INTO `movies_session` VALUES (798, '2026-09-27 16:00:00.000000', 119.90, 200, 174, 20, 12);
INSERT INTO `movies_session` VALUES (797, '2026-08-03 13:45:00.000000', 149.90, 120, 64, 23, 12);
INSERT INTO `movies_session` VALUES (796, '2026-06-24 09:15:00.000000', 99.90, 40, 22, 26, 12);
INSERT INTO `movies_session` VALUES (795, '2026-09-16 19:00:00.000000', 69.90, 80, 38, 18, 12);
INSERT INTO `movies_session` VALUES (794, '2026-07-02 21:45:00.000000', 139.90, 100, 64, 24, 12);
INSERT INTO `movies_session` VALUES (793, '2026-07-11 11:45:00.000000', 79.90, 100, 85, 17, 12);
INSERT INTO `movies_session` VALUES (792, '2026-08-20 15:45:00.000000', 139.90, 200, 150, 25, 12);
INSERT INTO `movies_session` VALUES (791, '2026-06-21 14:30:00.000000', 99.90, 150, 115, 19, 12);
INSERT INTO `movies_session` VALUES (790, '2026-08-23 15:30:00.000000', 89.90, 100, 42, 24, 12);
INSERT INTO `movies_session` VALUES (789, '2026-07-10 10:45:00.000000', 109.90, 50, 25, 8, 10);
INSERT INTO `movies_session` VALUES (788, '2026-09-04 19:15:00.000000', 139.90, 150, 54, 22, 10);
INSERT INTO `movies_session` VALUES (787, '2026-06-28 09:30:00.000000', 109.90, 100, 49, 11, 10);
INSERT INTO `movies_session` VALUES (786, '2026-06-02 13:45:00.000000', 69.90, 200, 63, 25, 10);
INSERT INTO `movies_session` VALUES (785, '2026-06-20 20:15:00.000000', 69.90, 80, 33, 18, 10);
INSERT INTO `movies_session` VALUES (784, '2026-08-24 19:30:00.000000', 139.90, 100, 65, 24, 10);
INSERT INTO `movies_session` VALUES (775, '2026-07-13 10:15:00.000000', 79.90, 80, 58, 18, 9);
INSERT INTO `movies_session` VALUES (774, '2026-06-06 18:00:00.000000', 99.90, 200, 138, 25, 8);
INSERT INTO `movies_session` VALUES (773, '2026-09-23 09:15:00.000000', 89.90, 80, 25, 27, 8);
INSERT INTO `movies_session` VALUES (772, '2026-08-20 22:15:00.000000', 119.90, 100, 81, 17, 8);
INSERT INTO `movies_session` VALUES (771, '2026-06-08 13:30:00.000000', 109.90, 80, 30, 18, 8);
INSERT INTO `movies_session` VALUES (770, '2026-09-20 21:15:00.000000', 89.90, 100, 90, 10, 8);
INSERT INTO `movies_session` VALUES (769, '2026-07-11 21:45:00.000000', 89.90, 100, 80, 17, 8);
INSERT INTO `movies_session` VALUES (768, '2026-09-21 10:00:00.000000', 69.90, 80, 37, 27, 8);
INSERT INTO `movies_session` VALUES (767, '2026-06-28 13:45:00.000000', 119.90, 40, 31, 26, 8);
INSERT INTO `movies_session` VALUES (766, '2026-07-04 11:15:00.000000', 89.90, 40, 24, 21, 8);
INSERT INTO `movies_session` VALUES (765, '2026-06-27 15:45:00.000000', 99.90, 150, 87, 19, 8);
INSERT INTO `movies_session` VALUES (764, '2026-09-22 16:15:00.000000', 149.90, 80, 59, 18, 8);
INSERT INTO `movies_session` VALUES (763, '2026-07-11 22:30:00.000000', 79.90, 100, 55, 24, 7);
INSERT INTO `movies_session` VALUES (762, '2026-07-28 14:30:00.000000', 129.90, 100, 77, 17, 7);
INSERT INTO `movies_session` VALUES (761, '2026-09-11 11:30:00.000000', 129.90, 80, 53, 27, 7);
INSERT INTO `movies_session` VALUES (760, '2026-07-14 11:45:00.000000', 99.90, 200, 66, 25, 7);
INSERT INTO `movies_session` VALUES (759, '2026-08-06 20:30:00.000000', 129.90, 100, 85, 11, 7);
INSERT INTO `movies_session` VALUES (758, '2026-07-03 13:45:00.000000', 89.90, 40, 35, 26, 7);
INSERT INTO `movies_session` VALUES (757, '2026-06-16 20:15:00.000000', 109.90, 40, 22, 26, 7);
INSERT INTO `movies_session` VALUES (756, '2026-06-28 10:45:00.000000', 119.90, 40, 23, 21, 7);
INSERT INTO `movies_session` VALUES (755, '2026-09-12 21:15:00.000000', 99.90, 150, 86, 16, 7);
INSERT INTO `movies_session` VALUES (732, '2026-07-18 15:45:00.000000', 79.90, 80, 66, 27, 1);
INSERT INTO `movies_session` VALUES (727, '2026-08-28 13:30:00.000000', 109.90, 120, 102, 15, 1);
INSERT INTO `movies_session` VALUES (734, '2026-08-04 11:30:00.000000', 89.90, 100, 44, 11, 1);
INSERT INTO `movies_session` VALUES (733, '2026-06-03 16:30:00.000000', 99.90, 120, 73, 15, 1);
INSERT INTO `movies_session` VALUES (731, '2026-08-02 21:15:00.000000', 109.90, 200, 138, 25, 1);
INSERT INTO `movies_session` VALUES (730, '2026-08-26 16:15:00.000000', 109.90, 120, 45, 15, 1);
INSERT INTO `movies_session` VALUES (728, '2026-08-28 13:45:00.000000', 99.90, 120, 108, 15, 1);
INSERT INTO `movies_session` VALUES (190, '2026-05-26 21:30:00.000000', 49.90, 80, 26, 18, 1);
INSERT INTO `movies_session` VALUES (729, '2026-09-10 21:00:00.000000', 119.90, 150, 85, 22, 1);
INSERT INTO `movies_session` VALUES (192, '2026-05-27 12:00:00.000000', 49.90, 100, 79, 10, 1);
INSERT INTO `movies_session` VALUES (193, '2026-05-23 16:45:00.000000', 69.90, 150, 133, 16, 2);
INSERT INTO `movies_session` VALUES (726, '2026-09-27 21:30:00.000000', 129.90, 80, 37, 27, 1);
INSERT INTO `movies_session` VALUES (195, '2026-05-24 19:00:00.000000', 59.90, 100, 32, 11, 2);
INSERT INTO `movies_session` VALUES (196, '2026-05-24 13:00:00.000000', 29.90, 100, 49, 10, 2);
INSERT INTO `movies_session` VALUES (197, '2026-05-25 20:15:00.000000', 59.90, 100, 64, 10, 2);
INSERT INTO `movies_session` VALUES (198, '2026-05-25 09:00:00.000000', 39.90, 50, 30, 8, 2);
INSERT INTO `movies_session` VALUES (199, '2026-05-26 13:30:00.000000', 59.90, 100, 93, 24, 2);
INSERT INTO `movies_session` VALUES (200, '2026-05-26 09:45:00.000000', 69.90, 100, 52, 24, 2);
INSERT INTO `movies_session` VALUES (201, '2026-05-26 20:45:00.000000', 29.90, 100, 46, 17, 2);
INSERT INTO `movies_session` VALUES (202, '2026-05-27 22:45:00.000000', 49.90, 150, 122, 22, 2);
INSERT INTO `movies_session` VALUES (203, '2026-05-27 12:30:00.000000', 59.90, 50, 31, 8, 2);
INSERT INTO `movies_session` VALUES (204, '2026-05-28 16:00:00.000000', 39.90, 100, 0, 24, 3);
INSERT INTO `movies_session` VALUES (205, '2026-05-29 10:00:00.000000', 49.90, 150, 0, 16, 3);
INSERT INTO `movies_session` VALUES (206, '2026-05-30 19:00:00.000000', 39.90, 200, 0, 20, 3);
INSERT INTO `movies_session` VALUES (207, '2026-05-31 10:00:00.000000', 29.90, 80, 0, 27, 3);
INSERT INTO `movies_session` VALUES (208, '2026-06-01 16:00:00.000000', 29.90, 40, 0, 26, 3);
INSERT INTO `movies_session` VALUES (209, '2026-06-02 10:00:00.000000', 29.90, 100, 0, 17, 3);
INSERT INTO `movies_session` VALUES (210, '2026-06-03 20:00:00.000000', 29.90, 120, 0, 23, 3);
INSERT INTO `movies_session` VALUES (211, '2026-06-04 19:00:00.000000', 39.90, 150, 0, 22, 3);
INSERT INTO `movies_session` VALUES (212, '2026-06-05 16:00:00.000000', 39.90, 40, 0, 21, 3);
INSERT INTO `movies_session` VALUES (213, '2026-06-06 20:00:00.000000', 49.90, 100, 0, 17, 3);
INSERT INTO `movies_session` VALUES (214, '2026-06-07 19:00:00.000000', 49.90, 80, 0, 27, 3);
INSERT INTO `movies_session` VALUES (215, '2026-06-08 14:00:00.000000', 49.90, 100, 0, 10, 3);
INSERT INTO `movies_session` VALUES (216, '2026-06-09 19:00:00.000000', 49.90, 40, 0, 21, 3);
INSERT INTO `movies_session` VALUES (217, '2026-06-10 20:00:00.000000', 39.90, 100, 0, 10, 3);
INSERT INTO `movies_session` VALUES (218, '2026-06-11 14:00:00.000000', 49.90, 150, 0, 22, 3);
INSERT INTO `movies_session` VALUES (219, '2026-06-12 16:00:00.000000', 29.90, 80, 0, 18, 3);
INSERT INTO `movies_session` VALUES (220, '2026-06-13 20:00:00.000000', 39.90, 50, 0, 8, 3);
INSERT INTO `movies_session` VALUES (221, '2026-06-14 14:00:00.000000', 29.90, 200, 0, 20, 3);
INSERT INTO `movies_session` VALUES (222, '2026-06-15 14:00:00.000000', 29.90, 100, 0, 24, 3);
INSERT INTO `movies_session` VALUES (223, '2026-06-16 20:00:00.000000', 29.90, 40, 0, 26, 3);
INSERT INTO `movies_session` VALUES (224, '2026-06-17 20:00:00.000000', 39.90, 40, 0, 21, 3);
INSERT INTO `movies_session` VALUES (225, '2026-06-18 14:00:00.000000', 49.90, 40, 0, 26, 3);
INSERT INTO `movies_session` VALUES (234, '2026-06-06 20:00:00.000000', 29.90, 80, 0, 27, 5);
INSERT INTO `movies_session` VALUES (235, '2026-06-07 14:00:00.000000', 39.90, 120, 0, 23, 5);
INSERT INTO `movies_session` VALUES (236, '2026-06-08 16:00:00.000000', 39.90, 150, 0, 19, 5);
INSERT INTO `movies_session` VALUES (237, '2026-06-09 16:00:00.000000', 29.90, 100, 0, 24, 5);
INSERT INTO `movies_session` VALUES (238, '2026-06-10 14:00:00.000000', 29.90, 200, 0, 25, 5);
INSERT INTO `movies_session` VALUES (239, '2026-06-11 19:00:00.000000', 29.90, 100, 0, 10, 5);
INSERT INTO `movies_session` VALUES (240, '2026-06-12 14:00:00.000000', 39.90, 200, 0, 20, 5);
INSERT INTO `movies_session` VALUES (241, '2026-06-13 16:00:00.000000', 49.90, 40, 0, 21, 5);
INSERT INTO `movies_session` VALUES (242, '2026-06-14 20:00:00.000000', 39.90, 100, 0, 17, 5);
INSERT INTO `movies_session` VALUES (243, '2026-05-23 15:00:00.000000', 29.90, 100, 67, 10, 6);
INSERT INTO `movies_session` VALUES (244, '2026-05-24 13:45:00.000000', 49.90, 120, 114, 15, 6);
INSERT INTO `movies_session` VALUES (245, '2026-05-25 19:15:00.000000', 69.90, 80, 28, 27, 6);
INSERT INTO `movies_session` VALUES (246, '2026-05-25 15:15:00.000000', 39.90, 40, 21, 26, 6);
INSERT INTO `movies_session` VALUES (247, '2026-05-26 14:45:00.000000', 49.90, 120, 108, 23, 6);
INSERT INTO `movies_session` VALUES (248, '2026-05-27 11:00:00.000000', 39.90, 120, 100, 23, 6);
INSERT INTO `movies_session` VALUES (249, '2026-05-27 17:15:00.000000', 39.90, 150, 55, 16, 6);
INSERT INTO `movies_session` VALUES (250, '2026-05-27 20:00:00.000000', 39.90, 120, 73, 23, 6);
INSERT INTO `movies_session` VALUES (251, '2026-05-23 12:45:00.000000', 59.90, 200, 69, 20, 7);
INSERT INTO `movies_session` VALUES (252, '2026-05-24 20:45:00.000000', 29.90, 40, 15, 26, 7);
INSERT INTO `movies_session` VALUES (253, '2026-05-24 15:00:00.000000', 69.90, 40, 12, 26, 7);
INSERT INTO `movies_session` VALUES (254, '2026-05-24 21:15:00.000000', 39.90, 40, 37, 26, 7);
INSERT INTO `movies_session` VALUES (255, '2026-05-25 21:30:00.000000', 69.90, 150, 63, 22, 7);
INSERT INTO `movies_session` VALUES (256, '2026-05-25 22:00:00.000000', 39.90, 40, 29, 26, 7);
INSERT INTO `movies_session` VALUES (257, '2026-05-26 18:45:00.000000', 49.90, 200, 69, 20, 7);
INSERT INTO `movies_session` VALUES (258, '2026-05-27 15:00:00.000000', 39.90, 100, 62, 24, 7);
INSERT INTO `movies_session` VALUES (259, '2026-05-27 12:45:00.000000', 59.90, 150, 139, 19, 7);
INSERT INTO `movies_session` VALUES (260, '2026-05-23 18:00:00.000000', 29.90, 150, 89, 16, 8);
INSERT INTO `movies_session` VALUES (261, '2026-05-23 13:30:00.000000', 39.90, 100, 92, 17, 8);
INSERT INTO `movies_session` VALUES (262, '2026-05-23 18:45:00.000000', 69.90, 150, 128, 22, 8);
INSERT INTO `movies_session` VALUES (263, '2026-05-24 11:00:00.000000', 29.90, 50, 37, 8, 8);
INSERT INTO `movies_session` VALUES (264, '2026-05-24 17:45:00.000000', 69.90, 150, 46, 16, 8);
INSERT INTO `movies_session` VALUES (265, '2026-05-24 21:00:00.000000', 59.90, 40, 35, 26, 8);
INSERT INTO `movies_session` VALUES (266, '2026-05-25 20:45:00.000000', 29.90, 150, 56, 19, 8);
INSERT INTO `movies_session` VALUES (267, '2026-05-26 21:30:00.000000', 59.90, 120, 47, 23, 8);
INSERT INTO `movies_session` VALUES (268, '2026-05-26 15:00:00.000000', 39.90, 120, 90, 15, 8);
INSERT INTO `movies_session` VALUES (269, '2026-05-26 11:00:00.000000', 29.90, 40, 20, 26, 8);
INSERT INTO `movies_session` VALUES (270, '2026-05-27 18:30:00.000000', 29.90, 80, 40, 18, 8);
INSERT INTO `movies_session` VALUES (271, '2026-05-27 14:00:00.000000', 29.90, 100, 63, 10, 8);
INSERT INTO `movies_session` VALUES (272, '2026-05-23 17:00:00.000000', 69.90, 150, 93, 19, 9);
INSERT INTO `movies_session` VALUES (273, '2026-05-23 15:30:00.000000', 69.90, 40, 12, 21, 9);
INSERT INTO `movies_session` VALUES (274, '2026-05-23 11:15:00.000000', 69.90, 200, 182, 20, 9);
INSERT INTO `movies_session` VALUES (275, '2026-05-24 10:30:00.000000', 59.90, 100, 81, 24, 9);
INSERT INTO `movies_session` VALUES (276, '2026-05-24 15:00:00.000000', 69.90, 150, 88, 22, 9);
INSERT INTO `movies_session` VALUES (277, '2026-05-25 14:15:00.000000', 69.90, 100, 51, 10, 9);
INSERT INTO `movies_session` VALUES (278, '2026-05-26 20:30:00.000000', 39.90, 80, 31, 18, 9);
INSERT INTO `movies_session` VALUES (279, '2026-05-27 18:15:00.000000', 29.90, 40, 30, 21, 9);
INSERT INTO `movies_session` VALUES (280, '2026-05-23 12:00:00.000000', 69.90, 80, 48, 18, 10);
INSERT INTO `movies_session` VALUES (281, '2026-05-23 11:30:00.000000', 49.90, 150, 89, 19, 10);
INSERT INTO `movies_session` VALUES (282, '2026-05-24 21:45:00.000000', 39.90, 150, 91, 19, 10);
INSERT INTO `movies_session` VALUES (283, '2026-05-25 17:15:00.000000', 29.90, 150, 50, 16, 10);
INSERT INTO `movies_session` VALUES (284, '2026-05-26 15:45:00.000000', 49.90, 100, 70, 17, 10);
INSERT INTO `movies_session` VALUES (285, '2026-05-26 09:45:00.000000', 59.90, 40, 31, 26, 10);
INSERT INTO `movies_session` VALUES (286, '2026-05-27 20:30:00.000000', 29.90, 120, 80, 23, 10);
INSERT INTO `movies_session` VALUES (287, '2026-05-27 12:45:00.000000', 59.90, 150, 121, 22, 10);
INSERT INTO `movies_session` VALUES (288, '2026-05-27 10:30:00.000000', 69.90, 80, 48, 27, 10);
INSERT INTO `movies_session` VALUES (289, '2026-05-28 16:00:00.000000', 39.90, 100, 0, 24, 11);
INSERT INTO `movies_session` VALUES (290, '2026-05-29 16:00:00.000000', 39.90, 100, 0, 17, 11);
INSERT INTO `movies_session` VALUES (291, '2026-05-30 10:00:00.000000', 39.90, 40, 0, 26, 11);
INSERT INTO `movies_session` VALUES (292, '2026-05-31 10:00:00.000000', 49.90, 50, 0, 8, 11);
INSERT INTO `movies_session` VALUES (293, '2026-06-01 10:00:00.000000', 29.90, 150, 0, 22, 11);
INSERT INTO `movies_session` VALUES (294, '2026-06-02 14:00:00.000000', 49.90, 40, 0, 21, 11);
INSERT INTO `movies_session` VALUES (295, '2026-06-03 19:00:00.000000', 39.90, 120, 0, 15, 11);
INSERT INTO `movies_session` VALUES (296, '2026-06-04 20:00:00.000000', 29.90, 120, 0, 23, 11);
INSERT INTO `movies_session` VALUES (297, '2026-06-05 16:00:00.000000', 39.90, 150, 0, 22, 11);
INSERT INTO `movies_session` VALUES (298, '2026-06-06 16:00:00.000000', 29.90, 100, 0, 17, 11);
INSERT INTO `movies_session` VALUES (299, '2026-06-07 14:00:00.000000', 29.90, 120, 0, 23, 11);
INSERT INTO `movies_session` VALUES (300, '2026-06-08 14:00:00.000000', 29.90, 50, 0, 8, 11);
INSERT INTO `movies_session` VALUES (301, '2026-06-09 14:00:00.000000', 39.90, 150, 0, 19, 11);
INSERT INTO `movies_session` VALUES (302, '2026-05-23 16:30:00.000000', 49.90, 40, 21, 21, 12);
INSERT INTO `movies_session` VALUES (303, '2026-05-23 17:00:00.000000', 69.90, 150, 49, 16, 12);
INSERT INTO `movies_session` VALUES (304, '2026-05-23 12:45:00.000000', 49.90, 40, 33, 26, 12);
INSERT INTO `movies_session` VALUES (305, '2026-05-24 13:00:00.000000', 29.90, 40, 24, 21, 12);
INSERT INTO `movies_session` VALUES (306, '2026-05-24 13:15:00.000000', 49.90, 80, 60, 18, 12);
INSERT INTO `movies_session` VALUES (307, '2026-05-24 10:45:00.000000', 49.90, 150, 108, 22, 12);
INSERT INTO `movies_session` VALUES (308, '2026-05-25 20:30:00.000000', 59.90, 200, 110, 25, 12);
INSERT INTO `movies_session` VALUES (309, '2026-05-26 20:45:00.000000', 49.90, 40, 32, 21, 12);
INSERT INTO `movies_session` VALUES (310, '2026-05-26 14:30:00.000000', 49.90, 120, 52, 15, 12);
INSERT INTO `movies_session` VALUES (311, '2026-05-26 17:45:00.000000', 69.90, 120, 46, 23, 12);
INSERT INTO `movies_session` VALUES (312, '2026-05-27 22:00:00.000000', 69.90, 40, 30, 21, 12);
INSERT INTO `movies_session` VALUES (313, '2026-05-27 17:45:00.000000', 69.90, 80, 53, 27, 12);
INSERT INTO `movies_session` VALUES (314, '2026-05-27 15:45:00.000000', 59.90, 100, 54, 24, 12);
INSERT INTO `movies_session` VALUES (315, '2026-05-23 15:15:00.000000', 39.90, 100, 80, 17, 13);
INSERT INTO `movies_session` VALUES (316, '2026-05-23 16:15:00.000000', 49.90, 100, 30, 10, 13);
INSERT INTO `movies_session` VALUES (317, '2026-05-24 12:30:00.000000', 39.90, 50, 27, 8, 13);
INSERT INTO `movies_session` VALUES (318, '2026-05-24 12:15:00.000000', 69.90, 80, 75, 27, 13);
INSERT INTO `movies_session` VALUES (319, '2026-05-25 11:15:00.000000', 39.90, 80, 56, 27, 13);
INSERT INTO `movies_session` VALUES (320, '2026-05-25 10:00:00.000000', 59.90, 200, 134, 20, 13);
INSERT INTO `movies_session` VALUES (321, '2026-05-25 16:30:00.000000', 39.90, 200, 163, 25, 13);
INSERT INTO `movies_session` VALUES (322, '2026-05-26 19:00:00.000000', 39.90, 150, 81, 16, 13);
INSERT INTO `movies_session` VALUES (323, '2026-05-27 11:45:00.000000', 69.90, 40, 26, 26, 13);
INSERT INTO `movies_session` VALUES (324, '2026-05-27 11:15:00.000000', 69.90, 80, 38, 27, 13);
INSERT INTO `movies_session` VALUES (325, '2026-06-03 16:00:00.000000', 29.90, 200, 0, 20, 14);
INSERT INTO `movies_session` VALUES (326, '2026-06-04 19:00:00.000000', 49.90, 200, 0, 20, 14);
INSERT INTO `movies_session` VALUES (327, '2026-06-05 10:00:00.000000', 29.90, 100, 0, 17, 14);
INSERT INTO `movies_session` VALUES (328, '2026-06-06 10:00:00.000000', 39.90, 40, 0, 26, 14);
INSERT INTO `movies_session` VALUES (329, '2026-06-07 19:00:00.000000', 39.90, 200, 0, 20, 14);
INSERT INTO `movies_session` VALUES (330, '2026-06-08 20:00:00.000000', 29.90, 100, 0, 24, 14);
INSERT INTO `movies_session` VALUES (331, '2026-06-09 16:00:00.000000', 39.90, 80, 0, 27, 14);
INSERT INTO `movies_session` VALUES (332, '2026-06-10 14:00:00.000000', 49.90, 200, 0, 20, 14);
INSERT INTO `movies_session` VALUES (333, '2026-06-11 19:00:00.000000', 29.90, 40, 0, 21, 14);
INSERT INTO `movies_session` VALUES (334, '2026-06-12 14:00:00.000000', 29.90, 80, 0, 27, 14);
INSERT INTO `movies_session` VALUES (335, '2026-05-23 21:15:00.000000', 59.90, 100, 47, 17, 15);
INSERT INTO `movies_session` VALUES (336, '2026-05-23 10:00:00.000000', 49.90, 200, 99, 25, 15);
INSERT INTO `movies_session` VALUES (337, '2026-05-24 11:30:00.000000', 39.90, 40, 18, 21, 15);
INSERT INTO `movies_session` VALUES (338, '2026-05-25 20:45:00.000000', 29.90, 80, 64, 18, 15);
INSERT INTO `movies_session` VALUES (339, '2026-05-25 19:45:00.000000', 39.90, 80, 37, 18, 15);
INSERT INTO `movies_session` VALUES (340, '2026-05-25 17:30:00.000000', 69.90, 100, 71, 11, 15);
INSERT INTO `movies_session` VALUES (341, '2026-05-26 19:15:00.000000', 69.90, 40, 14, 21, 15);
INSERT INTO `movies_session` VALUES (342, '2026-05-26 19:30:00.000000', 49.90, 120, 71, 15, 15);
INSERT INTO `movies_session` VALUES (343, '2026-05-27 20:15:00.000000', 39.90, 80, 32, 27, 15);
INSERT INTO `movies_session` VALUES (344, '2026-05-27 20:30:00.000000', 59.90, 150, 100, 22, 15);
INSERT INTO `movies_session` VALUES (345, '2026-05-27 19:30:00.000000', 49.90, 150, 80, 19, 15);
INSERT INTO `movies_session` VALUES (346, '2026-05-29 19:00:00.000000', 39.90, 150, 0, 22, 16);
INSERT INTO `movies_session` VALUES (347, '2026-05-30 14:00:00.000000', 29.90, 200, 0, 20, 16);
INSERT INTO `movies_session` VALUES (348, '2026-05-31 16:00:00.000000', 29.90, 50, 0, 8, 16);
INSERT INTO `movies_session` VALUES (349, '2026-06-01 14:00:00.000000', 29.90, 120, 0, 23, 16);
INSERT INTO `movies_session` VALUES (350, '2026-06-02 20:00:00.000000', 49.90, 40, 0, 21, 16);
INSERT INTO `movies_session` VALUES (351, '2026-06-03 14:00:00.000000', 29.90, 100, 0, 24, 16);
INSERT INTO `movies_session` VALUES (352, '2026-06-04 10:00:00.000000', 29.90, 80, 0, 18, 16);
INSERT INTO `movies_session` VALUES (353, '2026-06-05 16:00:00.000000', 49.90, 150, 0, 16, 16);
INSERT INTO `movies_session` VALUES (354, '2026-06-06 19:00:00.000000', 39.90, 80, 0, 18, 16);
INSERT INTO `movies_session` VALUES (355, '2026-06-07 16:00:00.000000', 39.90, 50, 0, 8, 16);
INSERT INTO `movies_session` VALUES (356, '2026-06-08 19:00:00.000000', 49.90, 150, 0, 16, 16);
INSERT INTO `movies_session` VALUES (357, '2026-06-09 14:00:00.000000', 29.90, 200, 0, 20, 16);
INSERT INTO `movies_session` VALUES (358, '2026-06-10 10:00:00.000000', 39.90, 120, 0, 23, 16);
INSERT INTO `movies_session` VALUES (359, '2026-06-11 16:00:00.000000', 49.90, 40, 0, 21, 16);
INSERT INTO `movies_session` VALUES (360, '2026-06-12 10:00:00.000000', 39.90, 200, 0, 25, 16);
INSERT INTO `movies_session` VALUES (361, '2026-06-13 19:00:00.000000', 29.90, 100, 0, 10, 16);
INSERT INTO `movies_session` VALUES (362, '2026-06-14 10:00:00.000000', 29.90, 40, 0, 26, 16);
INSERT INTO `movies_session` VALUES (363, '2026-06-15 20:00:00.000000', 29.90, 150, 0, 22, 16);
INSERT INTO `movies_session` VALUES (364, '2026-06-07 14:00:00.000000', 39.90, 120, 0, 23, 17);
INSERT INTO `movies_session` VALUES (365, '2026-06-08 16:00:00.000000', 39.90, 100, 0, 11, 17);
INSERT INTO `movies_session` VALUES (366, '2026-06-09 14:00:00.000000', 29.90, 40, 0, 21, 17);
INSERT INTO `movies_session` VALUES (367, '2026-06-10 19:00:00.000000', 39.90, 40, 0, 21, 17);
INSERT INTO `movies_session` VALUES (368, '2026-06-11 19:00:00.000000', 49.90, 120, 0, 15, 17);
INSERT INTO `movies_session` VALUES (369, '2026-06-12 10:00:00.000000', 39.90, 100, 0, 11, 17);
INSERT INTO `movies_session` VALUES (370, '2026-06-13 14:00:00.000000', 29.90, 200, 0, 25, 17);
INSERT INTO `movies_session` VALUES (371, '2026-06-14 19:00:00.000000', 29.90, 200, 0, 20, 17);
INSERT INTO `movies_session` VALUES (372, '2026-06-15 19:00:00.000000', 39.90, 40, 0, 26, 17);
INSERT INTO `movies_session` VALUES (373, '2026-05-23 13:00:00.000000', 49.90, 120, 45, 15, 18);
INSERT INTO `movies_session` VALUES (374, '2026-05-23 22:45:00.000000', 69.90, 200, 169, 25, 18);
INSERT INTO `movies_session` VALUES (375, '2026-05-24 15:15:00.000000', 59.90, 200, 185, 20, 18);
INSERT INTO `movies_session` VALUES (376, '2026-05-24 12:45:00.000000', 59.90, 80, 26, 27, 18);
INSERT INTO `movies_session` VALUES (377, '2026-05-24 18:15:00.000000', 49.90, 100, 51, 17, 18);
INSERT INTO `movies_session` VALUES (378, '2026-05-25 09:00:00.000000', 39.90, 120, 92, 15, 18);
INSERT INTO `movies_session` VALUES (379, '2026-05-26 09:15:00.000000', 39.90, 100, 48, 17, 18);
INSERT INTO `movies_session` VALUES (380, '2026-05-26 16:00:00.000000', 49.90, 100, 68, 24, 18);
INSERT INTO `movies_session` VALUES (381, '2026-05-26 21:15:00.000000', 69.90, 120, 71, 23, 18);
INSERT INTO `movies_session` VALUES (382, '2026-05-27 14:00:00.000000', 59.90, 100, 70, 24, 18);
INSERT INTO `movies_session` VALUES (383, '2026-05-27 17:45:00.000000', 49.90, 80, 30, 18, 18);
INSERT INTO `movies_session` VALUES (384, '2026-05-27 17:15:00.000000', 49.90, 40, 13, 26, 18);
INSERT INTO `movies_session` VALUES (392, '2026-05-23 22:45:00.000000', 69.90, 80, 62, 27, 20);
INSERT INTO `movies_session` VALUES (393, '2026-05-23 22:30:00.000000', 39.90, 100, 57, 11, 20);
INSERT INTO `movies_session` VALUES (394, '2026-05-24 10:45:00.000000', 29.90, 80, 31, 27, 20);
INSERT INTO `movies_session` VALUES (395, '2026-05-24 16:45:00.000000', 49.90, 100, 61, 10, 20);
INSERT INTO `movies_session` VALUES (396, '2026-05-24 19:15:00.000000', 69.90, 100, 79, 17, 20);
INSERT INTO `movies_session` VALUES (397, '2026-05-25 14:30:00.000000', 39.90, 50, 38, 8, 20);
INSERT INTO `movies_session` VALUES (398, '2026-05-25 11:15:00.000000', 69.90, 200, 74, 20, 20);
INSERT INTO `movies_session` VALUES (399, '2026-05-25 12:00:00.000000', 29.90, 200, 171, 20, 20);
INSERT INTO `movies_session` VALUES (400, '2026-05-26 21:00:00.000000', 69.90, 150, 62, 22, 20);
INSERT INTO `movies_session` VALUES (401, '2026-05-26 13:15:00.000000', 49.90, 200, 109, 25, 20);
INSERT INTO `movies_session` VALUES (402, '2026-05-27 13:30:00.000000', 69.90, 120, 45, 15, 20);
INSERT INTO `movies_session` VALUES (403, '2026-05-27 14:15:00.000000', 49.90, 150, 85, 22, 20);
INSERT INTO `movies_session` VALUES (404, '2026-05-27 21:45:00.000000', 29.90, 200, 132, 25, 20);
INSERT INTO `movies_session` VALUES (405, '2026-05-23 09:45:00.000000', 49.90, 150, 140, 16, 21);
INSERT INTO `movies_session` VALUES (406, '2026-05-23 14:00:00.000000', 59.90, 50, 34, 8, 21);
INSERT INTO `movies_session` VALUES (407, '2026-05-24 16:15:00.000000', 29.90, 150, 141, 19, 21);
INSERT INTO `movies_session` VALUES (408, '2026-05-25 14:45:00.000000', 29.90, 100, 51, 10, 21);
INSERT INTO `movies_session` VALUES (409, '2026-05-25 12:00:00.000000', 59.90, 120, 106, 15, 21);
INSERT INTO `movies_session` VALUES (410, '2026-05-26 18:15:00.000000', 39.90, 150, 78, 16, 21);
INSERT INTO `movies_session` VALUES (411, '2026-05-27 17:00:00.000000', 29.90, 100, 32, 10, 21);
INSERT INTO `movies_session` VALUES (412, '2026-05-27 18:45:00.000000', 29.90, 100, 61, 11, 21);
INSERT INTO `movies_session` VALUES (424, '2026-05-23 17:30:00.000000', 49.90, 120, 77, 15, 23);
INSERT INTO `movies_session` VALUES (425, '2026-05-23 19:45:00.000000', 49.90, 200, 148, 20, 23);
INSERT INTO `movies_session` VALUES (426, '2026-05-24 11:30:00.000000', 59.90, 100, 69, 11, 23);
INSERT INTO `movies_session` VALUES (427, '2026-05-24 17:45:00.000000', 29.90, 100, 89, 24, 23);
INSERT INTO `movies_session` VALUES (428, '2026-05-24 20:30:00.000000', 69.90, 80, 63, 27, 23);
INSERT INTO `movies_session` VALUES (429, '2026-05-25 21:15:00.000000', 69.90, 150, 139, 19, 23);
INSERT INTO `movies_session` VALUES (430, '2026-05-25 21:00:00.000000', 59.90, 150, 59, 16, 23);
INSERT INTO `movies_session` VALUES (431, '2026-05-25 10:00:00.000000', 49.90, 100, 87, 24, 23);
INSERT INTO `movies_session` VALUES (432, '2026-05-26 12:45:00.000000', 39.90, 150, 97, 16, 23);
INSERT INTO `movies_session` VALUES (433, '2026-05-27 13:45:00.000000', 39.90, 100, 80, 17, 23);
INSERT INTO `movies_session` VALUES (434, '2026-05-27 14:45:00.000000', 29.90, 100, 39, 17, 23);
INSERT INTO `movies_session` VALUES (435, '2026-05-27 13:00:00.000000', 29.90, 100, 89, 24, 23);
INSERT INTO `movies_session` VALUES (436, '2026-05-23 20:30:00.000000', 49.90, 100, 51, 24, 24);
INSERT INTO `movies_session` VALUES (437, '2026-05-23 19:30:00.000000', 49.90, 100, 53, 11, 24);
INSERT INTO `movies_session` VALUES (438, '2026-05-23 15:30:00.000000', 49.90, 100, 91, 24, 24);
INSERT INTO `movies_session` VALUES (439, '2026-05-24 17:30:00.000000', 59.90, 150, 104, 16, 24);
INSERT INTO `movies_session` VALUES (440, '2026-05-24 13:15:00.000000', 29.90, 150, 136, 19, 24);
INSERT INTO `movies_session` VALUES (441, '2026-05-24 09:15:00.000000', 59.90, 100, 59, 17, 24);
INSERT INTO `movies_session` VALUES (442, '2026-05-25 21:30:00.000000', 69.90, 100, 68, 24, 24);
INSERT INTO `movies_session` VALUES (443, '2026-05-25 15:15:00.000000', 29.90, 40, 15, 21, 24);
INSERT INTO `movies_session` VALUES (444, '2026-05-26 16:30:00.000000', 49.90, 150, 135, 16, 24);
INSERT INTO `movies_session` VALUES (445, '2026-05-27 11:15:00.000000', 59.90, 120, 49, 23, 24);
INSERT INTO `movies_session` VALUES (461, '2026-05-23 19:00:00.000000', 69.90, 40, 13, 26, 26);
INSERT INTO `movies_session` VALUES (462, '2026-05-23 10:30:00.000000', 59.90, 100, 66, 17, 26);
INSERT INTO `movies_session` VALUES (463, '2026-05-24 17:15:00.000000', 39.90, 100, 76, 11, 26);
INSERT INTO `movies_session` VALUES (464, '2026-05-24 16:15:00.000000', 39.90, 120, 52, 23, 26);
INSERT INTO `movies_session` VALUES (465, '2026-05-25 15:30:00.000000', 29.90, 100, 45, 11, 26);
INSERT INTO `movies_session` VALUES (466, '2026-05-25 21:00:00.000000', 49.90, 80, 70, 27, 26);
INSERT INTO `movies_session` VALUES (467, '2026-05-25 12:30:00.000000', 59.90, 100, 90, 10, 26);
INSERT INTO `movies_session` VALUES (468, '2026-05-26 09:00:00.000000', 69.90, 100, 38, 24, 26);
INSERT INTO `movies_session` VALUES (469, '2026-05-26 15:30:00.000000', 39.90, 120, 55, 15, 26);
INSERT INTO `movies_session` VALUES (470, '2026-05-26 09:45:00.000000', 69.90, 150, 59, 19, 26);
INSERT INTO `movies_session` VALUES (471, '2026-05-27 14:45:00.000000', 29.90, 200, 141, 25, 26);
INSERT INTO `movies_session` VALUES (472, '2026-05-31 10:00:00.000000', 39.90, 40, 0, 26, 27);
INSERT INTO `movies_session` VALUES (473, '2026-06-01 16:00:00.000000', 29.90, 80, 0, 27, 27);
INSERT INTO `movies_session` VALUES (474, '2026-06-02 16:00:00.000000', 39.90, 200, 0, 20, 27);
INSERT INTO `movies_session` VALUES (475, '2026-06-03 19:00:00.000000', 29.90, 150, 0, 19, 27);
INSERT INTO `movies_session` VALUES (476, '2026-06-04 10:00:00.000000', 39.90, 120, 0, 23, 27);
INSERT INTO `movies_session` VALUES (477, '2026-06-05 20:00:00.000000', 49.90, 100, 0, 24, 27);
INSERT INTO `movies_session` VALUES (478, '2026-06-06 19:00:00.000000', 49.90, 40, 0, 26, 27);
INSERT INTO `movies_session` VALUES (479, '2026-06-07 19:00:00.000000', 49.90, 120, 0, 15, 27);
INSERT INTO `movies_session` VALUES (480, '2026-06-08 10:00:00.000000', 49.90, 80, 0, 27, 27);
INSERT INTO `movies_session` VALUES (481, '2026-06-09 19:00:00.000000', 29.90, 120, 0, 23, 27);
INSERT INTO `movies_session` VALUES (482, '2026-06-10 19:00:00.000000', 29.90, 150, 0, 22, 27);
INSERT INTO `movies_session` VALUES (483, '2026-06-11 10:00:00.000000', 39.90, 80, 0, 27, 27);
INSERT INTO `movies_session` VALUES (484, '2026-06-12 10:00:00.000000', 49.90, 200, 0, 25, 27);
INSERT INTO `movies_session` VALUES (485, '2026-06-13 14:00:00.000000', 39.90, 40, 0, 21, 27);
INSERT INTO `movies_session` VALUES (486, '2026-06-14 20:00:00.000000', 49.90, 150, 0, 16, 27);
INSERT INTO `movies_session` VALUES (487, '2026-05-23 13:45:00.000000', 59.90, 120, 112, 15, 28);
INSERT INTO `movies_session` VALUES (488, '2026-05-23 20:15:00.000000', 59.90, 50, 38, 8, 28);
INSERT INTO `movies_session` VALUES (489, '2026-05-23 12:30:00.000000', 49.90, 100, 86, 11, 28);
INSERT INTO `movies_session` VALUES (490, '2026-05-24 11:30:00.000000', 49.90, 50, 46, 8, 28);
INSERT INTO `movies_session` VALUES (491, '2026-05-24 17:30:00.000000', 49.90, 100, 30, 17, 28);
INSERT INTO `movies_session` VALUES (492, '2026-05-25 09:30:00.000000', 49.90, 80, 65, 27, 28);
INSERT INTO `movies_session` VALUES (493, '2026-05-25 22:30:00.000000', 29.90, 150, 82, 19, 28);
INSERT INTO `movies_session` VALUES (494, '2026-05-26 18:45:00.000000', 69.90, 50, 36, 8, 28);
INSERT INTO `movies_session` VALUES (495, '2026-05-27 14:30:00.000000', 59.90, 120, 72, 15, 28);
INSERT INTO `movies_session` VALUES (496, '2026-05-23 20:15:00.000000', 69.90, 150, 88, 19, 29);
INSERT INTO `movies_session` VALUES (497, '2026-05-23 15:00:00.000000', 49.90, 40, 17, 26, 29);
INSERT INTO `movies_session` VALUES (498, '2026-05-23 11:45:00.000000', 29.90, 150, 67, 19, 29);
INSERT INTO `movies_session` VALUES (499, '2026-05-24 22:00:00.000000', 39.90, 150, 69, 19, 29);
INSERT INTO `movies_session` VALUES (500, '2026-05-24 14:15:00.000000', 49.90, 100, 36, 11, 29);
INSERT INTO `movies_session` VALUES (501, '2026-05-25 11:30:00.000000', 39.90, 150, 66, 22, 29);
INSERT INTO `movies_session` VALUES (502, '2026-05-25 11:15:00.000000', 39.90, 120, 83, 15, 29);
INSERT INTO `movies_session` VALUES (503, '2026-05-25 21:30:00.000000', 29.90, 50, 24, 8, 29);
INSERT INTO `movies_session` VALUES (504, '2026-05-26 13:15:00.000000', 59.90, 40, 34, 21, 29);
INSERT INTO `movies_session` VALUES (505, '2026-05-26 21:00:00.000000', 59.90, 150, 130, 19, 29);
INSERT INTO `movies_session` VALUES (506, '2026-05-26 10:15:00.000000', 39.90, 120, 109, 15, 29);
INSERT INTO `movies_session` VALUES (507, '2026-05-27 12:00:00.000000', 69.90, 50, 38, 8, 29);
INSERT INTO `movies_session` VALUES (508, '2026-05-27 18:30:00.000000', 39.90, 120, 60, 15, 29);
INSERT INTO `movies_session` VALUES (509, '2026-05-27 12:00:00.000000', 59.90, 200, 91, 20, 29);
INSERT INTO `movies_session` VALUES (510, '2026-05-23 20:00:00.000000', 69.90, 40, 22, 26, 30);
INSERT INTO `movies_session` VALUES (511, '2026-05-24 10:45:00.000000', 69.90, 200, 145, 20, 30);
INSERT INTO `movies_session` VALUES (512, '2026-05-24 12:45:00.000000', 59.90, 100, 56, 11, 30);
INSERT INTO `movies_session` VALUES (513, '2026-05-25 21:30:00.000000', 69.90, 50, 33, 8, 30);
INSERT INTO `movies_session` VALUES (514, '2026-05-25 15:15:00.000000', 39.90, 200, 149, 25, 30);
INSERT INTO `movies_session` VALUES (515, '2026-05-26 21:30:00.000000', 39.90, 150, 113, 22, 30);
INSERT INTO `movies_session` VALUES (516, '2026-05-27 14:00:00.000000', 49.90, 150, 68, 22, 30);
INSERT INTO `movies_session` VALUES (517, '2026-05-27 18:15:00.000000', 59.90, 80, 61, 27, 30);
INSERT INTO `movies_session` VALUES (518, '2026-05-23 13:15:00.000000', 29.90, 100, 52, 17, 31);
INSERT INTO `movies_session` VALUES (519, '2026-05-24 16:45:00.000000', 39.90, 40, 18, 26, 31);
INSERT INTO `movies_session` VALUES (520, '2026-05-24 22:45:00.000000', 39.90, 100, 57, 17, 31);
INSERT INTO `movies_session` VALUES (521, '2026-05-25 21:30:00.000000', 29.90, 100, 67, 11, 31);
INSERT INTO `movies_session` VALUES (522, '2026-05-25 16:00:00.000000', 69.90, 100, 48, 11, 31);
INSERT INTO `movies_session` VALUES (523, '2026-05-26 15:30:00.000000', 49.90, 80, 76, 27, 31);
INSERT INTO `movies_session` VALUES (524, '2026-05-26 10:00:00.000000', 39.90, 120, 60, 15, 31);
INSERT INTO `movies_session` VALUES (525, '2026-05-26 12:00:00.000000', 59.90, 120, 62, 15, 31);
INSERT INTO `movies_session` VALUES (526, '2026-05-27 18:30:00.000000', 69.90, 120, 69, 15, 31);
INSERT INTO `movies_session` VALUES (527, '2026-05-27 09:45:00.000000', 59.90, 100, 80, 11, 31);
INSERT INTO `movies_session` VALUES (528, '2026-05-27 16:45:00.000000', 59.90, 150, 129, 22, 31);
INSERT INTO `movies_session` VALUES (529, '2026-05-23 20:45:00.000000', 59.90, 120, 69, 15, 32);
INSERT INTO `movies_session` VALUES (530, '2026-05-23 14:45:00.000000', 39.90, 100, 34, 11, 32);
INSERT INTO `movies_session` VALUES (531, '2026-05-23 10:00:00.000000', 69.90, 200, 77, 20, 32);
INSERT INTO `movies_session` VALUES (532, '2026-05-24 14:15:00.000000', 59.90, 200, 78, 20, 32);
INSERT INTO `movies_session` VALUES (533, '2026-05-24 13:00:00.000000', 59.90, 100, 80, 10, 32);
INSERT INTO `movies_session` VALUES (534, '2026-05-24 21:00:00.000000', 59.90, 150, 139, 22, 32);
INSERT INTO `movies_session` VALUES (535, '2026-05-25 14:15:00.000000', 39.90, 200, 98, 20, 32);
INSERT INTO `movies_session` VALUES (536, '2026-05-25 16:00:00.000000', 49.90, 40, 29, 26, 32);
INSERT INTO `movies_session` VALUES (537, '2026-05-25 18:00:00.000000', 69.90, 150, 102, 22, 32);
INSERT INTO `movies_session` VALUES (538, '2026-05-26 11:15:00.000000', 29.90, 150, 65, 22, 32);
INSERT INTO `movies_session` VALUES (539, '2026-05-26 16:15:00.000000', 39.90, 100, 61, 10, 32);
INSERT INTO `movies_session` VALUES (540, '2026-05-26 19:00:00.000000', 29.90, 80, 50, 18, 32);
INSERT INTO `movies_session` VALUES (541, '2026-05-27 14:30:00.000000', 59.90, 200, 119, 20, 32);
INSERT INTO `movies_session` VALUES (542, '2026-05-27 13:45:00.000000', 69.90, 100, 49, 10, 32);
INSERT INTO `movies_session` VALUES (543, '2026-05-27 20:15:00.000000', 39.90, 100, 73, 10, 32);
INSERT INTO `movies_session` VALUES (544, '2026-05-23 10:30:00.000000', 69.90, 80, 27, 27, 33);
INSERT INTO `movies_session` VALUES (545, '2026-05-23 09:45:00.000000', 49.90, 150, 133, 16, 33);
INSERT INTO `movies_session` VALUES (546, '2026-05-23 17:45:00.000000', 59.90, 40, 26, 26, 33);
INSERT INTO `movies_session` VALUES (547, '2026-05-24 19:45:00.000000', 39.90, 100, 46, 11, 33);
INSERT INTO `movies_session` VALUES (548, '2026-05-24 09:00:00.000000', 69.90, 40, 36, 21, 33);
INSERT INTO `movies_session` VALUES (549, '2026-05-25 16:15:00.000000', 39.90, 50, 33, 8, 33);
INSERT INTO `movies_session` VALUES (550, '2026-05-26 20:30:00.000000', 29.90, 150, 96, 16, 33);
INSERT INTO `movies_session` VALUES (551, '2026-05-26 20:15:00.000000', 59.90, 40, 24, 26, 33);
INSERT INTO `movies_session` VALUES (552, '2026-05-26 18:45:00.000000', 59.90, 80, 31, 27, 33);
INSERT INTO `movies_session` VALUES (553, '2026-05-27 21:15:00.000000', 49.90, 40, 30, 26, 33);
INSERT INTO `movies_session` VALUES (554, '2026-05-27 12:00:00.000000', 39.90, 40, 31, 26, 33);
INSERT INTO `movies_session` VALUES (573, '2026-05-23 09:30:00.000000', 59.90, 100, 71, 11, 35);
INSERT INTO `movies_session` VALUES (574, '2026-05-24 09:00:00.000000', 29.90, 150, 105, 19, 35);
INSERT INTO `movies_session` VALUES (575, '2026-05-25 18:00:00.000000', 59.90, 50, 41, 8, 35);
INSERT INTO `movies_session` VALUES (576, '2026-05-25 15:45:00.000000', 29.90, 80, 75, 27, 35);
INSERT INTO `movies_session` VALUES (577, '2026-05-25 14:00:00.000000', 59.90, 120, 40, 23, 35);
INSERT INTO `movies_session` VALUES (578, '2026-05-26 17:00:00.000000', 29.90, 120, 91, 15, 35);
INSERT INTO `movies_session` VALUES (579, '2026-05-26 21:45:00.000000', 69.90, 80, 64, 18, 35);
INSERT INTO `movies_session` VALUES (580, '2026-05-27 14:45:00.000000', 69.90, 120, 69, 15, 35);
INSERT INTO `movies_session` VALUES (581, '2026-05-27 09:45:00.000000', 69.90, 200, 72, 25, 35);
INSERT INTO `movies_session` VALUES (582, '2026-05-27 10:00:00.000000', 49.90, 40, 18, 26, 35);
INSERT INTO `movies_session` VALUES (599, '2026-05-23 09:45:00.000000', 69.90, 120, 51, 15, 37);
INSERT INTO `movies_session` VALUES (600, '2026-05-23 17:30:00.000000', 59.90, 100, 31, 10, 37);
INSERT INTO `movies_session` VALUES (601, '2026-05-23 13:15:00.000000', 39.90, 100, 91, 10, 37);
INSERT INTO `movies_session` VALUES (602, '2026-05-24 11:15:00.000000', 29.90, 200, 154, 25, 37);
INSERT INTO `movies_session` VALUES (603, '2026-05-24 13:00:00.000000', 59.90, 120, 58, 15, 37);
INSERT INTO `movies_session` VALUES (604, '2026-05-25 11:45:00.000000', 29.90, 80, 24, 27, 37);
INSERT INTO `movies_session` VALUES (605, '2026-05-26 17:30:00.000000', 29.90, 100, 94, 11, 37);
INSERT INTO `movies_session` VALUES (606, '2026-05-27 15:30:00.000000', 59.90, 120, 41, 15, 37);
INSERT INTO `movies_session` VALUES (925, '2026-06-28 09:00:00.000000', 119.90, 200, 89, 25, 35);
INSERT INTO `movies_session` VALUES (924, '2026-07-08 16:30:00.000000', 119.90, 150, 82, 16, 35);
INSERT INTO `movies_session` VALUES (923, '2026-06-12 22:00:00.000000', 119.90, 200, 75, 25, 35);
INSERT INTO `movies_session` VALUES (922, '2026-09-09 22:30:00.000000', 79.90, 100, 56, 10, 35);
INSERT INTO `movies_session` VALUES (921, '2026-09-10 22:30:00.000000', 99.90, 200, 77, 20, 35);
INSERT INTO `movies_session` VALUES (920, '2026-06-19 15:45:00.000000', 69.90, 150, 57, 22, 35);
INSERT INTO `movies_session` VALUES (919, '2026-07-09 11:00:00.000000', 129.90, 100, 88, 17, 35);
INSERT INTO `movies_session` VALUES (918, '2026-08-23 19:30:00.000000', 99.90, 100, 66, 11, 33);
INSERT INTO `movies_session` VALUES (908, '2026-08-23 20:30:00.000000', 99.90, 40, 36, 21, 32);
INSERT INTO `movies_session` VALUES (907, '2026-08-06 16:15:00.000000', 69.90, 100, 49, 17, 32);
INSERT INTO `movies_session` VALUES (906, '2026-06-06 19:45:00.000000', 89.90, 40, 13, 26, 32);
INSERT INTO `movies_session` VALUES (905, '2026-06-11 09:15:00.000000', 129.90, 150, 132, 22, 32);
INSERT INTO `movies_session` VALUES (904, '2026-08-24 18:45:00.000000', 139.90, 40, 16, 26, 32);
INSERT INTO `movies_session` VALUES (903, '2026-07-20 10:00:00.000000', 109.90, 40, 36, 26, 32);
INSERT INTO `movies_session` VALUES (902, '2026-09-09 09:00:00.000000', 139.90, 100, 76, 24, 31);
INSERT INTO `movies_session` VALUES (901, '2026-06-07 15:45:00.000000', 129.90, 100, 42, 11, 31);
INSERT INTO `movies_session` VALUES (900, '2026-07-25 11:00:00.000000', 99.90, 100, 58, 11, 31);
INSERT INTO `movies_session` VALUES (899, '2026-07-28 16:15:00.000000', 99.90, 150, 67, 22, 31);
INSERT INTO `movies_session` VALUES (898, '2026-07-22 09:30:00.000000', 109.90, 40, 24, 21, 31);
INSERT INTO `movies_session` VALUES (888, '2026-09-22 11:30:00.000000', 69.90, 40, 23, 21, 29);
INSERT INTO `movies_session` VALUES (887, '2026-07-23 09:45:00.000000', 79.90, 80, 55, 18, 29);
INSERT INTO `movies_session` VALUES (886, '2026-07-10 10:45:00.000000', 119.90, 50, 29, 8, 29);
INSERT INTO `movies_session` VALUES (885, '2026-07-28 19:15:00.000000', 119.90, 200, 79, 20, 29);
INSERT INTO `movies_session` VALUES (884, '2026-08-01 13:15:00.000000', 129.90, 100, 68, 11, 29);
INSERT INTO `movies_session` VALUES (883, '2026-09-28 14:00:00.000000', 109.90, 100, 54, 11, 29);
INSERT INTO `movies_session` VALUES (882, '2026-07-26 11:30:00.000000', 109.90, 100, 84, 24, 29);
INSERT INTO `movies_session` VALUES (871, '2026-06-28 14:45:00.000000', 119.90, 100, 48, 17, 26);
INSERT INTO `movies_session` VALUES (870, '2026-09-15 18:45:00.000000', 149.90, 120, 62, 15, 26);
INSERT INTO `movies_session` VALUES (869, '2026-07-24 20:45:00.000000', 79.90, 120, 73, 23, 26);
INSERT INTO `movies_session` VALUES (868, '2026-08-26 16:15:00.000000', 149.90, 100, 67, 11, 26);
INSERT INTO `movies_session` VALUES (867, '2026-09-17 22:45:00.000000', 109.90, 100, 43, 11, 26);
INSERT INTO `movies_session` VALUES (866, '2026-07-22 15:00:00.000000', 69.90, 80, 62, 27, 26);
INSERT INTO `movies_session` VALUES (865, '2026-06-06 16:30:00.000000', 109.90, 100, 68, 24, 26);
INSERT INTO `movies_session` VALUES (864, '2026-06-25 09:45:00.000000', 79.90, 80, 66, 27, 26);
INSERT INTO `movies_session` VALUES (863, '2026-07-28 20:15:00.000000', 149.90, 150, 125, 16, 26);
INSERT INTO `movies_session` VALUES (862, '2026-07-24 16:00:00.000000', 99.90, 120, 37, 15, 24);
INSERT INTO `movies_session` VALUES (861, '2026-07-06 20:00:00.000000', 109.90, 200, 126, 25, 24);
INSERT INTO `movies_session` VALUES (860, '2026-06-09 20:00:00.000000', 69.90, 80, 72, 27, 24);
INSERT INTO `movies_session` VALUES (840, '2026-09-19 19:00:00.000000', 89.90, 80, 48, 18, 21);
INSERT INTO `movies_session` VALUES (839, '2026-08-28 09:00:00.000000', 119.90, 120, 94, 23, 21);
INSERT INTO `movies_session` VALUES (838, '2026-09-01 13:15:00.000000', 79.90, 200, 126, 25, 21);
INSERT INTO `movies_session` VALUES (837, '2026-06-28 18:30:00.000000', 149.90, 100, 59, 11, 21);
INSERT INTO `movies_session` VALUES (836, '2026-08-11 16:45:00.000000', 129.90, 150, 63, 16, 21);
INSERT INTO `movies_session` VALUES (835, '2026-06-26 16:30:00.000000', 119.90, 40, 17, 21, 21);
INSERT INTO `movies_session` VALUES (834, '2026-09-20 15:00:00.000000', 129.90, 100, 39, 24, 21);
INSERT INTO `movies_session` VALUES (833, '2026-06-24 20:00:00.000000', 89.90, 200, 107, 25, 21);
INSERT INTO `movies_session` VALUES (832, '2026-08-09 14:15:00.000000', 99.90, 200, 126, 25, 20);
INSERT INTO `movies_session` VALUES (831, '2026-08-10 09:45:00.000000', 119.90, 40, 20, 21, 20);
INSERT INTO `movies_session` VALUES (830, '2026-08-12 16:45:00.000000', 69.90, 100, 47, 10, 20);
INSERT INTO `movies_session` VALUES (829, '2026-09-08 13:15:00.000000', 89.90, 100, 62, 11, 20);
INSERT INTO `movies_session` VALUES (809, '2026-09-15 11:00:00.000000', 99.90, 150, 49, 16, 15);
INSERT INTO `movies_session` VALUES (808, '2026-08-09 10:30:00.000000', 89.90, 100, 44, 24, 15);
INSERT INTO `movies_session` VALUES (807, '2026-09-01 19:00:00.000000', 109.90, 120, 90, 23, 15);
INSERT INTO `movies_session` VALUES (806, '2026-08-25 16:45:00.000000', 109.90, 50, 39, 8, 15);
INSERT INTO `movies_session` VALUES (805, '2026-09-16 10:45:00.000000', 139.90, 80, 72, 18, 13);
INSERT INTO `movies_session` VALUES (804, '2026-08-09 18:00:00.000000', 109.90, 120, 60, 23, 13);
INSERT INTO `movies_session` VALUES (803, '2026-09-12 20:15:00.000000', 79.90, 150, 92, 19, 13);
INSERT INTO `movies_session` VALUES (802, '2026-06-09 16:30:00.000000', 139.90, 120, 55, 15, 13);
INSERT INTO `movies_session` VALUES (783, '2026-09-17 14:00:00.000000', 99.90, 120, 38, 23, 10);
INSERT INTO `movies_session` VALUES (782, '2026-08-09 18:15:00.000000', 69.90, 150, 83, 19, 10);
INSERT INTO `movies_session` VALUES (781, '2026-09-08 20:45:00.000000', 119.90, 100, 74, 24, 10);
INSERT INTO `movies_session` VALUES (780, '2026-07-03 09:00:00.000000', 119.90, 120, 69, 23, 10);
INSERT INTO `movies_session` VALUES (779, '2026-08-27 19:30:00.000000', 99.90, 100, 55, 24, 9);
INSERT INTO `movies_session` VALUES (778, '2026-07-21 10:45:00.000000', 79.90, 120, 75, 23, 9);
INSERT INTO `movies_session` VALUES (777, '2026-06-19 22:15:00.000000', 89.90, 150, 135, 16, 9);
INSERT INTO `movies_session` VALUES (776, '2026-09-02 13:15:00.000000', 119.90, 200, 110, 25, 9);
INSERT INTO `movies_session` VALUES (754, '2026-07-05 11:15:00.000000', 139.90, 100, 53, 24, 7);
INSERT INTO `movies_session` VALUES (753, '2026-08-01 15:30:00.000000', 149.90, 100, 43, 11, 6);
INSERT INTO `movies_session` VALUES (752, '2026-06-16 22:45:00.000000', 109.90, 80, 63, 27, 6);
INSERT INTO `movies_session` VALUES (751, '2026-08-12 10:30:00.000000', 109.90, 40, 17, 21, 6);
INSERT INTO `movies_session` VALUES (750, '2026-07-28 13:15:00.000000', 129.90, 100, 53, 17, 6);
INSERT INTO `movies_session` VALUES (749, '2026-06-03 16:15:00.000000', 149.90, 80, 61, 18, 6);
INSERT INTO `movies_session` VALUES (748, '2026-08-08 14:00:00.000000', 119.90, 200, 63, 25, 6);
INSERT INTO `movies_session` VALUES (747, '2026-08-15 11:00:00.000000', 129.90, 150, 59, 16, 6);
INSERT INTO `movies_session` VALUES (746, '2026-06-11 15:45:00.000000', 139.90, 100, 79, 24, 6);
INSERT INTO `movies_session` VALUES (745, '2026-09-16 18:45:00.000000', 69.90, 150, 133, 19, 6);
INSERT INTO `movies_session` VALUES (744, '2026-06-25 19:30:00.000000', 119.90, 100, 84, 11, 6);
INSERT INTO `movies_session` VALUES (743, '2026-06-24 22:00:00.000000', 89.90, 100, 38, 24, 2);
INSERT INTO `movies_session` VALUES (742, '2026-07-28 18:45:00.000000', 69.90, 80, 29, 18, 2);
INSERT INTO `movies_session` VALUES (741, '2026-09-04 22:45:00.000000', 99.90, 150, 69, 22, 2);
INSERT INTO `movies_session` VALUES (740, '2026-07-13 14:30:00.000000', 89.90, 50, 42, 8, 2);
INSERT INTO `movies_session` VALUES (739, '2026-07-08 19:00:00.000000', 149.90, 200, 180, 20, 2);
INSERT INTO `movies_session` VALUES (738, '2026-07-22 15:45:00.000000', 129.90, 150, 74, 19, 2);
INSERT INTO `movies_session` VALUES (737, '2026-07-23 11:15:00.000000', 79.90, 200, 65, 20, 2);
INSERT INTO `movies_session` VALUES (736, '2026-06-23 10:30:00.000000', 139.90, 150, 89, 22, 2);
INSERT INTO `movies_session` VALUES (735, '2026-08-20 19:45:00.000000', 129.90, 150, 129, 19, 2);

-- ----------------------------
-- Table structure for movies_wantrecord
-- ----------------------------
DROP TABLE IF EXISTS `movies_wantrecord`;
CREATE TABLE `movies_wantrecord`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `created_at` datetime(6) NOT NULL,
  `movie_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `movies_wantrecord_user_id_movie_id_993f07b6_uniq`(`user_id`, `movie_id`) USING BTREE,
  INDEX `movies_wantrecord_movie_id_81635f14`(`movie_id`) USING BTREE,
  INDEX `movies_wantrecord_user_id_9e90091c`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of movies_wantrecord
-- ----------------------------
INSERT INTO `movies_wantrecord` VALUES (2, '2026-05-23 15:39:20.830676', 10, 1);
INSERT INTO `movies_wantrecord` VALUES (3, '2026-05-23 15:39:24.765136', 4, 1);
INSERT INTO `movies_wantrecord` VALUES (4, '2026-05-23 15:40:32.800867', 16, 1);
INSERT INTO `movies_wantrecord` VALUES (5, '2026-05-23 16:01:46.131363', 18, 8);
INSERT INTO `movies_wantrecord` VALUES (6, '2026-05-23 16:06:26.138392', 7, 9);
INSERT INTO `movies_wantrecord` VALUES (7, '2026-05-23 16:06:43.077130', 24, 9);

-- ----------------------------
-- Table structure for orders_order
-- ----------------------------
DROP TABLE IF EXISTS `orders_order`;
CREATE TABLE `orders_order`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_no` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` decimal(10, 2) NOT NULL,
  `status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `paid_at` datetime(6) NULL DEFAULT NULL,
  `cancelled_at` datetime(6) NULL DEFAULT NULL,
  `session_id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_no`(`order_no`) USING BTREE,
  INDEX `orders_order_session_id_f018568b`(`session_id`) USING BTREE,
  INDEX `orders_order_user_id_e9b59eb1`(`user_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders_order
-- ----------------------------
INSERT INTO `orders_order` VALUES (12, 'E8DB067B96E44472863B', 1, 49.90, 'cancelled', '2026-05-20 16:25:24.506877', NULL, '2026-05-20 16:25:24.513287', 6, 8);
INSERT INTO `orders_order` VALUES (9, 'AB0B8EF8527E410793D4', 2, 99.80, 'paid', '2026-05-20 16:23:31.399386', '2026-05-20 16:23:31.429906', NULL, 6, 8);
INSERT INTO `orders_order` VALUES (11, '8800E285CF7A43679D35', 2, 99.80, 'paid', '2026-05-20 16:25:24.460492', '2026-05-20 16:25:24.493971', NULL, 6, 8);
INSERT INTO `orders_order` VALUES (10, 'A15A84F4863D43EDA491', 1, 49.90, 'cancelled', '2026-05-20 16:23:31.442223', NULL, '2026-05-20 16:23:31.448906', 6, 8);
INSERT INTO `orders_order` VALUES (13, '8BF3AEA0081E483C848F', 2, 99.80, 'paid', '2026-05-20 16:25:32.683656', '2026-05-20 16:25:32.718776', NULL, 6, 8);
INSERT INTO `orders_order` VALUES (14, '5EB92F48EF3740D08D75', 1, 49.90, 'cancelled', '2026-05-20 16:25:32.732958', NULL, '2026-05-20 16:25:32.739296', 6, 8);
INSERT INTO `orders_order` VALUES (15, 'DDA0FA92234440A2896E', 1, 49.90, 'paid', '2026-05-21 15:03:44.933963', '2026-05-21 15:03:46.839062', NULL, 6, 1);
INSERT INTO `orders_order` VALUES (16, '4754B40D5C404DA489D5', 1, 49.90, 'paid', '2026-05-21 15:49:34.990436', '2026-05-21 15:49:39.683731', NULL, 6, 8);
INSERT INTO `orders_order` VALUES (17, 'EDED1339C4A542618B40', 3, 149.70, 'paid', '2026-05-21 15:54:38.793244', '2026-05-21 15:54:40.450227', NULL, 6, 8);
INSERT INTO `orders_order` VALUES (18, '58D8E65A61B147F38D83', 3, 149.70, 'cancelled', '2026-05-21 16:03:10.328132', NULL, '2026-05-21 16:03:12.974456', 12, 8);
INSERT INTO `orders_order` VALUES (19, '1617B8BCE7D24CA190DE', 4, 199.60, 'paid', '2026-05-23 07:59:39.283417', '2026-05-23 07:59:43.276057', NULL, 6, 8);
INSERT INTO `orders_order` VALUES (20, '5D1E7E91777347BDA2AD', 2, 99.80, 'paid', '2026-05-23 08:06:55.699758', '2026-05-21 02:00:00.000000', NULL, 6, 1);
INSERT INTO `orders_order` VALUES (21, '7E013B14BA004AF5878B', 3, 149.70, 'paid', '2026-05-23 08:06:55.702205', '2026-05-21 11:06:44.000000', NULL, 12, 1);
INSERT INTO `orders_order` VALUES (22, 'C5208E6FD2AF40E8BEE4', 2, 140.00, 'paid', '2026-05-23 08:06:55.703204', '2026-05-19 12:01:52.000000', NULL, 8, 1);
INSERT INTO `orders_order` VALUES (23, '3E1533BF4CBF4AB3A52C', 3, 210.00, 'paid', '2026-05-23 08:10:15.092316', '2026-05-19 16:01:52.000000', NULL, 8, 1);
INSERT INTO `orders_order` VALUES (27, '8C30B1C028E046F6A09C', 2, 119.80, 'paid', '2026-06-23 14:02:09.278931', '2026-06-23 14:02:10.489885', NULL, 573, 8);
INSERT INTO `orders_order` VALUES (25, 'E8EEAD07BAB44EEEAD2D', 6, 359.40, 'paid', '2026-05-23 15:37:35.125489', '2026-05-23 15:37:36.232432', NULL, 426, 1);
INSERT INTO `orders_order` VALUES (26, 'FC2215ACAB054D6483E2', 9, 359.10, 'paid', '2026-05-23 15:37:51.366206', '2026-05-23 15:37:52.837411', NULL, 464, 1);

-- ----------------------------
-- Table structure for users_user
-- ----------------------------
DROP TABLE IF EXISTS `users_user`;
CREATE TABLE `users_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) NULL DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users_user
-- ----------------------------
INSERT INTO `users_user` VALUES (1, 'pbkdf2_sha256$1200000$ZDIJoi68XyEXpASkyQ9hDI$OQWR+zppzTH05gIkPCrtELdAjQroXHjQKlJMBK9p/dE=', '2026-05-20 16:04:18.966283', 1, 'admin', '', '', '', 1, 1, '2026-05-19 14:20:21.721874', NULL, 'avatars/8cd36fb340dff140067438a6bedd03b22bbd361af42e1-RJSiPp.png');
INSERT INTO `users_user` VALUES (9, 'pbkdf2_sha256$600000$UW5Mhs7xeY3N2CTQBHVtk0$iJYKcv7l2QrBT4scwAqto7P4JXBtj5QY6cgFGUwO8Wk=', NULL, 0, 'user2', '', '', '', 0, 1, '2026-05-23 08:26:58.636165', '', '');
INSERT INTO `users_user` VALUES (8, 'pbkdf2_sha256$600000$hgnVjwy6SKfQ6q0rEmcWC1$R5afRCqKhrQ2QHtXMBxyF2vzjBqM/lQ/UEAm9fsuCEI=', NULL, 0, 'user1', '', '', 'user@test.com', 0, 1, '2026-05-20 16:23:30.111587', '111111', 'avatars/1bd62ef7e9380286536e7c1c7b15a81ac392f475af759-kY0xTL.png');

-- ----------------------------
-- Table structure for users_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `users_user_groups`;
CREATE TABLE `users_user_groups`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_groups_user_id_group_id_b88eab82_uniq`(`user_id`, `group_id`) USING BTREE,
  INDEX `users_user_groups_user_id_5f6f5a90`(`user_id`) USING BTREE,
  INDEX `users_user_groups_group_id_9afc8d0e`(`group_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of users_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for users_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `users_user_user_permissions`;
CREATE TABLE `users_user_user_permissions`  (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_user_user_permissions_user_id_permission_id_43338c45_uniq`(`user_id`, `permission_id`) USING BTREE,
  INDEX `users_user_user_permissions_user_id_20aca447`(`user_id`) USING BTREE,
  INDEX `users_user_user_permissions_permission_id_0b93982e`(`permission_id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Fixed;

-- ----------------------------
-- Records of users_user_user_permissions
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
