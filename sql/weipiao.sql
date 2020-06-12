SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_admin_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_menu`;
CREATE TABLE `t_admin_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '具体权限',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin_menu
-- ----------------------------
INSERT INTO `t_admin_menu` VALUES (1, '用户管理');
INSERT INTO `t_admin_menu` VALUES (2, '电影管理');
INSERT INTO `t_admin_menu` VALUES (3, '影院管理');
INSERT INTO `t_admin_menu` VALUES (4, '影厅管理');
INSERT INTO `t_admin_menu` VALUES (5, '排片管理');
INSERT INTO `t_admin_menu` VALUES (6, '评论管理');
INSERT INTO `t_admin_menu` VALUES (7, '小吃管理');
INSERT INTO `t_admin_menu` VALUES (8, '广告管理');
INSERT INTO `t_admin_menu` VALUES (9, '订单管理');
INSERT INTO `t_admin_menu` VALUES (10, '上传文件');

-- ----------------------------
-- Table structure for t_admin_role
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_role`;
CREATE TABLE `t_admin_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin_role
-- ----------------------------
INSERT INTO `t_admin_role` VALUES (1, '管理员');
INSERT INTO `t_admin_role` VALUES (2, '商家');

-- ----------------------------
-- Table structure for t_admin_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_role_menu`;
CREATE TABLE `t_admin_role_menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  INDEX `menu_id`(`menu_id`) USING BTREE,
  CONSTRAINT `t_admin_role_menu_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `t_admin_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_admin_role_menu_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `t_admin_menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin_role_menu
-- ----------------------------
INSERT INTO `t_admin_role_menu` VALUES (1, 1, 1);
INSERT INTO `t_admin_role_menu` VALUES (2, 2, 4);
INSERT INTO `t_admin_role_menu` VALUES (3, 1, 2);
INSERT INTO `t_admin_role_menu` VALUES (4, 1, 3);
INSERT INTO `t_admin_role_menu` VALUES (5, 1, 4);
INSERT INTO `t_admin_role_menu` VALUES (6, 1, 5);
INSERT INTO `t_admin_role_menu` VALUES (7, 1, 6);
INSERT INTO `t_admin_role_menu` VALUES (8, 1, 7);
INSERT INTO `t_admin_role_menu` VALUES (9, 1, 8);
INSERT INTO `t_admin_role_menu` VALUES (10, 1, 9);
INSERT INTO `t_admin_role_menu` VALUES (11, 2, 5);
INSERT INTO `t_admin_role_menu` VALUES (12, 2, 7);
INSERT INTO `t_admin_role_menu` VALUES (13, 2, 9);
INSERT INTO `t_admin_role_menu` VALUES (14, 1, 10);
INSERT INTO `t_admin_role_menu` VALUES (15, 2, 10);

-- ----------------------------
-- Table structure for t_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_user`;
CREATE TABLE `t_admin_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '头像',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `cineam_id` int(11) NULL DEFAULT NULL COMMENT '相关影院',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin_user
-- ----------------------------
INSERT INTO `t_admin_user` VALUES (1, 'https://mokespace.cn/kodexplorer/index.php?share/fileProxy&user=1&sid=MEyKNFbx', 'MOKE', 'moke', '91331054', NULL);
INSERT INTO `t_admin_user` VALUES (2, 'https://mokespace.cn/kodexplorer/index.php?share/fileProxy&user=1&sid=MEyKNFbx', '太平洋影城（深圳新城汇店）', 'test1', '123456', 18);
INSERT INTO `t_admin_user` VALUES (4, 'https://mokespace.cn/kodexplorer/index.php?share/fileProxy&user=1&sid=MEyKNFbx', '华影金娱巨幕电影城', 'test2', '123456', 2);

-- ----------------------------
-- Table structure for t_admin_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_admin_user_role`;
CREATE TABLE `t_admin_user_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `admin_user_id`(`admin_user_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `t_admin_user_role_ibfk_1` FOREIGN KEY (`admin_user_id`) REFERENCES `t_admin_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_admin_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `t_admin_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_admin_user_role
-- ----------------------------
INSERT INTO `t_admin_user_role` VALUES (1, 1, 1);
INSERT INTO `t_admin_user_role` VALUES (2, 2, 2);
INSERT INTO `t_admin_user_role` VALUES (3, 4, 2);

-- ----------------------------
-- Table structure for t_banner
-- ----------------------------
DROP TABLE IF EXISTS `t_banner`;
CREATE TABLE `t_banner`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '轮播图',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '跳转链接',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_banner
-- ----------------------------
INSERT INTO `t_banner` VALUES (6, 'https://mokespace.cn/weimai/upFile/banner_1.jpg', NULL);
INSERT INTO `t_banner` VALUES (7, 'https://mokespace.cn/weimai/upFile/banner_3.jpg', NULL);
INSERT INTO `t_banner` VALUES (8, 'https://mokespace.cn/weimai/upFile/banner_2.jpg', NULL);
INSERT INTO `t_banner` VALUES (9, 'https://mokespace.cn/weimai/upFile/banner_4.jpg', NULL);

-- ----------------------------
-- Table structure for t_cinema
-- ----------------------------
DROP TABLE IF EXISTS `t_cinema`;
CREATE TABLE `t_cinema`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影院名',
  `brand_id` int(11) NULL DEFAULT NULL COMMENT '所属品牌',
  `addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影院地址',
  `latitude` decimal(65, 5) NOT NULL COMMENT '纬度',
  `longitude` decimal(65, 5) NOT NULL COMMENT '经度',
  `endorse` bit(1) NOT NULL COMMENT '1支持退票',
  `allowRefund` bit(1) NOT NULL COMMENT '1支持改签',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `location`(`latitude`, `longitude`) USING BTREE,
  INDEX `brand_id`(`brand_id`) USING BTREE,
  CONSTRAINT `t_cinema_ibfk_1` FOREIGN KEY (`brand_id`) REFERENCES `t_cinema_brand` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_cinema
-- ----------------------------
INSERT INTO `t_cinema` VALUES (1, '星美国际影城（普宁大道店）', 2, '揭阳市普宁市普宁大道商业街北侧大南山路口西侧第一幢新达强电器大厦', 23.27740, 116.17409, b'1', b'0');
INSERT INTO `t_cinema` VALUES (2, '华影金娱巨幕电影城', 7, '揭阳市普宁洪阳镇城徽往揭阳方向50米处美佳乐购物中心商业街J028号', 23.43059, 116.22160, b'1', b'1');
INSERT INTO `t_cinema` VALUES (3, '中影国际影城（普宁万泰汇店）', 3, '揭阳市普宁流沙环市北路普宁广场万泰汇购物中心5楼（近流沙东路）', 23.31242, 116.16232, b'1', b'1');
INSERT INTO `t_cinema` VALUES (4, '万众影城', 6, '广东省揭阳市榕城区空港经济区炮台镇金兴路明珠中区市场1层1号', 23.51629, 116.48802, b'1', b'0');
INSERT INTO `t_cinema` VALUES (5, '大地影院（美佳乐店）', 1, '揭阳市普宁流沙镇广达东路美佳乐购物广场5楼', 23.30016, 116.14745, b'0', b'0');
INSERT INTO `t_cinema` VALUES (6, '流沙电影城', 10, '揭阳市普宁流沙东中华路106号（中华新城）', 23.29616, 116.17223, b'0', b'1');
INSERT INTO `t_cinema` VALUES (7, '华映国际影城', 8, '揭阳市榕城区进贤门大道44号（原东方康宁购物广场四楼）', 23.53536, 116.36288, b'0', b'1');
INSERT INTO `t_cinema` VALUES (8, '万达影城（普宁商品城店）', 4, '揭阳市普宁流沙大道东国际商品城', 23.29431, 116.19282, b'0', b'0');
INSERT INTO `t_cinema` VALUES (9, '中影佳梵国际影城', 3, '揭阳市揭西县棉湖镇兴中社区兴华路中段家家乐百货旁', 23.43914, 116.13917, b'1', b'1');
INSERT INTO `t_cinema` VALUES (10, '中影巢汇影城', 3, '揭阳市榕城区东兴仁义路八号街巢汇酒店隔壁', 23.55137, 116.36500, b'0', b'1');
INSERT INTO `t_cinema` VALUES (11, '大地影院（东山金城店）', 1, '揭阳市榕城区金城步行街体育乐园北侧沿街铺面2楼（易初莲花旁）', 23.56244, 116.37128, b'1', b'1');
INSERT INTO `t_cinema` VALUES (12, '大地影院（番禺西丽广场店）', 1, '广州市番禺区市桥街西丽南路93号西丽广场4楼（西城花园东）', 22.93630, 113.35400, b'1', b'1');
INSERT INTO `t_cinema` VALUES (13, '万达影城（南沙万达广场店）', 4, '广州市南沙区双山大道万达广场三号娱乐楼4楼', 22.79450, 113.53226, b'1', b'1');
INSERT INTO `t_cinema` VALUES (15, '万达影城（龙盛新天地店）', 4, '深圳市龙岗区龙岗街道深汕路中信龙盛新天地1栋2F（义乌小商品城）', 22.72229, 114.29622, b'1', b'1');
INSERT INTO `t_cinema` VALUES (16, '金逸影城（建安店）', 9, '深圳市宝安区建安二路河东骏丰园七巧国首层（宝润装饰城东北100米以内）', 22.58297, 113.88583, b'1', b'1');
INSERT INTO `t_cinema` VALUES (17, '大地影院（宏发大世界店）', 1, '广东省深圳市宝安区石岩宝石南路与青年路交汇处宏发购物广场二期5楼', 22.67381, 113.93020, b'1', b'0');
INSERT INTO `t_cinema` VALUES (18, '太平洋影城（深圳新城汇店）', 13, '广东省深圳市龙岗区横岗街道红棉路与横岗一号路交汇处新城汇五楼（近横岗一号路）', 22.64809, 114.19167, b'0', b'0');
INSERT INTO `t_cinema` VALUES (19, '万达影城（布吉万科红店）', 15, '广东省深圳市龙岗区布吉锦龙路与惠康路交汇处万科红生活广场二楼（惠康路口）', 22.59842, 114.12700, b'1', b'0');
INSERT INTO `t_cinema` VALUES (20, '星美影商城（福田体育公园店）', 2, '广东省深圳市福田区福强路3030号福田体育公园负一层', 22.52485, 114.03556, b'1', b'1');
INSERT INTO `t_cinema` VALUES (21, '中影国际影城（南山欢乐海岸店）', 3, '广东省深圳市南山区白石路东8号欢乐海岸曲水湾2栋A区', 22.52256, 113.99246, b'0', b'0');
INSERT INTO `t_cinema` VALUES (22, '中影UL城市影院（横岗店）', 3, '广东省深圳市龙岗区横岗街道松柏路松柏天虹四楼', 22.64942, 114.21112, b'0', b'0');
INSERT INTO `t_cinema` VALUES (23, '大地影院（观澜兴万达广场店）', 1, '龙华区观澜街道桂澜社区观澜大道419号兴万达广场5楼', 22.72447, 114.06519, b'1', b'1');
INSERT INTO `t_cinema` VALUES (24, '大地影院（宝安时代城店）', 1, '广东省深圳市宝安区海城路与宝源路交汇处时代城6楼（坪洲地铁站C出口100米）', 22.56556, 113.86815, b'1', b'1');
INSERT INTO `t_cinema` VALUES (25, '星美影商城（万科广场店）', 2, '广东省深圳市龙岗区龙翔大道7188号万科广场L3-24（吉祥地铁站C出口）', 22.71395, 114.24262, b'1', b'1');
INSERT INTO `t_cinema` VALUES (26, '星美影商城（京基IMAX店）', 2, '广东省深圳市福田区滨河大道9289号京基滨河时代南区4层', 22.52779, 114.02733, b'1', b'1');
INSERT INTO `t_cinema` VALUES (27, '百老汇影城（cocopark店）', 20, '广东省深圳市福田区福华三路CocoPark2楼（近星河国际）', 22.53155, 114.05413, b'1', b'1');

-- ----------------------------
-- Table structure for t_cinema_brand
-- ----------------------------
DROP TABLE IF EXISTS `t_cinema_brand`;
CREATE TABLE `t_cinema_brand`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `brand` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '大地影院\r\n星美国际影城\r\n中影国际影城\r\n万达影城\r\n特色厅',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_cinema_brand
-- ----------------------------
INSERT INTO `t_cinema_brand` VALUES (1, '大地影院');
INSERT INTO `t_cinema_brand` VALUES (2, '星美国际影城');
INSERT INTO `t_cinema_brand` VALUES (3, '中影国际影城');
INSERT INTO `t_cinema_brand` VALUES (4, '万达影城');
INSERT INTO `t_cinema_brand` VALUES (6, '万众影城');
INSERT INTO `t_cinema_brand` VALUES (7, '华影金娱');
INSERT INTO `t_cinema_brand` VALUES (8, '华映国际影城');
INSERT INTO `t_cinema_brand` VALUES (9, '金逸影城');
INSERT INTO `t_cinema_brand` VALUES (10, '流沙影城');
INSERT INTO `t_cinema_brand` VALUES (11, '万达影城');
INSERT INTO `t_cinema_brand` VALUES (13, '太平洋影城');
INSERT INTO `t_cinema_brand` VALUES (15, '万达影城');
INSERT INTO `t_cinema_brand` VALUES (20, '百老汇影城');

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `movie_id` int(11) NOT NULL COMMENT '电影id',
  `sc` float(255, 1) NOT NULL COMMENT '评分',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  `approve` int(255) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `calc_time` datetime(0) NOT NULL COMMENT '评论时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `t_comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_comment_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `t_movie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1, 1, 2, 8.0, '测试修改评论', 342, '2020-03-01 17:01:11');
INSERT INTO `t_comment` VALUES (17, 1, 3, 8.0, '测试评论', 12, '2020-03-01 17:54:26');
INSERT INTO `t_comment` VALUES (24, 1, 21, 9.0, '非常好看！', 10, '2020-03-01 15:33:05');
INSERT INTO `t_comment` VALUES (25, 2, 2, 8.9, '还不错', 15, '2020-03-01 12:48:27');
INSERT INTO `t_comment` VALUES (26, 2, 3, 8.5, '测试推荐', 8, '2020-03-01 13:48:56');
INSERT INTO `t_comment` VALUES (27, 2, 21, 8.0, '推荐', 8, '2020-03-01 12:49:43');
INSERT INTO `t_comment` VALUES (29, 3, 3, 8.5, '好看', 25, '2020-02-28 12:50:42');
INSERT INTO `t_comment` VALUES (35, 3, 2, 8.0, '测试推荐', 67, '2020-03-01 20:19:07');
INSERT INTO `t_comment` VALUES (37, 2, 17, 8.5, '测试推荐', 8, '2020-03-01 16:48:56');
INSERT INTO `t_comment` VALUES (39, 1, 17, 9.0, '非常好看！', 9, '2020-03-01 12:33:05');
INSERT INTO `t_comment` VALUES (40, 3, 21, 9.0, '不错', 67, '2020-03-01 18:10:22');
INSERT INTO `t_comment` VALUES (41, 2, 24, 8.2, '测试推荐', 25, '2020-03-01 10:03:59');
INSERT INTO `t_comment` VALUES (42, 3, 17, 9.5, '不错', 67, '2020-03-01 17:10:22');
INSERT INTO `t_comment` VALUES (43, 3, 24, 9.0, '推荐观看', 67, '2020-03-01 14:53:01');
INSERT INTO `t_comment` VALUES (44, 2, 18, 8.9, '强烈推荐', 25, '2020-03-01 15:53:26');
INSERT INTO `t_comment` VALUES (45, 3, 18, 8.5, '强烈推荐', 34, '2020-03-01 15:55:17');
INSERT INTO `t_comment` VALUES (46, 4, 2, 8.0, '刚刚观看', 1, '2020-03-10 15:30:28');
INSERT INTO `t_comment` VALUES (47, 5, 2, 7.9, '评论页面', 10, '2020-03-08 15:30:59');
INSERT INTO `t_comment` VALUES (48, 6, 2, 7.5, '不好看', 20, '2020-03-06 15:31:14');
INSERT INTO `t_comment` VALUES (49, 7, 2, 8.0, '一般般', 31, '2020-03-12 15:31:28');
INSERT INTO `t_comment` VALUES (50, 8, 2, 5.0, '极差', 5, '2020-03-04 16:31:58');
INSERT INTO `t_comment` VALUES (51, 9, 2, 7.8, '不太行', 7, '2020-03-07 13:32:20');

-- ----------------------------
-- Table structure for t_comment_approve
-- ----------------------------
DROP TABLE IF EXISTS `t_comment_approve`;
CREATE TABLE `t_comment_approve`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `comment_id`(`comment_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `t_comment_approve_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `t_comment` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_comment_approve_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment_approve
-- ----------------------------
INSERT INTO `t_comment_approve` VALUES (9, 1, 1);

-- ----------------------------
-- Table structure for t_days
-- ----------------------------
DROP TABLE IF EXISTS `t_days`;
CREATE TABLE `t_days`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cinema_id` int(11) NOT NULL COMMENT '所属影院',
  `movie_id` int(11) NOT NULL COMMENT '所属电影',
  `day` date NOT NULL COMMENT '档期日期',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `CinemaAndMovieAndDay`(`cinema_id`, `movie_id`, `day`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `t_days_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `t_cinema` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_days_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `t_movie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_days
-- ----------------------------
INSERT INTO `t_days` VALUES (3, 1, 2, '2020-06-07');
INSERT INTO `t_days` VALUES (29, 1, 4, '2020-06-07');
INSERT INTO `t_days` VALUES (27, 1, 4, '2020-06-08');
INSERT INTO `t_days` VALUES (28, 1, 4, '2020-06-09');
INSERT INTO `t_days` VALUES (1, 2, 2, '2020-06-07');
INSERT INTO `t_days` VALUES (6, 2, 3, '2020-06-07');
INSERT INTO `t_days` VALUES (14, 2, 4, '2020-06-07');
INSERT INTO `t_days` VALUES (8, 2, 7, '2020-06-07');
INSERT INTO `t_days` VALUES (34, 2, 22, '2020-06-07');
INSERT INTO `t_days` VALUES (56, 2, 25, '2020-06-08');
INSERT INTO `t_days` VALUES (31, 5, 3, '2020-06-07');
INSERT INTO `t_days` VALUES (19, 5, 5, '2020-06-07');
INSERT INTO `t_days` VALUES (33, 5, 21, '2020-06-07');
INSERT INTO `t_days` VALUES (13, 6, 4, '2020-06-07');
INSERT INTO `t_days` VALUES (55, 6, 22, '2020-06-08');
INSERT INTO `t_days` VALUES (2, 7, 2, '2020-06-07');
INSERT INTO `t_days` VALUES (10, 8, 3, '2020-06-07');
INSERT INTO `t_days` VALUES (37, 8, 5, '2020-06-07');
INSERT INTO `t_days` VALUES (16, 9, 5, '2020-06-07');
INSERT INTO `t_days` VALUES (5, 10, 2, '2020-06-07');
INSERT INTO `t_days` VALUES (21, 10, 2, '2020-06-08');
INSERT INTO `t_days` VALUES (22, 10, 2, '2020-06-09');
INSERT INTO `t_days` VALUES (12, 10, 4, '2020-06-07');
INSERT INTO `t_days` VALUES (18, 10, 5, '2020-06-07');
INSERT INTO `t_days` VALUES (35, 10, 24, '2020-06-07');
INSERT INTO `t_days` VALUES (36, 10, 25, '2020-06-07');
INSERT INTO `t_days` VALUES (54, 10, 34, '2020-06-08');
INSERT INTO `t_days` VALUES (7, 11, 3, '2020-06-07');
INSERT INTO `t_days` VALUES (23, 12, 2, '2020-06-07');
INSERT INTO `t_days` VALUES (25, 12, 5, '2020-06-07');
INSERT INTO `t_days` VALUES (24, 13, 5, '2020-06-07');
INSERT INTO `t_days` VALUES (48, 13, 27, '2020-06-08');
INSERT INTO `t_days` VALUES (43, 15, 5, '2020-06-08');
INSERT INTO `t_days` VALUES (42, 15, 21, '2020-06-07');
INSERT INTO `t_days` VALUES (44, 15, 21, '2020-06-08');
INSERT INTO `t_days` VALUES (41, 15, 22, '2020-06-07');
INSERT INTO `t_days` VALUES (50, 15, 29, '2020-06-09');
INSERT INTO `t_days` VALUES (52, 15, 30, '2020-06-08');
INSERT INTO `t_days` VALUES (47, 16, 27, '2020-06-08');
INSERT INTO `t_days` VALUES (49, 16, 29, '2020-06-08');
INSERT INTO `t_days` VALUES (51, 16, 30, '2020-06-08');
INSERT INTO `t_days` VALUES (40, 18, 21, '2020-06-07');
INSERT INTO `t_days` VALUES (45, 18, 21, '2020-06-08');
INSERT INTO `t_days` VALUES (39, 18, 22, '2020-06-07');
INSERT INTO `t_days` VALUES (46, 18, 22, '2020-06-08');
INSERT INTO `t_days` VALUES (53, 18, 34, '2020-06-08');
INSERT INTO `t_days` VALUES (57, 22, 27, '2020-06-08');

-- ----------------------------
-- Table structure for t_hall
-- ----------------------------
DROP TABLE IF EXISTS `t_hall`;
CREATE TABLE `t_hall`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cinema_id` int(11) NOT NULL COMMENT '所属影院',
  `hall_type_id` int(11) NULL DEFAULT NULL COMMENT '厅的特色',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cinema_id`(`cinema_id`) USING BTREE,
  INDEX `hall_type_id`(`hall_type_id`) USING BTREE,
  CONSTRAINT `t_hall_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `t_cinema` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_hall_ibfk_2` FOREIGN KEY (`hall_type_id`) REFERENCES `t_hall_type` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_hall
-- ----------------------------
INSERT INTO `t_hall` VALUES (1, 1, 2);
INSERT INTO `t_hall` VALUES (2, 1, 1);
INSERT INTO `t_hall` VALUES (3, 2, 3);
INSERT INTO `t_hall` VALUES (4, 2, 1);
INSERT INTO `t_hall` VALUES (5, 2, 3);
INSERT INTO `t_hall` VALUES (6, 5, 3);
INSERT INTO `t_hall` VALUES (7, 9, 2);
INSERT INTO `t_hall` VALUES (8, 10, 2);
INSERT INTO `t_hall` VALUES (9, 13, 2);
INSERT INTO `t_hall` VALUES (10, 16, 1);
INSERT INTO `t_hall` VALUES (11, 10, 4);
INSERT INTO `t_hall` VALUES (12, 5, 4);
INSERT INTO `t_hall` VALUES (13, 5, 2);
INSERT INTO `t_hall` VALUES (14, 8, 2);
INSERT INTO `t_hall` VALUES (15, 8, 1);
INSERT INTO `t_hall` VALUES (16, 6, 1);
INSERT INTO `t_hall` VALUES (17, 15, 1);
INSERT INTO `t_hall` VALUES (18, 18, 2);
INSERT INTO `t_hall` VALUES (19, 2, 2);
INSERT INTO `t_hall` VALUES (21, 2, 4);
INSERT INTO `t_hall` VALUES (22, 22, 4);

-- ----------------------------
-- Table structure for t_hall_type
-- ----------------------------
DROP TABLE IF EXISTS `t_hall_type`;
CREATE TABLE `t_hall_type`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hallType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '特色厅',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_hall_type
-- ----------------------------
INSERT INTO `t_hall_type` VALUES (1, 'CGS中国巨幕厅');
INSERT INTO `t_hall_type` VALUES (2, '杜比全景声厅');
INSERT INTO `t_hall_type` VALUES (3, '60帧厅');
INSERT INTO `t_hall_type` VALUES (4, '巨幕厅');

-- ----------------------------
-- Table structure for t_movie
-- ----------------------------
DROP TABLE IF EXISTS `t_movie`;
CREATE TABLE `t_movie`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '电影名',
  `enm` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影英文名',
  `cat` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影类型',
  `dir` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '导演',
  `img` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '宣传海报',
  `version` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '播放类型（3d / imax）',
  `dra` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '剧情描述',
  `sc` double(255, 1) NULL DEFAULT 0.0 COMMENT '评分',
  `snum` int(255) NULL DEFAULT 0 COMMENT '评分人数',
  `star` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '明星演员',
  `src` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '上映地区',
  `language` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '语言',
  `dur` int(255) NULL DEFAULT NULL COMMENT '电影时长',
  `globalReleased` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否上映过',
  `wish` bigint(255) NULL DEFAULT 0 COMMENT '想看的人数',
  `watched` int(255) NULL DEFAULT 0 COMMENT '观看人数',
  `rt` date NULL DEFAULT NULL COMMENT '上映日期',
  `showst` int(255) NOT NULL DEFAULT 1 COMMENT '状态：1想看 2预售 3上映 ',
  `video_img` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预告视频图片',
  `video_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预告视频的名字',
  `video_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '预告视频的url',
  `photos` varchar(2000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影海报',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_movie
-- ----------------------------
INSERT INTO `t_movie` VALUES (2, '少年的你', 'Better Days', '剧情', '曾国祥', 'https://mokespace.cn/weimai/upFile/7b437e3a0d08d10e374ddc34f71.jpg', 'v2d imax', '一场高考前夕的校园意外，改变了两个少年的命运。 陈念（周冬雨 饰）性格内向，是学校里的优等生，努力复习、考上好大学是高三的她唯一的念头。同班同学的意外坠楼牵扯出一连串不为人知的故事，陈念也被一点点卷入其中……在她最孤独的时刻，一个叫“小北”（易烊千玺 饰）的少年闯入了她的世界……大多数人的18岁都是明媚、快乐的，而他们却在18岁这个夏天提前尝到了成人世界的漠然。一场秘而不宣的“战斗”正在上演，他们将一起守护少年的尊严。', 9.0, 456452, '周冬雨，易烊千玺，尹昉', '中国大陆', '国语', 135, b'1', 20013, 5123147, '2020-02-27', 3, 'https://mokespace.cn/weimai/upFile/7326b9e22987a69351b02cad95d2849e174746.jpg', '少年的你终极版预告', 'https://mokespace.cn/weimai/upFile/少年的你终极版预告.mp4', 'https://mokespace.cn/weimai/upFile/ce563fb5994f5fd62b1c9ff29e714e0088228.jpg,https://mokespace.cn/weimai/upFile/f96e9d6e7eb72eb7b6bbbe94be0f6bf3137332.jpg,https://mokespace.cn/weimai/upFile/994d6f8e22fb31a9059c49386f2a84eb118900.jpg');
INSERT INTO `t_movie` VALUES (3, '叶问4：完结篇', '葉問4', '动作', '叶伟信', 'https://mokespace.cn/weimai/upFile/a3d6ca3bdd5b0ddd7016acff9a9f2f2e2805813.jpg', 'v2d imax', '因故来到美国唐人街的叶问（甄子丹 饰），意外卷入一场当地军方势力与华人武馆的纠纷，面对日益猖狂的民族歧视与压迫，叶问挺身而出，在美国海军陆战队军营拼死一战，以正宗咏春，向世界证明了中国功夫。', 9.0, 456452, '甄子丹', '中国大陆', '国语', 107, b'1', 4063, 4943676, '2020-02-27', 3, 'https://mokespace.cn/weimai/upFile/ccc539078ee11e69864cebe7df0fd2071668333.jpg', '叶问4_完结篇 正式预告片', 'https://mokespace.cn/weimai/upFile/叶问4_完结篇 正式预告片.mp4', 'https://mokespace.cn/weimai/upFile/e5df90a26dd045c6c2f18f011a818be11480905.jpg,https://mokespace.cn/weimai/upFile/66e26fa6d7ad1ea9bc69044e316b98251037421.jpg,https://mokespace.cn/weimai/upFile/a85b0dc34139c22af46dc6bb69169ea71075227.jpg');
INSERT INTO `t_movie` VALUES (4, '你的名字', '君の名は', '动漫', '新海诚', 'https://mokespace.cn/weimai/upFile/04de313fdd7f3835563d3c4bdfb980735556062.jpg', 'v2d imax', '影片讲述了一名少年和一名少女在梦中相遇邂逅的奇幻爱情故事。在千年一遇的彗星造访地球的一个月前，身居日本深山小镇的少女宫水三叶（上白石萌音 配音）每天都过着忧郁烦燥的生活，而正处于青春叛逆期的她对大都市的憧憬向往与日俱增。然而不久，三叶做了一个变成男孩子的梦，眼前的这里有着陌生的房间、朋友和她梦寐以求的宽敞街道。三叶虽然感到迷茫困惑，但能够尽情享受朝思暮想的都市生活的她觉得神清气爽。与此同时，远在他乡的东京少年立花泷（神木隆之介 配音）也有一个奇怪的梦境，睁开睡眼的他发现变成一名不知名姓女孩的自己身处一个从未去过的深山小镇。两人惊醒时发现各自回到了自己的身体，但每逢两人入睡或半梦半醒之际，他们就会交换对调身份。一头雾水的三叶决定循着线索找寻立花泷，而立花泷也试着跟三叶沟通，冥冥之中互换身份的两人不约而同地竭尽所能设法找寻对方，而彼此间的了解也因此渐渐加深，虽未曾相见却早已似曾相识的两人暗生情愫，一段青春季节的奇妙物语随之展开。跨越时空梦境的阻隔，终在现实世界邂逅的两人上演了一幕青涩浪漫的奇遇暖心之恋。岂料一场突如其来的意外将两人的一切美好定格在梦醒之际……', 9.0, 100006, '上白石萌音，佟心竹， 神木隆之介', '中国大陆', '日语', 106, b'1', 40632, 40635, '2020-02-27', 3, 'https://mokespace.cn/weimai/upFile/35b09200801ddba8bea7c6035be9b187203042.jpg', '《你的名字。》大陆官方预告片！！！首发“初见版”预告！！！', 'https://mokespace.cn/weimai/upFile/《你的名字。》大陆官方预告片！！！首发“初见版”预告！！！.mp4', 'https://mokespace.cn/weimai/upFile/20631fbe813beb5b3b1552a4aabc996e53428.jpg,https://mokespace.cn/weimai/upFile/9b7e879ce39bc7dd66764898be12125288111.jpg,https://mokespace.cn/weimai/upFile/170865b86ab1dd2d51173c7398c3753e145573.jpg,https://mokespace.cn/weimai/upFile/35b09200801ddba8bea7c6035be9b187203042.jpg');
INSERT INTO `t_movie` VALUES (5, '误杀', 'Sheep Without a Shepherd', '剧情', '柯汶利', 'http://p1.meituan.net/177.249/movie/967b253953bc7e660cfadbf9d78f67b62852693.jpg', 'v2d imax', '李维杰（肖央 饰）与妻子阿玉（谭卓 饰）打拼多年，膝下育有两个女儿。一个雨夜，一场意外，打破了这个家庭的宁静。而李维杰作为一个父亲，为了保全自己的家人，他不顾一切地决定瞒天过海……', 9.0, 456452, '肖央,谭卓,陈冲', '中国大陆', '国语', 120, b'1', 406, 349440, '2020-02-27', 3, 'http://p1.meituan.net/movie/bde51bb9cac3f99bd3ae3c3b07f14eea48234.jpg', '发布“耍大牌的雨”小特辑，片场趣事大放送', 'http://maoyan.meituan.net/movie/videos/854x480b963e59e62ad4ff48a27c68f97501eb3.mp4', 'http://p0.meituan.net/movie/a37f9fa947523fd33c3ad1845bd3bc581899942.jpg@180w_140h_1e_1c.webp,https://p0.meituan.net/movie/9064b787a533d85fa2d2f8ad486351861051512.jpg@180w_140h_1e_1c.webp');
INSERT INTO `t_movie` VALUES (7, '我为你牺牲', 'Warriors of Hornor', '剧情', '安战军', 'http://p0.meituan.net/177.249/movie/326fb54acb9c4feab45f1f3988568e571769525.jpg', 'v2d imax', '根据三个武警部队真实人物故事改编：战斗在缉毒一线的王强（李琦 饰）“卧底”制毒工厂，凭借过硬的军事技能和强大的心理素质，排爆，制服毒枭，铲除制毒窝点；军属庄小红（陈姝 饰）默默支持丈夫多年驻守高原山口，而探亲过程中她却遭遇车祸截肢，为确保能生下健康的军人后代，忍痛不打麻药进行手术。术后依然自强自立；援疆战士李报国身患癌症，多次申请援疆执行任务，最后重症不治牺牲，留下“来生再报国”的遗愿，用生命诠释“为你牺牲”这一主题。', 9.0, 456452, '肖央,谭卓,陈冲', '中国大陆', '国语', 120, b'0', 3102, 450231, '2020-02-29', 1, 'http://p1.meituan.net/movie/bde51bb9cac3f99bd3ae3c3b07f14eea48234.jpg', '发布“耍大牌的雨”小特辑，片场趣事大放送', 'http://maoyan.meituan.net/movie/videos/854x480b963e59e62ad4ff48a27c68f97501eb3.mp4', 'http://p0.meituan.net/movie/a37f9fa947523fd33c3ad1845bd3bc581899942.jpg@180w_140h_1e_1c.webp,https://p0.meituan.net/movie/9064b787a533d85fa2d2f8ad486351861051512.jpg@180w_140h_1e_1c.webp');
INSERT INTO `t_movie` VALUES (16, '唐人街探案3', 'Detective Chinatown 3', '悬疑', '陈思诚', 'https://mokespace.cn/weimai/upFile/b0e0d6ce9914f37e7f9f6ade13e096342721150.jpg', 'v2d imax', '继曼谷、纽约之后，东京再出大案。唐人街神探唐仁（王宝强 饰）、秦风（刘昊然 饰）受侦探野田昊（妻夫木聪 饰）的邀请前往破案。“CRIMASTER世界侦探排行榜”中的侦探们闻讯后也齐聚东京，加入挑战，而排名第一Q的现身，让这个大案更加扑朔迷离，一场亚洲最强神探之间的较量即将爆笑展开……', 8.7, 223123, '王宝强，刘昊然', '中国大陆', '国语', 120, b'0', 310, 349436, '2020-03-26', 1, 'https://mokespace.cn/weimai/upFile/7933a79d003d358fcf82db9ae763e6fa950461.jpg', '大闹东京_包括亚洲联盟专辑', 'https://mokespace.cn/weimai/upFile/【唐探3】正式预告-大闹东京_包括亚洲联盟专辑.mp4', 'https://mokespace.cn/weimai/upFile/0bda8d042f4afa6fddfbcafe282d3e8f1111625.jpg,https://mokespace.cn/weimai/upFile/7e278afec8b358bf288bced0e7ab4402927406.jpg');
INSERT INTO `t_movie` VALUES (17, '变化中的中国·生活因你而火热', 'Changing China: Life is marvelous be', '剧情', '程工， 张袆', 'https://mokespace.cn/weimai/upFile/db27b1087eca5056e658c020c3e0ba6715496949.jpg', 'v2d imax', '影片通过对六位不同职业、不同背景的普通中国年轻人工作和生活的真实纪录，展现了中国人民自强不息、努力奋进的精神风貌。影片的主人公有基层民警、产科医生、中学教师、青年创业者、外卖小哥、壁画研究员，通过他们热爱生活，恪尽职守，追逐梦想的感人故事。', 9.2, 12123, '张方勇，舒畅，张震男', '中国大陆', '国语', 106, b'0', 406, 349436, '2020-02-28', 2, 'https://mokespace.cn/weimai/upFile/39a1d751eeb2a0868df21cc9c16a3b1b1657473.jpg', '变化中的中国·生活因你而火热-预告片', 'https://mokespace.cn/weimai/upFile/变化中的中国活因你而火热-预告片.mp4', 'https://mokespace.cn/weimai/upFile/4b9fe70fdbbce8e9b0171950c3941c6a2066651.jpg,https://mokespace.cn/weimai/upFile/93be16f641bae268e68e0abb82c75b502064414.jpg,https://mokespace.cn/weimai/upFile/a52cbeeb97e9c126b5c300e1f99c91bf1561603.jpg');
INSERT INTO `t_movie` VALUES (18, '西游记之大圣归来', 'Monkey King: Hero is Back', '动漫', '田晓鹏', 'https://mokespace.cn/weimai/upFile/07b4127cff2289cd91b65628f4417ac37666558.jpg', 'v3d imax', '大闹天宫后四百年多年，齐天大圣成了一个传说，在山妖横行的长安城，孤儿江流儿（林子杰 配音）与行脚僧法明（吴文伦 配音）相依为命，小小少年常常神往大闹天宫的孙悟空（张磊 配音）。 有一天，山妖（吴迪 配音）来劫掠童男童女，江流儿救了一个小女孩，惹得山妖追杀，他一路逃跑，跑进了五行山，盲打误撞地解除了孙悟空的封印。悟空自由之后只想回花果山，却无奈腕上封印未解，又欠江流儿人情，勉强地护送他回长安城。 一路上八戒（刘九容 配音）和白龙马也因缘际化地现身，但或落魄或魔性大发，英雄不再。妖王（童自荣 配音）为抢女童，布下夜店迷局，却发现悟空法力尽失，轻而易举地抓走了女童。悟空不愿再去救女童，江流儿决定自己去救。 日全食之日，在悬空寺，妖王准备将童男童女投入丹炉中，江流儿却冲进了道场，最后一战开始了……', 7.9, 423434, '张磊，张欣，吉吉', '中国大陆', '国语', 89, b'0', 4063, 349436, '2020-03-20', 2, 'https://mokespace.cn/weimai/upFile/ac72e21a2e397e3b8052aee59b54a4fe92535.jpg', '游记之大圣归来预告片产牛逼动画', 'https://mokespace.cn/weimai/upFile/游记之大圣归来预告片产牛逼动画.mp4', 'https://mokespace.cn/weimai/upFile/98685f856183651567fbbbebcd02077967037.jpg');
INSERT INTO `t_movie` VALUES (19, '惊天魔盗团', 'Now You See Me', '动作', '路易斯·莱特里尔', 'https://mokespace.cn/weimai/upFile/552229079d94bbd4e36b808fd17021d2338440.jpg', 'v2d imax', '不夜赌城拉斯维加斯，豪华的表演大厅内正在进行一场前所未有的魔术表演，由丹尼尔·阿特拉斯（杰西·艾森伯格 饰）、亨莉·里维斯（艾拉·菲舍尔 饰）、杰克·怀尔德（戴夫·弗兰科 饰）和梅里特·麦克金尼（伍迪·哈里森 饰）四位魔术师组成的“四骑士”配合天衣无缝，在众目睽睽之下偷来了某法国银行金库内350万欧元纸币，此举在现场至全世界引起轰动。FBI探员罗德（马克·鲁夫洛 饰）和国际刑警埃尔玛·德雷（梅拉尼·罗兰 饰）奉命对四人展开调查，却一无所获。无奈之下，他们只得求助于极具名气的揭露魔术师布莱德利（摩根·弗里曼 饰）。 　　魔术师、盗贼、FBI探员，光影交错下最精彩的较量，连番上演……', 8.5, 523121, '杰西·艾森伯格，梅拉尼·罗兰', '中国大陆', '英语', 115, b'0', 20013, 349436, '2020-04-16', 1, 'https://mokespace.cn/weimai/upFile/a945acf035608bd0e317e2c655e19b4d80503.jpg', '惊天魔盗团22015双语预告片', 'https://mokespace.cn/weimai/upFile/惊天魔盗团22015双语预告片.mp4', 'https://mokespace.cn/weimai/upFile/cb36762784bd5eb90fd371c71f9a5bb599644.jpg,https://mokespace.cn/weimai/upFile/bbf546f23ef799a1b3cfdd2d6977270d69649.jpg');
INSERT INTO `t_movie` VALUES (20, '战狼', 'Wolf Warriors', '动作', '吴京', 'https://mokespace.cn/weimai/upFile/79357c0fdcbad30f9cc495949bd8b644376363.jpg', 'v2d imax', '在南疆围捕贩毒分子的行动中，特种部队狙击手冷锋（吴京 饰）公然违抗上级的命令，开枪射杀伤害了战友的暴徒武吉（周晓鸥 饰）。这一行动令冷锋遭到军方禁闭甚至强制退伍的处罚，不过各特种部队精英组成超级特种部队战狼中队的中队长龙小云（余男 饰），却十分欣赏这个敢作敢为且业务过硬的血性男儿，于是将其召入自己的麾下。在新近的一次演习中，冷锋凭借冷静的判断力从老首长处拔得一城，并且成功击退了突然出现的狼群。谁知在毫无准备的情况下，战狼遭到了一伙荷枪实弹分子的袭击。原来武吉的哥哥敏登（倪大红 饰）是一个冷酷无情的国际通缉犯，他手下豢养了一大批身怀绝技的雇佣兵。为了给弟弟报仇，敏登派出雇佣兵千里迢迢奔着冷锋而来……', 8.2, 26556, '余男，倪大红，周晓鸥', '中国大陆', '国语', 90, b'0', 200, 349436, '2020-04-16', 1, 'https://mokespace.cn/weimai/upFile/dca70ca627cc73d525896d2e8455fc2e149138.jpg', '战狼吴京执导_达康书记？？？', 'https://mokespace.cn/weimai/upFile/战狼吴京执导_达康书记？？？WOLFARRIORfficial.mp4', 'https://mokespace.cn/weimai/upFile/6f6503813702fb92b5bf7df1c29ed5a3126442.jpg,https://mokespace.cn/weimai/upFile/7bc7009ce7f1b3924e3f79c94abbf9b6123865.jpg,https://mokespace.cn/weimai/upFile/a97efbd840ca14af65cc0fd2d75d3b2d118952.jpg');
INSERT INTO `t_movie` VALUES (21, '速度与激情9', 'F9: The Fast Saga', '冒险', '林诣彬', 'https://mokespace.cn/weimai/upFile/5c858e2f34fdd995f5ccb05c4f6c9f56350665.jpg', 'v3d imax', '范·迪塞尔饰演的唐老大多姆·托莱多，与莱蒂和他的儿子小布莱恩，过上了远离纷扰的平静生活。然而他们也知道，安宁之下总潜藏着危机。这一次，为了保护他所爱的人，唐老大不得不直面过去。他和伙伴们面临的是一场足以引起世界动荡的阴谋，以及一个前所未遇的一流杀手和高能车手。而这个名叫雅各布（约翰·塞纳饰，《自杀小队2》）的人，恰巧是多姆遗落在外的亲弟弟。', 9.0, 312313, '范·迪塞尔，卢卡斯·布莱克', '中国大陆', '英语', 138, b'1', 2001, 349448, '2020-02-27', 3, 'https://mokespace.cn/weimai/upFile/af1b72e2ad92aae15ccf9bfb22c928a4108476.jpg', '速度与激情9 预告，2020上映', 'https://mokespace.cn/weimai/upFile/[流畅360P]速度与激情9】预告，2020上映.mp4', 'https://mokespace.cn/weimai/upFile/088f8be065c27a21ca8200301001405b74452.jpg,https://mokespace.cn/weimai/upFile/4137378dc60ae59d07176dee7afbea9d150553.jpg,https://mokespace.cn/weimai/upFile/66285ea4dc88f6de18a011c757029816392058.jpg');
INSERT INTO `t_movie` VALUES (22, '复仇者联盟4：终局之战', 'Avengers: Endgame', '科幻', '乔·罗素,安东尼·罗素', 'https://mokespace.cn/weimai/upFile/f7d2ad70eb79d6d9b8a197713db9b8c41711752.jpg', 'v3d imax', '一声响指，宇宙间半数生命灰飞烟灭。几近绝望的复仇者们在惊奇队长的帮助下找到灭霸归隐之处，却得知六颗无限宝石均被销毁，希望彻底破灭。如是过了五年，迷失在量子领域的蚁人意外回到现实世界，他的出现为幸存的复仇者们点燃了希望。与美国队长冰释前嫌的托尼找到了穿越时空的方法，星散各地的超级英雄再度集结，他们分别穿越不同的时代去搜集无限宝石。而在这一过程中，平行宇宙的灭霸察觉了他们的计划。 注定要载入史册的最终决战，超级英雄们为了心中恪守的信念前仆后继……', 8.6, 412311, '小罗伯特·唐尼,克里斯·埃文斯,马克·鲁法洛', '中国大陆', '英语', 181, b'1', 31024, 349438, '2020-02-27', 3, 'https://mokespace.cn/weimai/upFile/a24cbf4a9a3af99c33b891bf677e9fd455585.jpg', '复仇者联盟4：终局之战全新电视预告', 'https://mokespace.cn/weimai/upFile/《复仇者联盟4：终局之战》全新电视预告.mp4', 'https://mokespace.cn/weimai/upFile/2db09020bc6bf305da40969ed17f7ef9143906.jpg,https://mokespace.cn/weimai/upFile/062d12d42aa0fec1dc6034bb6297c42241846.jpg,https://mokespace.cn/weimai/upFile/2af4713c8cab14bf688313a12b0ec25e61000.jpg,https://mokespace.cn/weimai/upFile/1334e9201cb4752eb37254ac222eaee085260.jpg');
INSERT INTO `t_movie` VALUES (23, '毒液2', 'Venom 2', '科幻', '安迪·瑟金斯', 'https://mokespace.cn/weimai/upFile/d7f40181c47ce0246d3cf07c7f85ec53210044.jpg', 'v3d imax', '据悉，索尼已将《毒液》续集提上日程。《毒液》凭借1亿美元的投资目前拿到6.77亿美元全球票房，最终甚至可能摸高到8亿美元，拿到的利润会超过索尼之前所有的蜘蛛侠电影。虽然影片媒体口碑一般，但观众似乎很认可。接下来的《毒液》续集除了要展现伍迪·哈里森扮演的屠杀，如何将汤姆·赫兰德扮演的蜘蛛侠融入进来。目前这版的彼得·帕克还是高中生，算是索尼和MCU合作的产物，他和汤姆·哈迪扮演的埃迪同处在一个宇宙、一个时间线上吗？', 7.2, 123123, '汤姆·哈迪', '北美', '英语', 120, b'0', 3102, 349436, '2020-05-14', 1, 'https://mokespace.cn/weimai/upFile/befa8cf5af7ce1380f127d8ff13a2989137472.jpg', '2020蜘蛛侠与毒液同框，概念预告片伍迪雷逊电影', 'https://mokespace.cn/weimai/upFile/2020蜘蛛侠与毒液同框，概念预告片伍迪雷逊电影.mp4', 'https://mokespace.cn/weimai/upFile/8f2e80174df05fac09d013016778eb74125897.jpg,https://mokespace.cn/weimai/upFile/8c2ad35367a07153952df1fd2af11cb669518.jpg');
INSERT INTO `t_movie` VALUES (24, '天气之子', '天気の子', '动漫', '新海诚', 'https://mokespace.cn/weimai/upFile/ecca4f0b95340b2c57006a1bace4c3f91386100.jpg', 'v2d imax', '在高一的夏天，少年帆高（醍醐虎汰朗 配音）离家出走，一个人来到东京。帆高好不容易找到一份工作，为一本古怪的“神秘学杂志”写稿，生活孤单贫苦。连日的滂沱大雨，像是来映衬他的失落。在纷纭杂沓的大都会一角，帆高遇上了一个可爱少女阳菜（森七菜 配音）。阳菜和弟弟相依为命，个性坚强、开朗，但她心中隐藏着一个重大秘密──每当她说：“现在开始天晴了！”雨便渐渐停下来，美丽的阳光洒落街上。原来，她拥有一股不可思议的能量，一股能让天空放晴的异力……', 6.5, 322434, '醍醐虎汰朗，森七菜', '中国大陆', '日语', 113, b'1', 310, 349436, '2020-02-27', 3, 'https://mokespace.cn/weimai/upFile/f5c8bbedfe344a91654264270315bbe693937.jpg', '官方《天气之子》终极预告', 'https://mokespace.cn/weimai/upFile/官方《天气之子》终极预告.mp4', 'https://mokespace.cn/weimai/upFile/480fdab3741cdaae03ff5567b5a66f2568037.jpg,https://mokespace.cn/weimai/upFile/89097e4b2f396d1e99e8e30e4c0972a653460.jpg,https://mokespace.cn/weimai/upFile/12f1fcc531138c6b0e08ded34b8fe925109680.jpg');
INSERT INTO `t_movie` VALUES (25, '釜山行', '부산행', '恐怖', '延尚昊', 'https://mokespace.cn/weimai/upFile/9a0cc541dba6851c92143f0cc0d97bbe270276.jpg', 'v2d imax', '证券公司基金管理人石宇（孔侑 饰）光鲜精干，却也是个重利轻义之徒。妻子为此与之决裂，女儿秀安（金秀安 饰）则对如此自私的父亲越来越失望，决定前往釜山和母亲生活。在秀安生日这天，石宇抽出时间陪伴女儿登上开往釜山的特快列车。而与此同时，城市四处出现了极为可疑的暴动事件。政府极力洗白无法掩盖丧尸肆虐的事实，即便懵然无知的列车乘客也因为不速之客的到来而堕入恐慌绝望的地狱中。开车的刹那，一名感染者冲入车厢，而她很快尸变并对目光所及之处的健康人展开血腥屠杀。未过多久，丧尸便呈几何数爆发性地增长。石宇被迫和幸存者的乘客们在逼仄的空间中奋力求生。 通往釜山的遥遥旅途布满杀机，危难时刻每个幸存者的人性也承受巨大的考验……', 8.4, 123123, '孔刘，郑有美，金秀安', '中国大陆', '国语', 118, b'1', 31023, 349436, '2020-02-27', 3, 'https://mokespace.cn/weimai/upFile/a3bae2d5a409dca4c9a300e3ad6e1bf881921.jpg', '惊悚釜山行', 'https://mokespace.cn/weimai/upFile/惊悚釜山行.mp4', 'https://mokespace.cn/weimai/upFile/1d57de30de23eeee25a168973704e9de115830.jpg,https://mokespace.cn/weimai/upFile/ad7a3c50e138732920807ef1cc1649be117218.jpg,https://mokespace.cn/weimai/upFile/36a6f19429c01a8a1bc8fd46f12a79c6146350.jpg');
INSERT INTO `t_movie` VALUES (26, '黑寡妇', 'Black Widow', '科幻', '凯特·绍特兰', 'https://mokespace.cn/weimai/upFile/e2901a8277b00178f278398664a511d3202309.jpg', 'v3d imax', '据英国《每日邮报》爆料，斯嘉丽·约翰逊确定以2500万美元的顶级片酬主演[黑寡妇]独立影片！迪士尼与漫威给出的这一片酬价格，也将令斯嘉丽成为好莱坞单片片酬最高的女演员！同时，斯嘉丽的经纪人正与迪士尼商谈，意图令斯嘉丽成为该片的制片人之一。另据内部人士透露，若该片票房超过9亿美元，那么斯嘉丽将额外获得600万美元的分成。裘德·洛、本·门德尔森有望联合出演。该片剧本也已完成，有望于2020年夏季上映', 0.0, 341232, '斯嘉丽·约翰逊,佛罗伦斯·珀', '北美', '英语', 90, b'0', 23108, 0, '2020-04-29', 1, 'https://mokespace.cn/weimai/upFile/204703d7b865ce7b5891eeb660d633f835677.jpg', '漫威《黑寡妇》新预告，大战模仿大师！', 'https://mokespace.cn/weimai/upFile/漫威《黑寡妇》新预告，大战模仿大师！.mp4', 'https://mokespace.cn/weimai/upFile/81eb89a63fbe71be3fe344e7739e5be523791.jpg,https://mokespace.cn/weimai/upFile/c7bb6ed8b47be90196344397cc3e6cbf74025.jpg,https://mokespace.cn/weimai/upFile/ea7a45b3447d7c7baa2a72cddf49080e44858.jpg');
INSERT INTO `t_movie` VALUES (27, '蜘蛛侠：英雄远征', 'Spider-Man: Far From Home', '科幻', '乔·沃茨', 'https://mokespace.cn/weimai/upFile/48fdec1c3f34533f1e1b907c5e8a61f01905931.jpg', 'v3d imax', '彼得·帕克回到了高中。他想暂时远离制裁罪恶的生活，便踏上了前往欧洲的修学旅行，也借此机会向米歇尔·琼斯表达真实的情感。但计划赶不上变化，尼克·弗瑞和一名来自平行宇宙的超级英雄神秘客找上门来，希望彼得·帕克一起阻止四名元素众毁灭地球。全世界都在哀悼托尼·史塔克的去世，同时也都担心外星人再来攻击地球，所以大众都期望蜘蛛侠能接钢铁侠的班。彼得·帕克还没准备好接下这份大任，也不知道托尼·史塔克走后自己该做什么。他还纠结于对米歇尔·琼斯的感觉，觉得自己需要在超级英雄生活的间隙休息一下。为了帮助学生们顺利回归，学校决定让一些学生去欧洲游学。彼得·帕克觉得这是暂时放下蜘蛛侠身份的绝好机会，也是告诉米歇尔·琼斯自己真实感受的时候。但当尼克·弗瑞招揽他后，彼得·帕克不得不把这些计划先放一放 。', 8.5, 341232, '汤姆·赫兰德,杰克·吉伦哈尔', '中国大陆', '英语', 127, b'1', 6621, 1231344, '2019-06-28', 3, 'https://mokespace.cn/weimai/upFile/ed488b5dad5823686c285a26eea91b0241193.jpg', '蜘蛛侠：英雄远征 超级预告惊爆来袭！延续复联燃战今夏！', 'https://mokespace.cn/weimai/upFile/蜘蛛侠：英雄远征 超级预告惊爆来袭！延续复联燃战今夏！.mp4', 'https://mokespace.cn/weimai/upFile/2ee5c2cf67503eeebd63ea97e0dd8e2d39101.jpg,https://mokespace.cn/weimai/upFile/b1c12dd5d247e749ac641abaa879bbfe122601.jpg,https://mokespace.cn/weimai/upFile/8ec08bcf8ff7ef38540a6cf71c5ac2c152871.jpg');
INSERT INTO `t_movie` VALUES (28, '姜子牙', 'JIANG ZIYA：Legend Of Deification', '动漫', '程腾,李炜', 'https://mokespace.cn/weimai/upFile/3dc44919f0917b5823c867813f29fba42625689.jpg', 'v3d imax', '昆仑弟子姜子牙（郑希 配音）率领众神伐纣，赢得封神大战胜利。即将受封成为众神之长的他，却因一时过失引得昆仑大乱，从此被贬北海，为世人所唾弃。十年后，因一个契机，姜子牙踏上重回昆仑的旅途。在战后的废墟之上，他重新找到自我，也洞悉了十年前的一切真相。', 7.9, 341232, '郑希,杨凝', '中国大陆', '国语', 110, b'0', 342, 0, '2020-04-15', 1, 'https://mokespace.cn/weimai/upFile/2233628d0687005caddc819b6f5b940e781964.jpg', '史诗级动画《姜子牙》首曝预告片，封神宇宙接棒哪吒，震撼示人！', 'https://mokespace.cn/weimai/upFile/史诗级动画《姜子牙》首曝预告片，封神宇宙接棒哪吒，震撼示人！.mp4', 'https://mokespace.cn/weimai/upFile/d33b0f25a058e21ddc12413b0fcae8911460044.jpg,https://mokespace.cn/weimai/upFile/aa16835bc377db8961086bd4b8dc26721459204.jpg,https://mokespace.cn/weimai/upFile/906ba6ad0b9fe6301d7d99872ce9528c1492349.jpg');
INSERT INTO `t_movie` VALUES (29, '肥龙过江', '肥龍過江', '喜剧', '谷垣健治', 'https://mokespace.cn/weimai/upFile/aa61bd5809e99ff9b23e6276cf665bc92030231.jpg', 'v2d imax', '香港警察朱福龙（甄子丹 饰）因一次工作失误惨被降级，万般无奈之际又遭未婚妻可儿（周励淇 饰）悔婚，事业爱情的双重打击令他一蹶不振，暴饮暴食六个月后体重猛增到220磅！上司黄警官不忍其继续堕落，委派朱福龙前往日本押送一名犯人，并承诺只要完成任务就可以为他恢复职位。可惜来到日本，倒霉的事件便接连在他身上发生，不仅财物尽失，连犯人也在押送途中逃脱了。幸好得到前香港警察潇洒哥（王晶 饰）的帮助才得以暂时解困，为了完成任务找回犯人，朱福龙与潇洒哥共同行动，不料在查找真相的过程中发现了日本黑帮的惊天阴谋......', 7.5, 341232, '甄子丹,毛舜筠,周丽淇,王晶', '中国大陆', '粤语', 118, b'1', 342, 5242, '2020-02-20', 3, 'https://mokespace.cn/weimai/upFile/9d7af8c8164ec0ed1b591434b49e1ded59139.jpg', '问变肥警！甄子丹打到东京《肥龙过江》定档版预告片', 'https://mokespace.cn/weimai/upFile/问变肥警！甄子丹打到东京《肥龙过江》定档版预告片.mp4', 'https://mokespace.cn/weimai/upFile/457c17d091173178c7eb9863272ee7631420240.jpg,https://mokespace.cn/weimai/upFile/50c0724180094b03ba63aa9d6d4c30db1795993.jpg,https://mokespace.cn/weimai/upFile/11a7cbaf90cd7ab7fb3554c0e866dc0b1693752.jpg,https://mokespace.cn/weimai/upFile/55edfe18ce79e8022c4913f1b672dc0a1254480.jpg');
INSERT INTO `t_movie` VALUES (30, '浪客剑心', 'るろうに剣心 続編', '动作', '大友启史', 'https://mokespace.cn/weimai/upFile/bbd08c02332249f8564fb6291c1d20d6294482.jpg', 'v2d imax', '武井咲が来年公開の映画「るろうに剣心」シリーズの新作で女優復帰することも明らかになった。俳優の佐藤健（２８）が主演し、自身がヒロインを務める人気シリーズ「るろうに剣心」の新作で女優復帰。同作は人気剣客漫画の実写版。佐藤のド派手アクションや、武井の清純派イメージを覆すツンデレ美少女剣士役で話題を集め、今春から新作を撮影する計画が浮上していたが、武井の妊娠などで延期となっていた。', 8.4, 341232, '佐藤健,武井咲,苍井优', '中国大陆', '日语', 125, b'1', 342, 3434, '2019-06-20', 3, 'https://mokespace.cn/weimai/upFile/e97a69a3a96a6fbf9217bf47f9c66f9994494.jpg', '浪客剑心 真人电影预告公开，2020年上映', 'https://mokespace.cn/weimai/upFile/浪客剑心 真人电影预告公开，2020年上映.mp4', 'https://mokespace.cn/weimai/upFile/daee0d36f2e29085182a014391d342f7120023.jpg,https://mokespace.cn/weimai/upFile/5bb698deb25db9738a31facdfd760ae0114181.jpg,https://mokespace.cn/weimai/upFile/83a78df23a89f5746611b01ac831cdb7106251.jpg');
INSERT INTO `t_movie` VALUES (31, '哈莉·奎因：猛禽小队', 'Birds of Prey', '恐怖', '阎羽茜', 'https://mokespace.cn/weimai/upFile/19520438c1f93bd9b26fa81d6fae7b52369928.jpg', 'v3d imax', '据称这部电影并不只是小丑女的个人电影。DC漫画《猛禽小队》实际上讲述了小丑女和黑金丝雀、蝙蝠女、女猎手等人物组队打击犯罪的故事。但目前尚不清楚片中将会出现哪些角色。《大黄蜂》编剧克里斯蒂娜·霍森执笔剧本目前正在创作中，有望今年底或明年初开拍。', 8.4, 341232, '玛歌特·罗比,罗茜·佩雷兹', '北美', '英语', 109, b'0', 4845, 0, '2020-02-05', 2, 'https://mokespace.cn/weimai/upFile/fc0cf1cec194c6d5dc4416a32ef31c9656086.jpg', '票房惨淡不是没有原因的《猛禽小队》小丑女监狱打斗片段实在是很一般', 'https://mokespace.cn/weimai/upFile/票房惨淡不是没有原因的《猛禽小队》小丑女监狱打斗片段实在是很一般.mp4', 'https://mokespace.cn/weimai/upFile/db72420a15e0765b0e3aa573050accf034081.jpg,https://mokespace.cn/weimai/upFile/e70459756135d5a2b2a6abb8495da1a645657.jpg,https://mokespace.cn/weimai/upFile/a78f2f699cae48b0ac12389d2dc11d7f41757.jpg,https://mokespace.cn/weimai/upFile/54118d60124ca0c89d60f298d7e3f14a44302.jpg');
INSERT INTO `t_movie` VALUES (32, '囧妈', 'Lost in Russia', '喜剧', '徐峥', 'https://mokespace.cn/weimai/upFile/f2ebf28e702874e3aa4238911cd34ef41074680.jpg', 'v2d imax', '徐伊万（徐峥 饰）缠身于婚姻危机和商业纠纷中，却阴差阳错与妈妈坐上了开往俄罗斯的火车。生活方式和观念的冲突，使他与妈妈产生了激烈矛盾，同时还要与妻子斗智斗勇。一路风景奇遇，囧事不断……', 8.4, 341232, '徐峥,黄梅莹,袁泉,贾冰', '中国大陆', '国语', 126, b'0', 4845, 0, '2020-02-15', 2, 'https://mokespace.cn/weimai/upFile/fcc75e9b3a3832880f9804c26cc4b1b1899760.jpg', '徐峥喜剧《囧妈》全新预告，中年儿子vs唠叨母亲', 'https://mokespace.cn/weimai/upFile/徐峥喜剧《囧妈》全新预告，中年儿子vs唠叨母亲.mp4', 'https://mokespace.cn/weimai/upFile/2d21d1d15319e3441ee0219d58f56d36496617.jpg,https://mokespace.cn/weimai/upFile/e33881a2c9b6b03b26a9fb1111c5cfbc493217.jpg,https://mokespace.cn/weimai/upFile/29633b7a918e3f0a098c1597f751c660664905.jpg');
INSERT INTO `t_movie` VALUES (33, '莫比亚斯：暗夜博士', 'Morbius', '恐怖', '丹尼尔·伊斯皮诺萨', 'https://mokespace.cn/weimai/upFile/1b78818fcc9a8c1f85172b3f9bb3a589777219.jpg', 'v3d imax', '在奥斯卡得主杰瑞德·莱托的饰演下，漫威最新暗黑超级英雄——蜘蛛侠宇宙反派阵营关键角色迈克尔·莫比亚斯将登上大银幕。莫比亚斯博士身患一种罕见的血液疾病，命不久矣的他决心找到治疗方法，拯救其他同病的患者。为此，他孤注一掷试图根除疾病。然而他很快便会发现，治愈方法可能比疾病本身更加可怕。', 8.6, 341232, '杰瑞德·莱托, 杰瑞德·莱托', '北美', '英语', 108, b'0', 3413, 0, '2020-07-18', 1, 'https://mokespace.cn/weimai/upFile/35c7ea851b2141f30b05be7e0a4f2feb55208.jpg', '蜘蛛侠宇宙新片！莱托少爷《莫比亚斯》首曝预告，秃鹫亮相！', 'https://mokespace.cn/weimai/upFile/蜘蛛侠宇宙新片！莱托少爷《莫比亚斯》首曝预告，秃鹫亮相！.mp4', 'https://mokespace.cn/weimai/upFile/e788f5fd2c608cb59507ffdab08af07a987884.jpg,https://mokespace.cn/weimai/upFile/1e51af856e255f54bd1c2a6f7ba156a9526971.jpg,https://mokespace.cn/weimai/upFile/11d808e02696a8d20a3018ee699419b1105630.jpg,https://mokespace.cn/weimai/upFile/a52b49bb267586592c27e91a4153d9b0699867.jpg');
INSERT INTO `t_movie` VALUES (34, 'X战警：黑凤凰', 'X-Men: Dark Phoenix', '科幻', '西蒙·金伯格', 'https://mokespace.cn/weimai/upFile/47af2656af6cd0110057bc527b862c665484423.jpg', 'v3d imax', '在一次危及生命的太空营救行动中，琴·葛蕾（苏菲·特纳 饰）被神秘的宇宙力量击中，成为最强大的变种人。此后琴不仅要设法掌控日益增长、极不稳定的力量，更要与自己内心的恶魔抗争，她的失控让整个X战警大家庭分崩离析，也让整个星球陷入毁灭的威胁之中……', 7.8, 341232, '苏菲·特纳,詹姆斯·麦卡沃伊', '中国大陆', '英语', 114, b'1', 21334, 1324852, '2019-06-06', 3, 'https://mokespace.cn/weimai/upFile/adac46eb8f5fc9379e61d4d201d139b1158175.jpg', '终于来了！《X战警：新变种人》全新官方中字预告首播！', 'https://mokespace.cn/weimai/upFile/终于来了！《X战警：新变种人》全新官方中字预告首播！.mp4', 'https://mokespace.cn/weimai/upFile/91b6371c4d74fb907262cf8173668eb930907.jpg,https://mokespace.cn/weimai/upFile/098f7ebc1f227e11be63d165728bddb155779.jpg,https://mokespace.cn/weimai/upFile/01346e7951ce95a0a2c65cefc8f326f634687.jpg,https://mokespace.cn/weimai/upFile/ede6be769088d13fb09dddbd1318ddd375927.jpg,https://mokespace.cn/weimai/upFile/2318f04a3611eb8bb4b4e5f5e3726c5c67074.jpg');
INSERT INTO `t_movie` VALUES (35, '喋血战士', 'Bloodshot', '动作', '戴夫·威尔逊', 'https://mokespace.cn/weimai/upFile/2b486c9a7b0e28d5c948424686527f832567903.jpg', 'v3d imax', '电影根据勇士漫画改编，讲述由范·迪塞尔扮演的士兵雷·加里森在战斗中意外阵亡，被RST公司利用尖端纳米技术起死回生，变身即时自愈、媲美超级电脑的超级英雄——喋血战士。苏醒的他执着于脑海中残存的记忆碎片，踏上为爱妻的复仇之路，却发现自己竟无法分清真实与虚幻...', 7.8, 341232, '范·迪塞尔,艾莎·冈萨雷斯', '北美', '英语', 115, b'0', 453432, 0, '2020-02-20', 1, 'https://mokespace.cn/weimai/upFile/0b17ff8ea5652d18e7b2b059442450dd307333.jpg', '漫改科幻片！塞尔《喋血战士》曝全新预告', 'https://mokespace.cn/weimai/upFile/漫改科幻片！塞尔《喋血战士》曝全新预告.mp4', 'https://mokespace.cn/weimai/upFile/0c98114b8384cb1c6054c852447f651d87488.jpg,https://mokespace.cn/weimai/upFile/53228d527cef669c22afb186734412d7201613.jpg,https://mokespace.cn/weimai/upFile/fc02c29aa6eab75c1df2cedbd8845d2f126382.jpg,https://mokespace.cn/weimai/upFile/d65dfa3d298c53387709a86f18c37d1f158037.jpg');
INSERT INTO `t_movie` VALUES (36, '哥斯拉2：怪兽之王', 'Godzilla: King of the Monsters', '科幻', '迈克尔·道赫蒂', 'https://mokespace.cn/weimai/upFile/哥斯拉.jpg', 'v3d imax', '随着《哥斯拉》和《金刚：骷髅岛》在全球范围内的成功，华纳兄弟影片公司和传奇影业联手开启了怪兽宇宙系列电影的新篇章—一部史诗级动作冒险巨制。在这部电影中，哥斯拉将和众多大家在流行文化中所熟知的怪兽展开较量。全新故事中，研究神秘动物学的机构“帝王组织”成员将勇敢直面巨型怪兽，其中强大的哥斯拉也将和魔斯拉、拉顿和它的死对头——三头王基多拉展开激烈对抗。当这些只存在于传说里的超级生物再度崛起时，它们将展开王者争霸，人类的命运岌岌可危……', 0.0, 0, '凯尔·钱德勒, 维拉·法梅加', '中国大陆', '英语', 132, b'0', 0, 0, '2020-05-31', 2, 'https://mokespace.cn/weimai/upFile/b7575d70684d1961a4d252178ec5b0f041863.jpg', '《哥斯拉2：怪兽之王》官方中文正式预告！怪兽逐一登场，人类的末日即将来临！', 'https://mokespace.cn/weimai/upFile/《哥斯拉2：怪兽之王》官方中文正式预告！怪兽逐一登场，人类的末日即将来临！.mp4', 'https://mokespace.cn/weimai/upFile/8df728e90b278f86676403a39fd8f6ad39144.jpg,https://mokespace.cn/weimai/upFile/6264636179be86e6f6074eee6e0b988931028.jpg,https://mokespace.cn/weimai/upFile/b4a1afa5db1ac44d05220353379a1ecf41218.jpg');

-- ----------------------------
-- Table structure for t_movie_wish
-- ----------------------------
DROP TABLE IF EXISTS `t_movie_wish`;
CREATE TABLE `t_movie_wish`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `movie_id` int(11) NOT NULL COMMENT '电影id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `movie_id`(`movie_id`) USING BTREE,
  CONSTRAINT `t_movie_wish_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_movie_wish_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `t_movie` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_movie_wish
-- ----------------------------
INSERT INTO `t_movie_wish` VALUES (6, 1, 2);
INSERT INTO `t_movie_wish` VALUES (8, 1, 7);
INSERT INTO `t_movie_wish` VALUES (10, 1, 22);

-- ----------------------------
-- Table structure for t_order
-- ----------------------------
DROP TABLE IF EXISTS `t_order`;
CREATE TABLE `t_order`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) NOT NULL COMMENT '商品id',
  `item_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '类型：电影票、小吃',
  `relate_id` int(11) NOT NULL COMMENT '电影票：time_id；小吃：cinema_id',
  `describe` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电影票：座位信息；小吃：数量',
  `order_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '随机订单号',
  `order_uid` int(11) NOT NULL COMMENT '用户id',
  `price` decimal(10, 2) NOT NULL COMMENT '总价',
  `create_time` datetime(0) NOT NULL COMMENT '下单时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `SeatInfo`(`item_type`, `relate_id`) USING BTREE,
  INDEX `UserOrder`(`item_type`, `order_uid`) USING BTREE,
  INDEX `order_uid`(`order_uid`) USING BTREE,
  CONSTRAINT `t_order_ibfk_1` FOREIGN KEY (`order_uid`) REFERENCES `t_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_order
-- ----------------------------
INSERT INTO `t_order` VALUES (8, 2, '小吃', 10, '1', '4043887289', 1, 32.90, '2020-02-16 17:25:02');
INSERT INTO `t_order` VALUES (9, 4, '小吃', 10, '2', '9525507900', 1, 63.60, '2020-02-16 17:28:17');
INSERT INTO `t_order` VALUES (10, 4, '小吃', 10, '1', '8662426969', 1, 31.80, '2020-02-16 17:28:39');
INSERT INTO `t_order` VALUES (11, 2, '小吃', 10, '2', '9032235082', 1, 65.80, '2020-02-16 17:35:40');
INSERT INTO `t_order` VALUES (12, 1, '小吃', 10, '2', '3880297755', 1, 41.00, '2020-02-16 17:41:29');
INSERT INTO `t_order` VALUES (13, 1, '小吃', 10, '1', '8297976221', 1, 20.50, '2020-02-16 17:42:12');
INSERT INTO `t_order` VALUES (17, 4, '小吃', 10, '2', '2844151534', 1, 63.60, '2020-02-17 17:20:12');
INSERT INTO `t_order` VALUES (19, 2, '电影票', 3, '6排5座,6排6座,2020年02月18日 19:12:47', '1473267355', 1, 92.00, '2020-02-18 18:37:30');
INSERT INTO `t_order` VALUES (21, 21, '电影票', 22, '5排4座,5排5座,2020年02月29日 20:05:00', '5410071501', 1, 61.20, '2020-02-29 19:58:53');
INSERT INTO `t_order` VALUES (22, 21, '电影票', 29, '5排7座,5排8座,2020年03月01日 14:05:00', '9463429403', 1, 79.80, '2020-02-29 21:28:05');
INSERT INTO `t_order` VALUES (23, 5, '电影票', 25, '6排4座,6排5座,2020年03月01日 12:05:00', '8281647817', 1, 99.80, '2020-02-29 21:28:51');
INSERT INTO `t_order` VALUES (24, 21, '电影票', 29, '5排4座,5排5座,2020年03月01日 14:05:00', '9299031906', 2, 79.80, '2020-02-29 21:42:25');
INSERT INTO `t_order` VALUES (25, 4, '小吃', 15, '1', '7881333341', 1, 31.80, '2020-02-29 21:44:57');
INSERT INTO `t_order` VALUES (26, 3, '小吃', 2, '1', '7231231233', 2, 40.50, '2020-03-01 16:47:19');
INSERT INTO `t_order` VALUES (27, 2, '电影票', 30, '2排3座,2020年03月01日 17:49:04', '8123123453', 2, 50.50, '2020-03-01 15:51:17');
INSERT INTO `t_order` VALUES (28, 21, '电影票', 22, '6排5座,6排4座,2020年03月01日 20:05:00', '1218036594', 1, 61.20, '2020-03-01 17:52:10');
INSERT INTO `t_order` VALUES (29, 21, '电影票', 22, '5排4座,5排5座,2020年03月12日 20:05:00', '8269018478', 1, 61.20, '2020-03-12 16:18:54');
INSERT INTO `t_order` VALUES (30, 5, '电影票', 25, '5排4座,5排5座,2020年03月13日 12:05:00', '7691290951', 1, 99.80, '2020-03-12 16:19:45');
INSERT INTO `t_order` VALUES (31, 22, '电影票', 21, '5排4座,5排5座,2020年03月12日 21:05:00', '7310560874', 1, 91.00, '2020-03-12 16:46:17');
INSERT INTO `t_order` VALUES (32, 32, '小吃', 10, '4', '2179356021', 1, 131.60, '2020-03-12 16:56:33');
INSERT INTO `t_order` VALUES (36, 4, '电影票', 7, '5排5座,5排6座,2020年05月30日 10:05:00', '3767950767', 1, 99.00, '2020-05-29 10:31:44');
INSERT INTO `t_order` VALUES (37, 2, '电影票', 20, '5排5座,5排6座,2020年05月29日 19:05:00', '7877075128', 1, 90.00, '2020-05-29 11:15:15');
INSERT INTO `t_order` VALUES (38, 2, '电影票', 20, '5排4座,5排5座,5排3座,2020年05月30日 19:05:00', '8584750657', 1, 135.00, '2020-05-30 16:37:22');

-- ----------------------------
-- Table structure for t_seat
-- ----------------------------
DROP TABLE IF EXISTS `t_seat`;
CREATE TABLE `t_seat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hall_id` int(11) NOT NULL COMMENT '所属的影厅id',
  `y_coord` int(255) NOT NULL COMMENT '行',
  `x_coord` int(255) NOT NULL COMMENT '列',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '座位状态：有座 ok，无座booked',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '座位类型：danren，road',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hall_id`(`hall_id`) USING BTREE,
  CONSTRAINT `t_seat_ibfk_1` FOREIGN KEY (`hall_id`) REFERENCES `t_hall` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3390 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_seat
-- ----------------------------
INSERT INTO `t_seat` VALUES (1842, 1, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1843, 1, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1844, 1, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1845, 1, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1846, 1, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1847, 1, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1848, 1, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1849, 1, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1850, 1, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1851, 1, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1852, 1, 1, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1853, 1, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1854, 1, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1855, 1, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1856, 1, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1857, 1, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1858, 1, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1859, 1, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1860, 1, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1861, 1, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1862, 1, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1863, 1, 2, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1864, 1, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1865, 1, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1866, 1, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1867, 1, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1868, 1, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1869, 1, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1870, 1, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1871, 1, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1872, 1, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1873, 1, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1874, 1, 3, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1875, 1, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1876, 1, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1877, 1, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1878, 1, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1879, 1, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1880, 1, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1881, 1, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1882, 1, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1883, 1, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1884, 1, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1885, 1, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1886, 1, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1887, 1, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1888, 1, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1889, 1, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1890, 1, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1891, 1, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1892, 1, 5, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1893, 1, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1894, 1, 5, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1895, 1, 4, 11, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1896, 1, 5, 11, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1897, 1, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1898, 1, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1899, 1, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1900, 1, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1901, 1, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1902, 1, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1903, 1, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1904, 1, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1905, 1, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1906, 1, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1907, 1, 6, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1908, 1, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1909, 1, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1910, 1, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1911, 1, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1912, 1, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1913, 1, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1914, 1, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1915, 1, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1916, 1, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1917, 1, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1918, 1, 7, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1919, 1, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1920, 1, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1921, 1, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1922, 1, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1923, 1, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1924, 1, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1925, 1, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1926, 1, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1927, 1, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1928, 1, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1929, 1, 8, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1930, 18, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1931, 18, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1932, 18, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1933, 18, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1934, 18, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1935, 18, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1936, 18, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1937, 18, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1938, 18, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1939, 18, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1940, 18, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1941, 18, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1942, 18, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1943, 18, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1944, 18, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1945, 18, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1946, 18, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1947, 18, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1948, 18, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1949, 18, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1950, 18, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1951, 18, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1952, 18, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1953, 18, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1954, 18, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1955, 18, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1956, 18, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1957, 18, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1958, 18, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1959, 18, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1960, 18, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1961, 18, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1962, 18, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1963, 18, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1964, 18, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1965, 18, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1966, 18, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1967, 18, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1968, 18, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1969, 18, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1970, 18, 5, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1971, 18, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1972, 18, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1973, 18, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1974, 18, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1975, 18, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1976, 18, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1977, 18, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1978, 18, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1979, 18, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1980, 18, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1981, 18, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1982, 18, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1983, 18, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1984, 18, 6, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1985, 18, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1986, 18, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1987, 18, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1988, 18, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1989, 18, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1990, 18, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1991, 18, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1992, 18, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1993, 18, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1994, 18, 7, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (1995, 18, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1996, 18, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1997, 18, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1998, 18, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (1999, 18, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2000, 18, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2001, 18, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2002, 18, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2003, 18, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2004, 18, 8, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2005, 18, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2006, 18, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2007, 18, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2008, 18, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2009, 18, 9, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2010, 18, 9, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2011, 18, 9, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2012, 18, 9, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2013, 18, 9, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2014, 18, 9, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2015, 18, 9, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2016, 18, 9, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2017, 18, 9, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2018, 18, 9, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2019, 2, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2020, 2, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2021, 2, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2022, 2, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2023, 2, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2024, 2, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2025, 2, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2026, 2, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2027, 2, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2028, 2, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2029, 2, 1, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2030, 2, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2031, 2, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2032, 2, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2033, 2, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2034, 2, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2035, 2, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2036, 2, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2037, 2, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2038, 2, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2039, 2, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2040, 2, 2, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2041, 2, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2042, 2, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2043, 2, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2044, 2, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2045, 2, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2046, 2, 3, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2047, 2, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2048, 2, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2049, 2, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2050, 2, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2051, 2, 3, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2052, 2, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2053, 2, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2054, 2, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2055, 2, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2056, 2, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2057, 2, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2058, 2, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2059, 2, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2060, 2, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2061, 2, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2062, 2, 5, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2063, 2, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2064, 2, 5, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2065, 2, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2066, 2, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2067, 2, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2068, 2, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2069, 2, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2070, 2, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2071, 2, 4, 11, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2072, 2, 5, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2073, 2, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2074, 2, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2075, 2, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2076, 2, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2077, 2, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2078, 2, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2079, 2, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2080, 2, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2081, 2, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2082, 2, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2083, 2, 6, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2084, 2, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2085, 2, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2086, 2, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2087, 2, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2088, 2, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2089, 2, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2090, 2, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2091, 2, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2092, 2, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2093, 2, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2094, 2, 7, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2095, 2, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2096, 2, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2097, 2, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2098, 2, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2099, 2, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2100, 2, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2101, 2, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2102, 2, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2103, 2, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2104, 2, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2105, 2, 8, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2106, 3, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2107, 3, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2108, 3, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2109, 3, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2110, 3, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2111, 3, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2112, 3, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2113, 3, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2114, 3, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2115, 3, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2116, 3, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2117, 3, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2118, 3, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2119, 3, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2120, 3, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2121, 3, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2122, 3, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2123, 3, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2124, 3, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2125, 3, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2126, 3, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2127, 3, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2128, 3, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2129, 3, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2130, 3, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2131, 3, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2132, 3, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2133, 3, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2134, 3, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2135, 3, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2136, 3, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2137, 3, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2138, 3, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2139, 3, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2140, 3, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2141, 3, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2142, 3, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2143, 3, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2144, 3, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2145, 3, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2146, 3, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2147, 3, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2148, 3, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2149, 3, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2150, 3, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2151, 3, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2152, 3, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2153, 3, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2154, 3, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2155, 3, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2156, 3, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2157, 3, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2158, 3, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2159, 3, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2160, 3, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2161, 3, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2162, 3, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2163, 3, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2164, 3, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2165, 3, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2166, 3, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2167, 3, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2168, 3, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2169, 3, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2170, 3, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2171, 3, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2172, 3, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2173, 3, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2174, 3, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2175, 3, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2176, 3, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2177, 3, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2178, 3, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2179, 3, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2180, 3, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2181, 3, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2182, 3, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2183, 3, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2184, 3, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2185, 3, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2186, 4, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2187, 4, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2188, 4, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2189, 4, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2190, 4, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2191, 4, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2192, 4, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2193, 4, 1, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2194, 4, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2195, 4, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2196, 4, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2197, 4, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2198, 4, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2199, 4, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2200, 4, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2201, 4, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2202, 4, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2203, 4, 2, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2204, 4, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2205, 4, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2206, 4, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2207, 4, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2208, 4, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2209, 4, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2210, 4, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2211, 4, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2212, 4, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2213, 4, 3, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2214, 4, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2215, 4, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2216, 4, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2217, 4, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2218, 4, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2219, 4, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2220, 4, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2221, 4, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2222, 4, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2223, 4, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2224, 4, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2225, 4, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2226, 4, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2227, 4, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2228, 4, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2229, 4, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2230, 4, 5, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2231, 4, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2232, 4, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2233, 4, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2234, 4, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2235, 4, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2236, 4, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2237, 4, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2238, 4, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2239, 4, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2240, 4, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2241, 4, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2242, 4, 6, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2243, 4, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2244, 4, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2245, 4, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2246, 4, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2247, 4, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2248, 4, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2249, 4, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2250, 4, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2251, 4, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2252, 4, 7, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2253, 4, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2254, 4, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2255, 4, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2256, 4, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2257, 4, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2258, 4, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2259, 4, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2260, 4, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2261, 4, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2262, 4, 8, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2263, 4, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2264, 4, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2265, 5, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2266, 5, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2267, 5, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2268, 5, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2269, 5, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2270, 5, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2271, 5, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2272, 5, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2273, 5, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2274, 5, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2275, 5, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2276, 5, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2277, 5, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2278, 5, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2279, 5, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2280, 5, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2281, 5, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2282, 5, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2283, 5, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2284, 5, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2285, 5, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2286, 5, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2287, 5, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2288, 5, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2289, 5, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2290, 5, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2291, 5, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2292, 5, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2293, 5, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2294, 5, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2295, 5, 4, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2296, 5, 4, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2297, 5, 4, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2298, 5, 4, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2299, 5, 4, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2300, 5, 4, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2301, 5, 4, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2302, 5, 4, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2303, 5, 4, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2304, 5, 4, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2305, 5, 5, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2306, 5, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2307, 5, 5, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2308, 5, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2309, 5, 5, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2310, 5, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2311, 5, 5, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2312, 5, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2313, 5, 5, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2314, 5, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2315, 5, 5, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2316, 5, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2317, 5, 5, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2318, 5, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2319, 5, 5, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2320, 5, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2321, 5, 5, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2322, 5, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2323, 5, 5, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2324, 5, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2325, 5, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2326, 5, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2327, 5, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2328, 5, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2329, 5, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2330, 5, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2331, 5, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2332, 5, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2333, 5, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2334, 5, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2335, 5, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2336, 5, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2337, 5, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2338, 5, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2339, 5, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2340, 5, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2341, 5, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2342, 5, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2343, 5, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2344, 5, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2345, 5, 9, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2346, 5, 9, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2347, 5, 9, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2348, 5, 9, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2349, 5, 9, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2350, 5, 9, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2351, 5, 9, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2352, 5, 9, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2353, 5, 9, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2354, 5, 9, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2355, 6, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2356, 6, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2357, 6, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2358, 6, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2359, 6, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2360, 6, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2361, 6, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2362, 6, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2363, 6, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2364, 6, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2365, 6, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2366, 6, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2367, 6, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2368, 6, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2369, 6, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2370, 6, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2371, 6, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2372, 6, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2373, 6, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2374, 6, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2375, 6, 3, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2376, 6, 4, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2377, 6, 3, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2378, 6, 4, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2379, 6, 3, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2380, 6, 4, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2381, 6, 3, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2382, 6, 4, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2383, 6, 3, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2384, 6, 4, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2385, 6, 3, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2386, 6, 4, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2387, 6, 3, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2388, 6, 4, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2389, 6, 3, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2390, 6, 4, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2391, 6, 3, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2392, 6, 4, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2393, 6, 3, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2394, 6, 4, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2395, 6, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2396, 6, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2397, 6, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2398, 6, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2399, 6, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2400, 6, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2401, 6, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2402, 6, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2403, 6, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2404, 6, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2405, 6, 6, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2406, 6, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2407, 6, 6, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2408, 6, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2409, 6, 6, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2410, 6, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2411, 6, 6, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2412, 6, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2413, 6, 6, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2414, 6, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2415, 6, 6, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2416, 6, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2417, 6, 6, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2418, 6, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2419, 6, 6, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2420, 6, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2421, 6, 6, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2422, 6, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2423, 6, 6, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2424, 6, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2425, 6, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2426, 6, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2427, 6, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2428, 6, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2429, 6, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2430, 6, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2431, 6, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2432, 6, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2433, 6, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2434, 6, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2435, 6, 9, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2436, 6, 9, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2437, 6, 9, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2438, 6, 9, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2439, 6, 9, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2440, 6, 9, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2441, 6, 9, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2442, 6, 9, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2443, 6, 9, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2444, 6, 9, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2445, 7, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2446, 7, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2447, 7, 1, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2448, 7, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2449, 7, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2450, 7, 1, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2451, 7, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2452, 7, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2453, 7, 1, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2454, 7, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2455, 7, 1, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2456, 7, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2457, 7, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2458, 7, 2, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2459, 7, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2460, 7, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2461, 7, 2, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2462, 7, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2463, 7, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2464, 7, 2, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2465, 7, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2466, 7, 2, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2467, 7, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2468, 7, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2469, 7, 3, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2470, 7, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2471, 7, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2472, 7, 3, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2473, 7, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2474, 7, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2475, 7, 3, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2476, 7, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2477, 7, 3, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2478, 7, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2479, 7, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2480, 7, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2481, 7, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2482, 7, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2483, 7, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2484, 7, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2485, 7, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2486, 7, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2487, 7, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2488, 7, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2489, 7, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2490, 7, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2491, 7, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2492, 7, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2493, 7, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2494, 7, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2495, 7, 4, 11, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2496, 7, 5, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2497, 7, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2498, 7, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2499, 7, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2500, 7, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2501, 7, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2502, 7, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2503, 7, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2504, 7, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2505, 7, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2506, 7, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2507, 7, 6, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2508, 7, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2509, 7, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2510, 7, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2511, 7, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2512, 7, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2513, 7, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2514, 7, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2515, 7, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2516, 7, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2517, 7, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2518, 7, 7, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2519, 7, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2520, 7, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2521, 7, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2522, 7, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2523, 7, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2524, 7, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2525, 7, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2526, 7, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2527, 7, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2528, 7, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2529, 7, 8, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2530, 8, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2531, 8, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2532, 8, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2533, 8, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2534, 8, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2535, 8, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2536, 8, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2537, 8, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2538, 8, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2539, 8, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2540, 8, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2541, 8, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2542, 8, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2543, 8, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2544, 8, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2545, 8, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2546, 8, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2547, 8, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2548, 8, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2549, 8, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2550, 8, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2551, 8, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2552, 8, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2553, 8, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2554, 8, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2555, 8, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2556, 8, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2557, 8, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2558, 8, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2559, 8, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2560, 8, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2561, 8, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2562, 8, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2563, 8, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2564, 8, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2565, 8, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2566, 8, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2567, 8, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2568, 8, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2569, 8, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2570, 8, 5, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2571, 8, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2572, 8, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2573, 8, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2574, 8, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2575, 8, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2576, 8, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2577, 8, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2578, 8, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2579, 8, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2580, 8, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2581, 8, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2582, 8, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2583, 8, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2584, 8, 6, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2585, 8, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2586, 8, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2587, 8, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2588, 8, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2589, 8, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2590, 8, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2591, 8, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2592, 8, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2593, 8, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2594, 8, 7, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2595, 8, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2596, 8, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2597, 8, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2598, 8, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2599, 8, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2600, 8, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2601, 8, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2602, 8, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2603, 8, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2604, 8, 8, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2605, 8, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2606, 8, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2607, 8, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2608, 8, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2609, 9, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2610, 9, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2611, 9, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2612, 9, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2613, 9, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2614, 9, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2615, 9, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2616, 9, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2617, 9, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2618, 9, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2619, 9, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2620, 9, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2621, 9, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2622, 9, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2623, 9, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2624, 9, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2625, 9, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2626, 9, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2627, 9, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2628, 9, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2629, 9, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2630, 9, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2631, 9, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2632, 9, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2633, 9, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2634, 9, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2635, 9, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2636, 9, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2637, 9, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2638, 9, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2639, 9, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2640, 9, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2641, 9, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2642, 9, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2643, 9, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2644, 9, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2645, 9, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2646, 9, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2647, 9, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2648, 9, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2649, 9, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2650, 9, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2651, 9, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2652, 9, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2653, 9, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2654, 9, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2655, 9, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2656, 9, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2657, 9, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2658, 9, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2659, 9, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2660, 9, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2661, 9, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2662, 9, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2663, 9, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2664, 9, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2665, 9, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2666, 9, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2667, 9, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2668, 9, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2669, 9, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2670, 9, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2671, 9, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2672, 9, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2673, 9, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2674, 9, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2675, 9, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2676, 9, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2677, 9, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2678, 9, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2679, 9, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2680, 9, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2681, 9, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2682, 9, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2683, 9, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2684, 9, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2685, 9, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2686, 9, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2687, 9, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2688, 9, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2689, 10, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2690, 10, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2691, 10, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2692, 10, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2693, 10, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2694, 10, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2695, 10, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2696, 10, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2697, 10, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2698, 10, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2699, 10, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2700, 10, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2701, 10, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2702, 10, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2703, 10, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2704, 10, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2705, 10, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2706, 10, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2707, 10, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2708, 10, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2709, 10, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2710, 10, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2711, 10, 4, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2712, 10, 4, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2713, 10, 3, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2714, 10, 4, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2715, 10, 3, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2716, 10, 4, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2717, 10, 3, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2718, 10, 4, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2719, 10, 3, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2720, 10, 4, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2721, 10, 3, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2722, 10, 4, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2723, 10, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2724, 10, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2725, 10, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2726, 10, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2727, 10, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2728, 10, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2729, 10, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2730, 10, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2731, 10, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2732, 10, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2733, 10, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2734, 10, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2735, 10, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2736, 10, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2737, 10, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2738, 10, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2739, 10, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2740, 10, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2741, 10, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2742, 10, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2743, 10, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2744, 10, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2745, 10, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2746, 10, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2747, 10, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2748, 10, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2749, 10, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2750, 10, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2751, 11, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2752, 11, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2753, 11, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2754, 11, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2755, 11, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2756, 11, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2757, 11, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2758, 11, 1, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2759, 11, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2760, 11, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2761, 11, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2762, 11, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2763, 11, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2764, 11, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2765, 11, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2766, 11, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2767, 11, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2768, 11, 2, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2769, 11, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2770, 11, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2771, 11, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2772, 11, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2773, 11, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2774, 11, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2775, 11, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2776, 11, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2777, 11, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2778, 11, 3, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2779, 11, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2780, 11, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2781, 11, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2782, 11, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2783, 11, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2784, 11, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2785, 11, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2786, 11, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2787, 11, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2788, 11, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2789, 11, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2790, 11, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2791, 11, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2792, 11, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2793, 11, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2794, 11, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2795, 11, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2796, 11, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2797, 11, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2798, 11, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2799, 11, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2800, 11, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2801, 11, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2802, 11, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2803, 11, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2804, 11, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2805, 11, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2806, 11, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2807, 11, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2808, 11, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2809, 11, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2810, 11, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2811, 11, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2812, 11, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2813, 11, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2814, 11, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2815, 11, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2816, 11, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2817, 11, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2818, 11, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2819, 11, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2820, 11, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2821, 11, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2822, 11, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2823, 11, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2824, 11, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2825, 11, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2826, 11, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2827, 11, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2828, 11, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2829, 11, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2830, 12, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2831, 12, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2832, 12, 1, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2833, 12, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2834, 12, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2835, 12, 1, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2836, 12, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2837, 12, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2838, 12, 1, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2839, 12, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2840, 12, 1, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2841, 12, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2842, 12, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2843, 12, 2, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2844, 12, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2845, 12, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2846, 12, 2, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2847, 12, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2848, 12, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2849, 12, 2, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2850, 12, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2851, 12, 2, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2852, 12, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2853, 12, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2854, 12, 3, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2855, 12, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2856, 12, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2857, 12, 3, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2858, 12, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2859, 12, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2860, 12, 3, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2861, 12, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2862, 12, 3, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2863, 12, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2864, 12, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2865, 12, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2866, 12, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2867, 12, 5, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2868, 12, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2869, 12, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2870, 12, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2871, 12, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2872, 12, 5, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2873, 12, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2874, 12, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2875, 12, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2876, 12, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2877, 12, 5, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2878, 12, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2879, 12, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2880, 12, 4, 11, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2881, 12, 5, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2882, 12, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2883, 12, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2884, 12, 6, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2885, 12, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2886, 12, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2887, 12, 6, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2888, 12, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2889, 12, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2890, 12, 6, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2891, 12, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2892, 12, 6, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2893, 13, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2894, 13, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2895, 13, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2896, 13, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2897, 13, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2898, 13, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2899, 13, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2900, 13, 1, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2901, 13, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2902, 13, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2903, 13, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2904, 13, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2905, 13, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2906, 13, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2907, 13, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2908, 13, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2909, 13, 2, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2910, 13, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2911, 13, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2912, 13, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2913, 13, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2914, 13, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2915, 13, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2916, 13, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2917, 13, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2918, 13, 3, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2919, 13, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2920, 13, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2921, 13, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2922, 13, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2923, 13, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2924, 13, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2925, 13, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2926, 13, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2927, 13, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2928, 13, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2929, 13, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2930, 13, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2931, 13, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2932, 13, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2933, 13, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2934, 13, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2935, 13, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2936, 13, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2937, 13, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2938, 13, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2939, 13, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2940, 13, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2941, 13, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2942, 13, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2943, 13, 6, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2944, 13, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2945, 13, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2946, 13, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2947, 13, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2948, 13, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2949, 13, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2950, 13, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2951, 13, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2952, 13, 7, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2953, 13, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2954, 13, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2955, 13, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2956, 13, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2957, 13, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2958, 13, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2959, 13, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2960, 13, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2961, 13, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2962, 13, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2963, 13, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2964, 14, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2965, 14, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2966, 14, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2967, 14, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2968, 14, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2969, 14, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2970, 14, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2971, 14, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2972, 14, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2973, 14, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2974, 14, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2975, 14, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2976, 14, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2977, 14, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2978, 14, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2979, 14, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2980, 14, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2981, 14, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2982, 14, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2983, 14, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2984, 14, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2985, 14, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2986, 14, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2987, 14, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2988, 14, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2989, 14, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2990, 14, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2991, 14, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2992, 14, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2993, 14, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2994, 14, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2995, 14, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2996, 14, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2997, 14, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (2998, 14, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (2999, 14, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3000, 14, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3001, 14, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3002, 14, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3003, 14, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3004, 14, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3005, 14, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3006, 14, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3007, 14, 6, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3008, 14, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3009, 14, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3010, 14, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3011, 14, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3012, 14, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3013, 14, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3014, 14, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3015, 14, 6, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3016, 14, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3017, 14, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3018, 14, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3019, 14, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3020, 14, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3021, 14, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3022, 14, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3023, 14, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3024, 14, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3025, 14, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3026, 14, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3027, 14, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3028, 14, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3029, 15, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3030, 15, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3031, 15, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3032, 15, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3033, 15, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3034, 15, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3035, 15, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3036, 15, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3037, 15, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3038, 15, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3039, 15, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3040, 15, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3041, 15, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3042, 15, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3043, 15, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3044, 15, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3045, 15, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3046, 15, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3047, 15, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3048, 15, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3049, 15, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3050, 15, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3051, 15, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3052, 15, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3053, 15, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3054, 15, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3055, 15, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3056, 15, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3057, 15, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3058, 15, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3059, 15, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3060, 15, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3061, 15, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3062, 15, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3063, 15, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3064, 15, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3065, 15, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3066, 15, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3067, 15, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3068, 15, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3069, 15, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3070, 15, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3071, 15, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3072, 15, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3073, 15, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3074, 15, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3075, 15, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3076, 15, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3077, 15, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3078, 15, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3079, 15, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3080, 15, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3081, 15, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3082, 15, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3083, 15, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3084, 15, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3085, 15, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3086, 15, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3087, 15, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3088, 15, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3089, 15, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3090, 15, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3091, 15, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3092, 15, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3093, 15, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3094, 15, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3095, 15, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3096, 15, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3097, 15, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3098, 15, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3099, 15, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3100, 15, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3101, 15, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3102, 15, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3103, 15, 8, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3104, 15, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3105, 15, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3106, 15, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3107, 15, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3108, 15, 9, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3109, 15, 9, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3110, 15, 9, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3111, 15, 9, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3112, 15, 9, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3113, 15, 9, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3114, 15, 9, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3115, 15, 9, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3116, 15, 9, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3117, 16, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3118, 16, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3119, 16, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3120, 16, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3121, 16, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3122, 16, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3123, 16, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3124, 16, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3125, 16, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3126, 16, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3127, 16, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3128, 16, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3129, 16, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3130, 16, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3131, 16, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3132, 16, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3133, 16, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3134, 16, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3135, 16, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3136, 16, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3137, 16, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3138, 16, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3139, 16, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3140, 16, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3141, 16, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3142, 16, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3143, 16, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3144, 16, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3145, 16, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3146, 16, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3147, 16, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3148, 16, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3149, 16, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3150, 16, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3151, 16, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3152, 16, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3153, 16, 4, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3154, 16, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3155, 16, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3156, 16, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3157, 16, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3158, 16, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3159, 16, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3160, 16, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3161, 16, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3162, 16, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3163, 16, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3164, 16, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3165, 16, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3166, 16, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3167, 16, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3168, 16, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3169, 16, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3170, 16, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3171, 16, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3172, 16, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3173, 16, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3174, 16, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3175, 16, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3176, 16, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3177, 16, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3178, 16, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3179, 16, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3180, 16, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3181, 16, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3182, 16, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3183, 16, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3184, 16, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3185, 16, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3186, 16, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3187, 16, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3188, 16, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3189, 16, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3190, 16, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3191, 16, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3192, 16, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3193, 16, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3194, 16, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3195, 16, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3196, 16, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3197, 17, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3198, 17, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3199, 17, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3200, 17, 1, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3201, 17, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3202, 17, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3203, 17, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3204, 17, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3205, 17, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3206, 17, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3207, 17, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3208, 17, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3209, 17, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3210, 17, 2, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3211, 17, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3212, 17, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3213, 17, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3214, 17, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3215, 17, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3216, 17, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3217, 17, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3218, 17, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3219, 17, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3220, 17, 3, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3221, 17, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3222, 17, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3223, 17, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3224, 17, 3, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3225, 17, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3226, 17, 3, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3227, 17, 4, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3228, 17, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3229, 17, 4, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3230, 17, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3231, 17, 4, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3232, 17, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3233, 17, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3234, 17, 4, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3235, 17, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3236, 17, 4, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3237, 17, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3238, 17, 4, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3239, 17, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3240, 17, 4, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3241, 17, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3242, 17, 4, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3243, 17, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3244, 17, 4, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3245, 17, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3246, 17, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3247, 17, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3248, 17, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3249, 17, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3250, 17, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3251, 17, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3252, 17, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3253, 17, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3254, 17, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3255, 17, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3256, 17, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3257, 17, 7, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3258, 17, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3259, 17, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3260, 17, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3261, 17, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3262, 17, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3263, 17, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3264, 17, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3265, 17, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3266, 17, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3267, 17, 8, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3268, 17, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3269, 17, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3270, 17, 8, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3271, 17, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3272, 17, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3273, 17, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3274, 17, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3275, 21, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3276, 21, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3277, 21, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3278, 21, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3279, 21, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3280, 21, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3281, 21, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3282, 21, 1, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3283, 21, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3284, 21, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3285, 21, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3286, 21, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3287, 21, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3288, 21, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3289, 21, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3290, 21, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3291, 21, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3292, 21, 2, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3293, 21, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3294, 21, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3295, 21, 3, 1, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3296, 21, 4, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3297, 21, 3, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3298, 21, 4, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3299, 21, 3, 3, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3300, 21, 4, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3301, 21, 3, 4, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3302, 21, 4, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3303, 21, 3, 5, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3304, 21, 4, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3305, 21, 3, 6, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3306, 21, 4, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3307, 21, 3, 7, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3308, 21, 4, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3309, 21, 3, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3310, 21, 4, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3311, 21, 3, 9, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3312, 21, 4, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3313, 21, 3, 10, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3314, 21, 4, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3315, 21, 5, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3316, 21, 5, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3317, 21, 5, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3318, 21, 5, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3319, 21, 5, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3320, 21, 5, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3321, 21, 5, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3322, 21, 5, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3323, 21, 5, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3324, 21, 5, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3325, 21, 6, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3326, 21, 6, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3327, 21, 6, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3328, 21, 6, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3329, 21, 6, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3330, 21, 6, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3331, 21, 6, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3332, 21, 6, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3333, 21, 6, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3334, 21, 6, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3335, 21, 6, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3336, 21, 7, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3337, 21, 7, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3338, 21, 7, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3339, 21, 7, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3340, 21, 7, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3341, 21, 7, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3342, 21, 7, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3343, 21, 7, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3344, 21, 7, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3345, 21, 7, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3346, 21, 7, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3347, 21, 7, 12, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3348, 21, 8, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3349, 21, 8, 2, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3350, 21, 8, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3351, 21, 8, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3352, 21, 8, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3353, 21, 8, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3354, 21, 8, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3355, 21, 8, 8, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3356, 21, 8, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3357, 21, 8, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3358, 21, 8, 11, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3359, 21, 8, 12, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3360, 22, 1, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3361, 22, 1, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3362, 22, 1, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3363, 22, 1, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3364, 22, 1, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3365, 22, 1, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3366, 22, 1, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3367, 22, 2, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3368, 22, 2, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3369, 22, 2, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3370, 22, 2, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3371, 22, 2, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3372, 22, 2, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3373, 22, 2, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3374, 22, 3, 1, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3375, 22, 3, 2, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3376, 22, 3, 3, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3377, 22, 3, 4, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3378, 22, 3, 5, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3379, 22, 3, 6, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3380, 22, 3, 7, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3381, 22, 1, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3382, 22, 1, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3383, 22, 1, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3384, 22, 2, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3385, 22, 2, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3386, 22, 2, 10, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3387, 22, 3, 8, 'ok', 'road');
INSERT INTO `t_seat` VALUES (3388, 22, 3, 9, 'ok', 'danren');
INSERT INTO `t_seat` VALUES (3389, 22, 3, 10, 'ok', 'danren');

-- ----------------------------
-- Table structure for t_snack
-- ----------------------------
DROP TABLE IF EXISTS `t_snack`;
CREATE TABLE `t_snack`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cinema_id` int(11) NOT NULL COMMENT '所属影院',
  `image_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '显示图片',
  `first_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '套餐名称',
  `second_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '详细描述',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `cur_number` int(11) NULL DEFAULT NULL COMMENT '已售数目',
  `total_number` int(11) NULL DEFAULT NULL COMMENT '总数',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `cinema_id`(`cinema_id`) USING BTREE,
  CONSTRAINT `t_snack_ibfk_1` FOREIGN KEY (`cinema_id`) REFERENCES `t_cinema` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_snack
-- ----------------------------
INSERT INTO `t_snack` VALUES (1, 1, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (2, 1, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 26, 10000001);
INSERT INTO `t_snack` VALUES (3, 1, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (4, 1, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);
INSERT INTO `t_snack` VALUES (6, 2, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (7, 2, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 26, 10000001);
INSERT INTO `t_snack` VALUES (8, 2, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (9, 2, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);
INSERT INTO `t_snack` VALUES (10, 3, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (11, 3, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 26, 10000001);
INSERT INTO `t_snack` VALUES (12, 3, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (13, 3, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);
INSERT INTO `t_snack` VALUES (14, 4, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (15, 4, 'https://mokespace.cn/kodexplorer/index.php?share/fileProxy&user=1&sid=UEGdS7bh', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 26, 10000001);
INSERT INTO `t_snack` VALUES (16, 4, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (17, 4, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);
INSERT INTO `t_snack` VALUES (18, 5, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (19, 5, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 26, 10000001);
INSERT INTO `t_snack` VALUES (20, 5, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (21, 5, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);
INSERT INTO `t_snack` VALUES (22, 6, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (23, 6, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 26, 10000001);
INSERT INTO `t_snack` VALUES (24, 6, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (25, 6, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);
INSERT INTO `t_snack` VALUES (26, 7, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (27, 7, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 26, 10000001);
INSERT INTO `t_snack` VALUES (28, 7, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (29, 7, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);
INSERT INTO `t_snack` VALUES (31, 10, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐1号', '大份爆米花+一杯可乐', 20.50, 13, 10000002);
INSERT INTO `t_snack` VALUES (32, 10, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐2号', '爆米花1桶+热饮1杯', 32.90, 30, 9999997);
INSERT INTO `t_snack` VALUES (33, 10, 'https://mokespace.cn/weimai/upFile/套餐2.jpg', '套餐3号', '爆米花1桶+热饮1杯', 32.90, 10, 9999998);
INSERT INTO `t_snack` VALUES (34, 10, 'https://mokespace.cn/weimai/upFile/套餐1.jpg', '套餐4号', '大份爆米花+一杯可乐', 31.80, 5, 9999996);

-- ----------------------------
-- Table structure for t_times
-- ----------------------------
DROP TABLE IF EXISTS `t_times`;
CREATE TABLE `t_times`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `days_id` int(11) NOT NULL COMMENT '所属档期',
  `hall_id` int(11) NOT NULL COMMENT '安排的厅号',
  `start_time` datetime(0) NOT NULL COMMENT '开始时间',
  `price` decimal(10, 1) NOT NULL COMMENT '价格',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `days_id`(`days_id`) USING BTREE,
  INDEX `hall_id`(`hall_id`) USING BTREE,
  CONSTRAINT `t_times_ibfk_1` FOREIGN KEY (`days_id`) REFERENCES `t_days` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `t_times_ibfk_2` FOREIGN KEY (`hall_id`) REFERENCES `t_hall` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_times
-- ----------------------------
INSERT INTO `t_times` VALUES (1, 5, 8, '2020-06-07 17:10:59', 34.5);
INSERT INTO `t_times` VALUES (2, 5, 6, '2020-06-07 21:12:26', 50.0);
INSERT INTO `t_times` VALUES (3, 5, 8, '2020-06-07 19:12:47', 46.0);
INSERT INTO `t_times` VALUES (4, 21, 8, '2020-06-08 16:10:59', 34.5);
INSERT INTO `t_times` VALUES (5, 22, 5, '2020-06-09 17:10:59', 34.5);
INSERT INTO `t_times` VALUES (7, 27, 1, '2020-06-08 10:05:00', 49.5);
INSERT INTO `t_times` VALUES (8, 27, 2, '2020-06-08 14:05:00', 42.6);
INSERT INTO `t_times` VALUES (9, 28, 2, '2020-06-09 16:05:00', 42.6);
INSERT INTO `t_times` VALUES (10, 28, 1, '2020-06-07 15:05:25', 52.5);
INSERT INTO `t_times` VALUES (11, 2, 1, '2020-06-07 10:05:00', 43.0);
INSERT INTO `t_times` VALUES (12, 31, 12, '2020-06-07 16:05:00', 49.6);
INSERT INTO `t_times` VALUES (14, 33, 12, '2020-06-07 11:05:00', 50.0);
INSERT INTO `t_times` VALUES (15, 34, 3, '2020-06-07 14:05:00', 90.6);
INSERT INTO `t_times` VALUES (16, 35, 11, '2020-06-07 11:05:00', 48.8);
INSERT INTO `t_times` VALUES (17, 36, 11, '2020-06-07 10:05:00', 36.5);
INSERT INTO `t_times` VALUES (18, 37, 14, '2020-06-07 21:05:00', 40.0);
INSERT INTO `t_times` VALUES (19, 34, 4, '2020-06-07 20:05:00', 60.5);
INSERT INTO `t_times` VALUES (20, 3, 1, '2020-06-07 19:05:00', 45.0);
INSERT INTO `t_times` VALUES (21, 39, 18, '2020-06-07 21:05:00', 45.5);
INSERT INTO `t_times` VALUES (22, 40, 18, '2020-06-07 20:05:00', 30.6);
INSERT INTO `t_times` VALUES (23, 41, 17, '2020-06-07 20:05:00', 46.5);
INSERT INTO `t_times` VALUES (24, 42, 17, '2020-06-07 21:05:00', 29.9);
INSERT INTO `t_times` VALUES (25, 43, 17, '2020-06-08 12:05:00', 49.9);
INSERT INTO `t_times` VALUES (26, 44, 17, '2020-06-08 16:05:00', 40.5);
INSERT INTO `t_times` VALUES (27, 45, 18, '2020-06-08 10:05:00', 39.9);
INSERT INTO `t_times` VALUES (28, 46, 18, '2020-06-08 16:05:00', 50.0);
INSERT INTO `t_times` VALUES (29, 45, 18, '2020-06-08 14:05:00', 39.9);
INSERT INTO `t_times` VALUES (30, 1, 3, '2020-06-07 17:49:04', 40.5);
INSERT INTO `t_times` VALUES (31, 47, 10, '2020-06-08 16:05:00', 48.8);
INSERT INTO `t_times` VALUES (32, 48, 9, '2020-06-08 20:05:00', 48.8);
INSERT INTO `t_times` VALUES (33, 49, 10, '2020-06-08 21:05:00', 29.9);
INSERT INTO `t_times` VALUES (34, 50, 17, '2020-06-09 16:05:00', 30.5);
INSERT INTO `t_times` VALUES (35, 51, 10, '2020-06-08 14:05:00', 45.5);
INSERT INTO `t_times` VALUES (36, 52, 17, '2020-06-08 12:05:00', 39.9);
INSERT INTO `t_times` VALUES (37, 53, 18, '2020-06-08 12:05:00', 50.0);
INSERT INTO `t_times` VALUES (38, 54, 11, '2020-06-08 21:05:00', 49.9);
INSERT INTO `t_times` VALUES (39, 55, 16, '2020-06-08 09:05:00', 30.6);
INSERT INTO `t_times` VALUES (40, 56, 5, '2020-06-08 12:05:00', 30.0);
INSERT INTO `t_times` VALUES (41, 57, 22, '2020-06-08 11:05:00', 30.9);

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `avatar_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '头像url',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户昵称',
  `gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '性别',
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'open_id',
  `last_login` datetime(0) NULL DEFAULT NULL COMMENT '最后一次登录时间',
  `is_banned` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否被禁用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user
-- ----------------------------
INSERT INTO `t_user` VALUES (1, 'https://wx.qlogo.cn/mmopen/vi_32/N4wrn5qPc6j9bnE2GiawUkRiboADOH7V6aM9r4NmFTXKgTZiagDbJ19T7ykiaXLTH88cYImsoj7KlLPn453icmLibPWg/132', 'MOKE', '男', 'oC9Kp5UGsgnMiU2IW8eNjp9XozI8', '2020-06-09 21:09:07', b'0');
INSERT INTO `t_user` VALUES (2, 'https://wx.qlogo.cn/mmopen/vi_32/H5fpxrtsryBBcLNTv4aiaqSibgwyJy8bCbsxdV8fNAgmCmsib2HmHentV8iaLnetpzSqhSVWqcH55USluCa8DR8qIA/132', 'XIAOHAO', '男', 'oC9Kp5YGEgm5OxBxLUXvgvZGHLPY', '2020-02-29 21:42:01', b'0');
INSERT INTO `t_user` VALUES (3, 'https://wx.qlogo.cn/mmopen/vi_32/Zb2h8QtsPFq6Kw3ycJZw0OgGRUm9eU1iaQHW7VUJULFco5YZ8N3xHZiaa4pGRWfjexVg0HGH28lofv3H5QHSxEBg/132', 'XD', '男', 'oC9Kp5cROke6jxgGUgeYkFBKGE44', '2020-03-01 12:15:01', b'0');
INSERT INTO `t_user` VALUES (4, 'https://wx.qlogo.cn/mmopen/vi_32/H5fpxrtsryBBcLNTv4aiaqSibgwyJy8bCbsxdV8fNAgmCmsib2HmHentV8iaLnetpzSqhSVWqcH55USluCa8DR8qIA/132', 'Stenv', '男', 'oC9Kp5cROke6jxgGUgeYkFBKGE44', '2020-03-01 12:15:01', b'0');
INSERT INTO `t_user` VALUES (5, 'https://wx.qlogo.cn/mmopen/vi_32/Zb2h8QtsPFq6Kw3ycJZw0OgGRUm9eU1iaQHW7VUJULFco5YZ8N3xHZiaa4pGRWfjexVg0HGH28lofv3H5QHSxEBg/132', 'TEST', '男', 'oC9Kp5cROke6jxgGUgeYkFBKGE44', '2020-03-01 12:15:01', b'0');
INSERT INTO `t_user` VALUES (6, 'https://wx.qlogo.cn/mmopen/vi_32/N4wrn5qPc6j9bnE2GiawUkRiboADOH7V6aM9r4NmFTXKgTZiagDbJ19T7ykiaXLTH88cYImsoj7KlLPn453icmLibPWg/132', 'USER', '男', 'oC9Kp5cROke6jxgGUgeYkFBKGE44', '2020-03-01 12:15:01', b'0');
INSERT INTO `t_user` VALUES (7, 'https://wx.qlogo.cn/mmopen/vi_32/Zb2h8QtsPFq6Kw3ycJZw0OgGRUm9eU1iaQHW7VUJULFco5YZ8N3xHZiaa4pGRWfjexVg0HGH28lofv3H5QHSxEBg/132', 'AN', '女', 'oC9Kp5cROke6jxgGUgeYkFBKGE44', '2020-03-01 12:15:01', b'0');
INSERT INTO `t_user` VALUES (8, 'https://wx.qlogo.cn/mmopen/vi_32/Zb2h8QtsPFq6Kw3ycJZw0OgGRUm9eU1iaQHW7VUJULFco5YZ8N3xHZiaa4pGRWfjexVg0HGH28lofv3H5QHSxEBg/132', '默', '男', 'oC9Kp5cROke6jxgGUgeYkFBKGE44', '2020-03-01 12:15:01', b'0');
INSERT INTO `t_user` VALUES (9, 'https://wx.qlogo.cn/mmopen/vi_32/N4wrn5qPc6j9bnE2GiawUkRiboADOH7V6aM9r4NmFTXKgTZiagDbJ19T7ykiaXLTH88cYImsoj7KlLPn453icmLibPWg/132', '圈圈', '男', 'oC9Kp5cROke6jxgGUgeYkFBKGE44', '2020-03-01 12:15:01', b'0');
INSERT INTO `t_user` VALUES (10, 'https://wx.qlogo.cn/mmopen/vi_32/DYAIOgq83eqpjeF74cdG58tnKmsRMaoPVvjPjImyscDg9DjACwvia5iaBevRBwC4nqMj2D9hsXt5Iy7roYIMc4mA/132', '佩娇', '女', 'oC9Kp5dZ_JZX0eTXNiguodHust1Q', '2020-05-29 15:23:06', b'0');

-- ----------------------------
-- Function structure for get_distance
-- ----------------------------
DROP FUNCTION IF EXISTS `get_distance`;
delimiter ;;
CREATE FUNCTION `get_distance`(lng1 DOUBLE,
	lat1 DOUBLE,
	lng2 DOUBLE,
	lat2 DOUBLE)
 RETURNS double
BEGIN
	RETURN ROUND(
		6378.138 * 2 * ASIN(
			SQRT(
				POW(
					SIN(
						(
							lat1 * PI() / 180 - lat2 * PI() / 180
						) / 2
					),
					2
				) + COS(lat1 * PI() / 180) * COS(lat2 * PI() / 180) * POW(
					SIN(
						(
							lng1 * PI() / 180 - lng2 * PI() / 180
						) / 2
					),
					2
				)
			)
		) * 1000
	);
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
