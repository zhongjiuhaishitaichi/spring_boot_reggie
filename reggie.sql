/*
 Navicat MySQL Data Transfer

 Source Server         : swx mysql02
 Source Server Type    : MySQL
 Source Server Version : 50719
 Source Host           : localhost:3306
 Source Schema         : reggie

 Target Server Type    : MySQL
 Target Server Version : 50719
 File Encoding         : 65001

 Date: 08/10/2022 15:31:26
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address_book
-- ----------------------------
DROP TABLE IF EXISTS `address_book`;
CREATE TABLE `address_book`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `user_id` bigint(20) NOT NULL COMMENT '用户id',
  `consignee` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '收货人',
  `sex` tinyint(4) NOT NULL COMMENT '性别 0 女 1 男',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `province_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省级区划编号',
  `province_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省级名称',
  `city_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市级区划编号',
  `city_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '市级名称',
  `district_code` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区级区划编号',
  `district_name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区级名称',
  `detail` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '详细地址',
  `label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标签',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '默认 0 否 1是',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '地址管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address_book
-- ----------------------------
INSERT INTO `address_book` VALUES (1417414526093082626, 1417012167126876162, '小明', 1, '13812345678', NULL, NULL, NULL, NULL, NULL, NULL, '昌平区金燕龙办公楼', '公司', 1, '2021-07-20 17:22:12', '2021-07-20 17:26:33', 1417012167126876162, 1417012167126876162, 0);
INSERT INTO `address_book` VALUES (1417414926166769666, 1417012167126876162, '小李', 1, '13512345678', NULL, NULL, NULL, NULL, NULL, NULL, '测试', '家', 0, '2021-07-20 17:23:47', '2021-07-20 17:23:47', 1417012167126876162, 1417012167126876162, 0);
INSERT INTO `address_book` VALUES (1577982680513904641, 1, 'sxysxy', 0, '13653529985', NULL, NULL, NULL, NULL, NULL, NULL, '齐鲁工业大学', '学校', 1, '2022-10-06 19:22:43', '2022-10-07 20:44:23', 1, 1, 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `type` int(11) NULL DEFAULT NULL COMMENT '类型   1 菜品分类 2 套餐分类',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '分类名称',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_category_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品及套餐分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1397844263642378242, 1, '湘菜', 1, '2021-05-27 09:16:58', '2021-07-15 20:25:23', 1, 1);
INSERT INTO `category` VALUES (1397844303408574465, 1, '川菜', 2, '2021-05-27 09:17:07', '2021-06-02 14:27:22', 1, 1);
INSERT INTO `category` VALUES (1397844391040167938, 1, '粤菜', 3, '2021-05-27 09:17:28', '2021-07-09 14:37:13', 1, 1);
INSERT INTO `category` VALUES (1413341197421846529, 1, '饮品', 11, '2021-07-09 11:36:15', '2021-07-09 14:39:15', 1, 1);
INSERT INTO `category` VALUES (1413384954989060097, 1, '主食123', 12, '2021-07-09 14:30:07', '2022-10-03 15:17:41', 1, 1);
INSERT INTO `category` VALUES (1413386191767674881, 2, '儿童套餐', 6, '2021-07-09 14:35:02', '2021-07-09 14:39:05', 1, 1);
INSERT INTO `category` VALUES (1577623593842425857, 2, '我是老八', 2, '2022-10-05 19:35:50', '2022-10-05 19:35:50', 1, 1);

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜品名称',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品价格',
  `code` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '商品码',
  `image` varchar(200) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '图片',
  `description` varchar(400) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0 停售 1 起售',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '顺序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_dish_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (1397849739276890114, '辣子鸡', 1397844263642378242, 7800.00, '222222222', 'f966a38e-0780-40be-bb52-5699d13cb3d9.jpg', '来自鲜嫩美味的小鸡，值得一尝', 1, 0, '2021-05-27 09:38:43', '2021-05-27 09:38:43', 1, 1, 0);
INSERT INTO `dish` VALUES (1397850140982161409, '毛氏红烧肉', 1397844263642378242, 6800.00, '123412341234', '0a3b3288-3446-4420-bbff-f263d0c02d8e.jpg', '毛氏红烧肉毛氏红烧肉，确定不来一份？', 1, 0, '2021-05-27 09:40:19', '2021-05-27 09:40:19', 1, 1, 0);
INSERT INTO `dish` VALUES (1397850392090947585, '组庵鱼翅', 1397844263642378242, 4800.00, '123412341234', '740c79ce-af29-41b8-b78d-5f49c96e38c4.jpg', '组庵鱼翅，看图足以表明好吃程度', 0, 0, '2021-05-27 09:41:19', '2021-05-27 09:41:19', 1, 1, 0);
INSERT INTO `dish` VALUES (1397850851245600769, '霸王别姬', 1397844263642378242, 12800.00, '123412341234', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', '还有什么比霸王别姬更美味的呢？', 1, 0, '2021-05-27 09:43:08', '2021-05-27 09:43:08', 1, 1, 0);
INSERT INTO `dish` VALUES (1397851099502260226, '全家福', 1397844263642378242, 11800.00, '23412341234', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', '别光吃肉啦，来份全家福吧，让你长寿又美味', 1, 0, '2021-05-27 09:44:08', '2021-05-27 09:44:08', 1, 1, 0);
INSERT INTO `dish` VALUES (1397851370462687234, '邵阳猪血丸子', 1397844263642378242, 13800.00, '1246812345678', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', '看，美味不？来嘛来嘛，这才是最爱吖', 1, 0, '2021-05-27 09:45:12', '2021-05-27 09:45:12', 1, 1, 0);
INSERT INTO `dish` VALUES (1397851668262465537, '口味蛇', 1397844263642378242, 16800.00, '1234567812345678', '0f4bd884-dc9c-4cf9-b59e-7d5958fec3dd.jpg', '爬行界的扛把子，东兴-口味蛇，让你欲罢不能', 1, 0, '2021-05-27 09:46:23', '2021-05-27 09:46:23', 1, 1, 0);
INSERT INTO `dish` VALUES (1397852391150759938, '辣子鸡丁', 1397844303408574465, 8800.00, '2346812468', 'ef2b73f2-75d1-4d3a-beea-22da0e1421bd.jpg', '辣子鸡丁，辣子鸡丁，永远的魂', 1, 0, '2021-05-27 09:49:16', '2021-05-27 09:49:16', 1, 1, 0);
INSERT INTO `dish` VALUES (1397853183287013378, '麻辣兔头', 1397844303408574465, 19800.00, '123456787654321', '2a2e9d66-b41d-4645-87bd-95f2cfeed218.jpg', '麻辣兔头的详细制作，麻辣鲜香，色泽红润，回味悠长', 1, 0, '2021-05-27 09:52:24', '2021-05-27 09:52:24', 1, 1, 0);
INSERT INTO `dish` VALUES (1397853890262118402, '鱼香肉丝', 1397844303408574465, 3800.00, '1234212321234', '8dcfda14-5712-4d28-82f7-ae905b3c2308.jpg', '鱼香肉丝简直就是我们童年回忆的一道经典菜，上学的时候点个鱼香肉丝盖饭坐在宿舍床上看着肥皂剧，绝了！现在完美复刻一下上学的时候感觉', 1, 0, '2021-05-27 09:55:13', '2021-05-27 09:55:13', 1, 1, 0);
INSERT INTO `dish` VALUES (1397854652581064706, '麻辣水煮鱼', 1397844303408574465, 14800.00, '2345312·345321', '1fdbfbf3-1d86-4b29-a3fc-46345852f2f8.jpg', '鱼片是买的切好的鱼片，放几个虾，增加味道', 1, 0, '2021-05-27 09:58:15', '2021-05-27 09:58:15', 1, 1, 0);
INSERT INTO `dish` VALUES (1397854865672679425, '鱼香炒鸡蛋', 1397844303408574465, 2000.00, '23456431·23456', '0f252364-a561-4e8d-8065-9a6797a6b1d3.jpg', '鱼香菜也是川味的特色。里面没有鱼却鱼香味', 1, 0, '2021-05-27 09:59:06', '2021-05-27 09:59:06', 1, 1, 0);
INSERT INTO `dish` VALUES (1397860242057375745, '脆皮烧鹅', 1397844391040167938, 12800.00, '123456786543213456', 'e476f679-5c15-436b-87fa-8c4e9644bf33.jpeg', '“广东烤鸭美而香，却胜烧鹅说古冈（今新会），燕瘦环肥各佳妙，君休偏重便宜坊”，可见烧鹅与烧鸭在粤菜之中已早负盛名。作为广州最普遍和最受欢迎的烧烤肉食，以它的“色泽金红，皮脆肉嫩，味香可口”的特色，在省城各大街小巷的烧卤店随处可见。', 1, 0, '2021-05-27 10:20:27', '2021-05-27 10:20:27', 1, 1, 0);
INSERT INTO `dish` VALUES (1397860578738352129, '白切鸡', 1397844391040167938, 6600.00, '12345678654', '9ec6fc2d-50d2-422e-b954-de87dcd04198.jpeg', '白切鸡是一道色香味俱全的特色传统名肴，又叫白斩鸡，是粤菜系鸡肴中的一种，始于清代的民间。白切鸡通常选用细骨农家鸡与沙姜、蒜茸等食材，慢火煮浸白切鸡皮爽肉滑，清淡鲜美。著名的泮溪酒家白切鸡，曾获商业部优质产品金鼎奖。湛江白切鸡更是驰名粤港澳。粤菜厨坛中，鸡的菜式有200余款之多，而最为人常食不厌的正是白切鸡，深受食家青睐。', 0, 0, '2021-05-27 10:21:48', '2021-05-27 10:21:48', 1, 1, 0);
INSERT INTO `dish` VALUES (1397860792492666881, '烤乳猪', 1397844391040167938, 38800.00, '213456432123456', '2e96a7e3-affb-438e-b7c3-e1430df425c9.jpeg', '广式烧乳猪主料是小乳猪，辅料是蒜，调料是五香粉、芝麻酱、八角粉等，本菜品主要通过将食材放入炭火中烧烤而成。烤乳猪是广州最著名的特色菜，并且是“满汉全席”中的主打菜肴之一。烤乳猪也是许多年来广东人祭祖的祭品之一，是家家都少不了的应节之物，用乳猪祭完先人后，亲戚们再聚餐食用。', 1, 0, '2021-05-27 10:22:39', '2021-05-27 10:22:39', 1, 1, 0);
INSERT INTO `dish` VALUES (1397860963880316929, '脆皮乳鸽', 1397844391040167938, 10800.00, '1234563212345', '3fabb83a-1c09-4fd9-892b-4ef7457daafa.jpeg', '“脆皮乳鸽”是广东菜中的一道传统名菜，属于粤菜系，具有皮脆肉嫩、色泽红亮、鲜香味美的特点，常吃可使身体强健，清肺顺气。随着菜品制作工艺的不断发展，逐渐形成了熟炸法、生炸法和烤制法三种制作方法。无论那种制作方法，都是在鸽子经过一系列的加工，挂脆皮水后再加工而成，正宗的“脆皮乳鸽皮脆肉嫩、色泽红亮、鲜香味美、香气馥郁。这三种方法的制作过程都不算复杂，但想达到理想的效果并不容易。', 1, 0, '2021-05-27 10:23:19', '2021-05-27 10:23:19', 1, 1, 0);
INSERT INTO `dish` VALUES (1397861683434139649, '清蒸河鲜海鲜', 1397844391040167938, 38800.00, '1234567876543213456', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', '新鲜的海鲜，清蒸是最好的处理方式。鲜，体会为什么叫海鲜。清蒸是广州最经典的烹饪手法，过去岭南地区由于峻山大岭阻隔，交通不便，经济发展起步慢，自家打的鱼放在锅里煮了就吃，没有太多的讲究，但却发现这清淡的煮法能使鱼的鲜甜跃然舌尖。', 1, 0, '2021-05-27 10:26:11', '2021-05-27 10:26:11', 1, 1, 0);
INSERT INTO `dish` VALUES (1397862198033297410, '老火靓汤', 1397844391040167938, 49800.00, '123456786532455', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', '老火靓汤又称广府汤，是广府人传承数千年的食补养生秘方，慢火煲煮的中华老火靓汤，火候足，时间长，既取药补之效，又取入口之甘甜。 广府老火汤种类繁多，可以用各种汤料和烹调方法，烹制出各种不同口味、不同功效的汤来。', 1, 0, '2021-05-27 10:28:14', '2021-05-27 10:28:14', 1, 1, 0);
INSERT INTO `dish` VALUES (1397862477831122945, '上汤焗龙虾', 1397844391040167938, 108800.00, '1234567865432', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', '上汤焗龙虾是一道色香味俱全的传统名菜，属于粤菜系。此菜以龙虾为主料，配以高汤制成的一道海鲜美食。本品肉质洁白细嫩，味道鲜美，蛋白质含量高，脂肪含量低，营养丰富。是色香味俱全的传统名菜。', 1, 0, '2021-05-27 10:29:20', '2021-05-27 10:29:20', 1, 1, 0);
INSERT INTO `dish` VALUES (1413342036832100354, '北冰洋', 1413341197421846529, 500.00, '', 'c99e0aab-3cb7-4eaa-80fd-f47d4ffea694.png', '', 1, 0, '2021-07-09 11:39:35', '2021-07-09 15:12:18', 1, 1, 0);
INSERT INTO `dish` VALUES (1413385247889891330, '米饭', 1413384954989060097, 200.00, '', 'ee04a05a-1230-46b6-8ad5-1a95b140fff3.png', '', 1, 0, '2021-07-09 14:31:17', '2021-07-11 16:35:26', 1, 1, 0);
INSERT INTO `dish` VALUES (1577315154251526145, 'dcn', 1397844263642378242, 122300.00, '', 'cf655e71-81ec-44c4-8e03-56c6794de858.jpg', 'wu', 0, 0, '2022-10-04 23:10:13', '2022-10-04 23:10:13', 1, 1, 0);

-- ----------------------------
-- Table structure for dish_flavor
-- ----------------------------
DROP TABLE IF EXISTS `dish_flavor`;
CREATE TABLE `dish_flavor`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `dish_id` bigint(20) NOT NULL COMMENT '菜品',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '口味名称',
  `value` varchar(500) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味数据list',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '菜品口味关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish_flavor
-- ----------------------------
INSERT INTO `dish_flavor` VALUES (1397849417888346113, 1397849417854791681, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:37:27', '2021-05-27 09:37:27', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397849739297861633, 1397849739276890114, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:38:43', '2021-05-27 09:38:43', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397849739323027458, 1397849739276890114, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:38:43', '2021-05-27 09:38:43', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397849936421761025, 1397849936404983809, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:39:30', '2021-05-27 09:39:30', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397849936438538241, 1397849936404983809, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:39:30', '2021-05-27 09:39:30', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850141015715841, 1397850140982161409, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:40:19', '2021-05-27 09:40:19', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850141040881665, 1397850140982161409, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:40:19', '2021-05-27 09:40:19', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850392120307713, 1397850392090947585, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:41:19', '2021-05-27 09:41:19', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850392137084929, 1397850392090947585, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:41:19', '2021-05-27 09:41:19', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850630734262274, 1397850630700707841, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:42:16', '2021-05-27 09:42:16', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850630755233794, 1397850630700707841, '辣度', '[\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:42:16', '2021-05-27 09:42:16', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850851274960898, 1397850851245600769, '忌口', '[\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:43:08', '2021-05-27 09:43:08', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397850851283349505, 1397850851245600769, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:43:08', '2021-05-27 09:43:08', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397851099523231745, 1397851099502260226, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:44:08', '2021-05-27 09:44:08', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397851099527426050, 1397851099502260226, '辣度', '[\"不辣\",\"微辣\",\"中辣\"]', '2021-05-27 09:44:08', '2021-05-27 09:44:08', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397851370483658754, 1397851370462687234, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2021-05-27 09:45:12', '2021-05-27 09:45:12', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397851370483658755, 1397851370462687234, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:45:12', '2021-05-27 09:45:12', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397851370483658756, 1397851370462687234, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:45:12', '2021-05-27 09:45:12', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397851668283437058, 1397851668262465537, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2021-05-27 09:46:23', '2021-05-27 09:46:23', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397852391180120065, 1397852391150759938, '忌口', '[\"不要葱\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:49:16', '2021-05-27 09:49:16', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397852391196897281, 1397852391150759938, '辣度', '[\"不辣\",\"微辣\",\"重辣\"]', '2021-05-27 09:49:16', '2021-05-27 09:49:16', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397853183307984898, 1397853183287013378, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:52:24', '2021-05-27 09:52:24', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397853423486414850, 1397853423461249026, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:53:22', '2021-05-27 09:53:22', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397853709126905857, 1397853709101740034, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:54:30', '2021-05-27 09:54:30', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397853890283089922, 1397853890262118402, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:55:13', '2021-05-27 09:55:13', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397854133632413697, 1397854133603053569, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2021-05-27 09:56:11', '2021-05-27 09:56:11', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397854652623007745, 1397854652581064706, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 09:58:15', '2021-05-27 09:58:15', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397854652635590658, 1397854652581064706, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:58:15', '2021-05-27 09:58:15', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397854865735593986, 1397854865672679425, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 09:59:06', '2021-05-27 09:59:06', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397855742303186946, 1397855742273826817, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:02:35', '2021-05-27 10:02:35', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397855906497605633, 1397855906468245506, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 10:03:14', '2021-05-27 10:03:14', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397856190573621250, 1397856190540066818, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:04:21', '2021-05-27 10:04:21', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397859056709316609, 1397859056684150785, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:15:45', '2021-05-27 10:15:45', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397859277837217794, 1397859277812051969, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:16:37', '2021-05-27 10:16:37', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397859487502086146, 1397859487476920321, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:17:27', '2021-05-27 10:17:27', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397859757061615618, 1397859757036449794, '甜味', '[\"无糖\",\"少糖\",\"半躺\",\"多糖\",\"全糖\"]', '2021-05-27 10:18:32', '2021-05-27 10:18:32', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397860242086735874, 1397860242057375745, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:20:27', '2021-05-27 10:20:27', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397860963918065665, 1397860963880316929, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:23:19', '2021-05-27 10:23:19', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397861135754506242, 1397861135733534722, '甜味', '[\"无糖\",\"少糖\",\"半躺\",\"多糖\",\"全糖\"]', '2021-05-27 10:24:00', '2021-05-27 10:24:00', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397861370035744769, 1397861370010578945, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-27 10:24:56', '2021-05-27 10:24:56', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397861683459305474, 1397861683434139649, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 10:26:11', '2021-05-27 10:26:11', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397861898467717121, 1397861898438356993, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 10:27:02', '2021-05-27 10:27:02', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397862198054268929, 1397862198033297410, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-27 10:28:14', '2021-05-27 10:28:14', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1397862477835317250, 1397862477831122945, '辣度', '[\"不辣\",\"微辣\",\"中辣\"]', '2021-05-27 10:29:20', '2021-05-27 10:29:20', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398089545865015297, 1398089545676271617, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2021-05-28 01:31:38', '2021-05-28 01:31:38', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398089782323097601, 1398089782285348866, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:32:34', '2021-05-28 01:32:34', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398090003262255106, 1398090003228700673, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-28 01:33:27', '2021-05-28 01:33:27', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398090264554811394, 1398090264517062657, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-28 01:34:29', '2021-05-28 01:34:29', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398090455399837698, 1398090455324340225, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:35:14', '2021-05-28 01:35:14', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398090685449023490, 1398090685419663362, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2021-05-28 01:36:09', '2021-05-28 01:36:09', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398090825358422017, 1398090825329061889, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-28 01:36:43', '2021-05-28 01:36:43', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398091007051476993, 1398091007017922561, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:37:26', '2021-05-28 01:37:26', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398091296164851713, 1398091296131297281, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:38:35', '2021-05-28 01:38:35', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398091546531246081, 1398091546480914433, '忌口', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2021-05-28 01:39:35', '2021-05-28 01:39:35', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398091729809747969, 1398091729788776450, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:40:18', '2021-05-28 01:40:18', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398091889499484161, 1398091889449152513, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:40:56', '2021-05-28 01:40:56', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398092095179763713, 1398092095142014978, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:41:45', '2021-05-28 01:41:45', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398092283877306370, 1398092283847946241, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:42:30', '2021-05-28 01:42:30', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398094018939236354, 1398094018893099009, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:49:24', '2021-05-28 01:49:24', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1398094391494094850, 1398094391456346113, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-05-28 01:50:53', '2021-05-28 01:50:53', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1399574026165727233, 1399305325713600514, '辣度', '[\"不辣\",\"微辣\",\"中辣\",\"重辣\"]', '2021-06-01 03:50:25', '2021-06-01 03:50:25', 1399309715396669441, 1399309715396669441, 0);
INSERT INTO `dish_flavor` VALUES (1413389540592263169, 1413384757047271425, '温度', '[\"常温\",\"冷藏\"]', '2021-07-12 09:09:16', '2021-07-12 09:09:16', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1413389684020682754, 1413342036832100354, '温度', '[\"常温\",\"冷藏\"]', '2021-07-09 15:12:18', '2021-07-09 15:12:18', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1577203342067646466, 1577203342017314818, '123123', '[\"常温\"]', '2022-10-04 20:17:38', '2022-10-04 20:17:38', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1577271723701604353, 1577203342017314818, '123123', '[\"不要葱\",\"不要蒜\",\"不要香菜\",\"不要辣\"]', '2022-10-04 20:17:38', '2022-10-04 20:17:38', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1577315154322829313, 1577315154251526145, '甜味', '[\"无糖\",\"少糖\",\"半糖\",\"多糖\",\"全糖\"]', '2022-10-04 23:10:13', '2022-10-04 23:10:13', 1, 1, 0);
INSERT INTO `dish_flavor` VALUES (1577315154322829314, 1577315154251526145, '温度', '[\"热饮\",\"常温\",\"去冰\",\"少冰\",\"多冰\"]', '2022-10-04 23:10:13', '2022-10-04 23:10:13', 1, 1, 0);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '密码',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '手机号',
  `sex` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '性别',
  `id_number` varchar(18) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '状态 0:禁用，1:正常',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '员工信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '13812312312', '1', '110101199001010047', 1, '2021-05-06 17:20:07', '2021-05-10 02:24:09', 1, 1);
INSERT INTO `employee` VALUES (2, 'swx', '123123', '4297f44b13955235245b2497399d7a93', '13123123123', '1', '123123123123333', 1, '2022-10-02 14:29:25', '2022-10-02 14:29:25', 1, 1);
INSERT INTO `employee` VALUES (3, 'sxy123123', '345345', '4297f44b13955235245b2497399d7a93', '13123123123', '0', '111222333111222555', 0, '2022-10-02 14:29:25', '2022-10-02 21:54:09', 1, 1);
INSERT INTO `employee` VALUES (8, 'qweqwe', '333345', '4297f44b13955235245b2497399d7a93', '13321321321', '1', '213121244343241', 1, '2022-10-02 22:20:39', '2022-10-02 22:20:40', 1, 1);

-- ----------------------------
-- Table structure for order_detail
-- ----------------------------
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE `order_detail`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名字',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `dish_id` bigint(20) NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_detail
-- ----------------------------
INSERT INTO `order_detail` VALUES (1578342283621728257, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578342283575590914, 1397851099502260226, NULL, '不要香菜,微辣', 2, 118.00);
INSERT INTO `order_detail` VALUES (1578342283621728258, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578342283575590914, NULL, 1577637058812334081, NULL, 8, 1231.00);
INSERT INTO `order_detail` VALUES (1578342283621728259, '霸王别姬', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 1578342283575590914, 1397850851245600769, NULL, '不要蒜,微辣', 2, 128.00);
INSERT INTO `order_detail` VALUES (1578342283621728260, '清蒸河鲜海鲜', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 1578342283575590914, 1397861683434139649, NULL, '不要香菜', 1, 388.00);
INSERT INTO `order_detail` VALUES (1578342283621728261, '老火靓汤', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 1578342283575590914, 1397862198033297410, NULL, '不要辣', 3, 498.00);
INSERT INTO `order_detail` VALUES (1578342283621728262, '上汤焗龙虾', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1578342283575590914, 1397862477831122945, NULL, '不辣', 1, 1088.00);
INSERT INTO `order_detail` VALUES (1578342283621728263, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578342283575590914, 1397851370462687234, NULL, '热饮,不要香菜,重辣', 2, 138.00);
INSERT INTO `order_detail` VALUES (1578345579002535938, '辣子鸡', 'f966a38e-0780-40be-bb52-5699d13cb3d9.jpg', 1578345578935427073, 1397849739276890114, NULL, '不要蒜,中辣', 1, 78.00);
INSERT INTO `order_detail` VALUES (1578349731753558019, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578349731753558018, 1397851099502260226, NULL, '不要葱,微辣', 1, 118.00);
INSERT INTO `order_detail` VALUES (1578349731753558020, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578349731753558018, 1397851370462687234, NULL, '多冰,不要辣,微辣', 1, 138.00);
INSERT INTO `order_detail` VALUES (1578353252099977218, '辣子鸡', 'f966a38e-0780-40be-bb52-5699d13cb3d9.jpg', 1578353252032868354, 1397849739276890114, NULL, '不要蒜,微辣', 1, 78.00);
INSERT INTO `order_detail` VALUES (1578353252099977219, '毛氏红烧肉', '0a3b3288-3446-4420-bbff-f263d0c02d8e.jpg', 1578353252032868354, 1397850140982161409, NULL, '不要葱,微辣', 1, 68.00);
INSERT INTO `order_detail` VALUES (1578356661544841218, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578356661477732354, 1397851099502260226, NULL, '不要香菜,中辣', 1, 118.00);
INSERT INTO `order_detail` VALUES (1578356661544841219, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578356661477732354, 1397851370462687234, NULL, '热饮,不要香菜,微辣', 1, 138.00);
INSERT INTO `order_detail` VALUES (1578356661544841220, '鱼香肉丝', '8dcfda14-5712-4d28-82f7-ae905b3c2308.jpg', 1578356661477732354, 1397853890262118402, NULL, '微辣', 1, 38.00);
INSERT INTO `order_detail` VALUES (1578361089899393026, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578361089899393025, NULL, 1577637058812334081, NULL, 2, 1231.00);
INSERT INTO `order_detail` VALUES (1578361133104918530, '儿童套餐A计划', '61d20592-b37f-4d72-a864-07ad5bb8f3bb.jpg', 1578361133104918529, NULL, 1415580119015145474, NULL, 2, 40.00);
INSERT INTO `order_detail` VALUES (1578365454022397955, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578365454022397954, 1397851099502260226, NULL, '不要香菜,微辣', 2, 118.00);
INSERT INTO `order_detail` VALUES (1578365454022397956, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578365454022397954, NULL, 1577637058812334081, NULL, 8, 1231.00);
INSERT INTO `order_detail` VALUES (1578365454022397957, '霸王别姬', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 1578365454022397954, 1397850851245600769, NULL, '不要蒜,微辣', 2, 128.00);
INSERT INTO `order_detail` VALUES (1578365454022397958, '清蒸河鲜海鲜', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 1578365454022397954, 1397861683434139649, NULL, '不要香菜', 1, 388.00);
INSERT INTO `order_detail` VALUES (1578365454022397959, '老火靓汤', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 1578365454022397954, 1397862198033297410, NULL, '不要辣', 3, 498.00);
INSERT INTO `order_detail` VALUES (1578365454022397960, '上汤焗龙虾', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1578365454022397954, 1397862477831122945, NULL, '不辣', 1, 1088.00);
INSERT INTO `order_detail` VALUES (1578365454022397961, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578365454022397954, 1397851370462687234, NULL, '热饮,不要香菜,重辣', 2, 138.00);
INSERT INTO `order_detail` VALUES (1578368150032941057, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578368150020358145, 1397851099502260226, NULL, '不要香菜,微辣', 2, 118.00);
INSERT INTO `order_detail` VALUES (1578368150032941058, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578368150020358145, NULL, 1577637058812334081, NULL, 8, 1231.00);
INSERT INTO `order_detail` VALUES (1578368150032941059, '霸王别姬', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 1578368150020358145, 1397850851245600769, NULL, '不要蒜,微辣', 2, 128.00);
INSERT INTO `order_detail` VALUES (1578368150032941060, '清蒸河鲜海鲜', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 1578368150020358145, 1397861683434139649, NULL, '不要香菜', 1, 388.00);
INSERT INTO `order_detail` VALUES (1578368150032941061, '老火靓汤', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 1578368150020358145, 1397862198033297410, NULL, '不要辣', 3, 498.00);
INSERT INTO `order_detail` VALUES (1578368150032941062, '上汤焗龙虾', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1578368150020358145, 1397862477831122945, NULL, '不辣', 1, 1088.00);
INSERT INTO `order_detail` VALUES (1578368150032941063, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578368150020358145, 1397851370462687234, NULL, '热饮,不要香菜,重辣', 2, 138.00);
INSERT INTO `order_detail` VALUES (1578368287933267970, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578368287933267969, 1397851099502260226, NULL, '不要香菜,微辣', 2, 118.00);
INSERT INTO `order_detail` VALUES (1578368287933267971, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578368287933267969, NULL, 1577637058812334081, NULL, 8, 1231.00);
INSERT INTO `order_detail` VALUES (1578368287933267972, '霸王别姬', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 1578368287933267969, 1397850851245600769, NULL, '不要蒜,微辣', 2, 128.00);
INSERT INTO `order_detail` VALUES (1578368287933267973, '清蒸河鲜海鲜', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 1578368287933267969, 1397861683434139649, NULL, '不要香菜', 1, 388.00);
INSERT INTO `order_detail` VALUES (1578368287933267974, '老火靓汤', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 1578368287933267969, 1397862198033297410, NULL, '不要辣', 3, 498.00);
INSERT INTO `order_detail` VALUES (1578368287933267975, '上汤焗龙虾', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1578368287933267969, 1397862477831122945, NULL, '不辣', 1, 1088.00);
INSERT INTO `order_detail` VALUES (1578368287933267976, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578368287933267969, 1397851370462687234, NULL, '热饮,不要香菜,重辣', 2, 138.00);
INSERT INTO `order_detail` VALUES (1578369552935407617, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578369552868298753, 1397851099502260226, NULL, '不要香菜,微辣', 2, 118.00);
INSERT INTO `order_detail` VALUES (1578369552935407618, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578369552868298753, NULL, 1577637058812334081, NULL, 8, 1231.00);
INSERT INTO `order_detail` VALUES (1578369552935407619, '霸王别姬', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 1578369552868298753, 1397850851245600769, NULL, '不要蒜,微辣', 2, 128.00);
INSERT INTO `order_detail` VALUES (1578369552935407620, '清蒸河鲜海鲜', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 1578369552868298753, 1397861683434139649, NULL, '不要香菜', 1, 388.00);
INSERT INTO `order_detail` VALUES (1578369552935407621, '老火靓汤', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 1578369552868298753, 1397862198033297410, NULL, '不要辣', 3, 498.00);
INSERT INTO `order_detail` VALUES (1578369552935407622, '上汤焗龙虾', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1578369552868298753, 1397862477831122945, NULL, '不辣', 1, 1088.00);
INSERT INTO `order_detail` VALUES (1578369552935407623, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578369552868298753, 1397851370462687234, NULL, '热饮,不要香菜,重辣', 2, 138.00);
INSERT INTO `order_detail` VALUES (1578370325836492801, '辣子鸡', 'f966a38e-0780-40be-bb52-5699d13cb3d9.jpg', 1578370325769383938, 1397849739276890114, NULL, '不要蒜,微辣', 1, 78.00);
INSERT INTO `order_detail` VALUES (1578370325836492802, '脆皮烧鹅', 'e476f679-5c15-436b-87fa-8c4e9644bf33.jpeg', 1578370325769383938, 1397860242057375745, NULL, '重辣', 1, 128.00);
INSERT INTO `order_detail` VALUES (1578370325836492803, '烤乳猪', '2e96a7e3-affb-438e-b7c3-e1430df425c9.jpeg', 1578370325769383938, 1397860792492666881, NULL, NULL, 2, 388.00);
INSERT INTO `order_detail` VALUES (1578370721254481922, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1578370721199955970, 1397851099502260226, NULL, '不要香菜,微辣', 2, 118.00);
INSERT INTO `order_detail` VALUES (1578370721254481923, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578370721199955970, NULL, 1577637058812334081, NULL, 8, 1231.00);
INSERT INTO `order_detail` VALUES (1578370721254481924, '霸王别姬', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 1578370721199955970, 1397850851245600769, NULL, '不要蒜,微辣', 2, 128.00);
INSERT INTO `order_detail` VALUES (1578370721254481925, '清蒸河鲜海鲜', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 1578370721199955970, 1397861683434139649, NULL, '不要香菜', 1, 388.00);
INSERT INTO `order_detail` VALUES (1578370721254481926, '老火靓汤', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 1578370721199955970, 1397862198033297410, NULL, '不要辣', 3, 498.00);
INSERT INTO `order_detail` VALUES (1578370721254481927, '上汤焗龙虾', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1578370721199955970, 1397862477831122945, NULL, '不辣', 1, 1088.00);
INSERT INTO `order_detail` VALUES (1578370721254481928, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578370721199955970, 1397851370462687234, NULL, '热饮,不要香菜,重辣', 2, 138.00);
INSERT INTO `order_detail` VALUES (1578384783518523393, '我是老八', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1578384783451414529, NULL, 1577637058812334081, NULL, 1, 999.00);
INSERT INTO `order_detail` VALUES (1578384783518523394, '儿童套餐A计划', '61d20592-b37f-4d72-a864-07ad5bb8f3bb.jpg', 1578384783451414529, NULL, 1415580119015145474, NULL, 1, 40.00);
INSERT INTO `order_detail` VALUES (1578384783518523395, '脆皮烧鹅', 'e476f679-5c15-436b-87fa-8c4e9644bf33.jpeg', 1578384783451414529, 1397860242057375745, NULL, '中辣', 1, 128.00);
INSERT INTO `order_detail` VALUES (1578385419278540803, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1578385419278540802, 1397851370462687234, NULL, '常温,不要蒜,中辣', 1, 138.00);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `number` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '订单号',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '订单状态 1待付款，2待派送，3已派送，4已完成，5已取消',
  `user_id` bigint(20) NOT NULL COMMENT '下单用户',
  `address_book_id` bigint(20) NOT NULL COMMENT '地址id',
  `order_time` datetime NOT NULL COMMENT '下单时间',
  `checkout_time` datetime NOT NULL COMMENT '结账时间',
  `pay_method` int(11) NOT NULL DEFAULT 1 COMMENT '支付方式 1微信,2支付宝',
  `amount` decimal(10, 2) NOT NULL COMMENT '实收金额',
  `remark` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '备注',
  `phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  `consignee` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1578342283575590914, '1578342283575590914', 2, 1, 1577982680513904641, '2022-10-07 19:11:39', '2022-10-07 19:11:39', 1, 13586.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578345578935427073, '1578345578935427073', 2, 1, 1577982680513904641, '2022-10-07 19:24:45', '2022-10-07 19:24:45', 1, 78.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578349731753558018, '1578349731753558018', 3, 1, 1577982680513904641, '2022-10-07 19:41:15', '2022-10-07 19:41:15', 1, 256.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578353252032868354, '1578353252032868354', 2, 1, 1577982680513904641, '2022-10-07 19:55:14', '2022-10-07 19:55:14', 1, 146.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578356661477732354, '1578356661477732354', 2, 1, 1577982680513904641, '2022-10-07 20:08:47', '2022-10-07 20:08:47', 1, 294.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578361089899393025, '1578361089899393025', 2, 1, 1577982680513904641, '2022-10-07 20:26:23', '2022-10-07 20:26:23', 1, 2462.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578361133104918529, '1578361133104918529', 2, 1, 1577982680513904641, '2022-10-07 20:26:33', '2022-10-07 20:26:33', 1, 80.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578365454022397954, '1578365454022397954', 2, 1, 1577982680513904641, '2022-10-07 20:43:44', '2022-10-07 20:43:44', 1, 13586.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'swx');
INSERT INTO `orders` VALUES (1578368150020358145, '1578368150020358145', 2, 1, 1577982680513904641, '2022-10-07 20:54:26', '2022-10-07 20:54:26', 1, 13586.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'sxysxy');
INSERT INTO `orders` VALUES (1578368287933267969, '1578368287933267969', 2, 1, 1577982680513904641, '2022-10-07 20:54:59', '2022-10-07 20:54:59', 1, 13586.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'sxysxy');
INSERT INTO `orders` VALUES (1578369552868298753, '1578369552868298753', 2, 1, 1577982680513904641, '2022-10-07 21:00:01', '2022-10-07 21:00:01', 1, 13586.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'sxysxy');
INSERT INTO `orders` VALUES (1578370325769383938, '1578370325769383938', 2, 1, 1577982680513904641, '2022-10-07 21:03:05', '2022-10-07 21:03:05', 1, 982.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'sxysxy');
INSERT INTO `orders` VALUES (1578370721199955970, '1578370721199955970', 3, 1, 1577982680513904641, '2022-10-07 21:04:39', '2022-10-07 21:04:39', 1, 13586.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'sxysxy');
INSERT INTO `orders` VALUES (1578384783451414529, '1578384783451414529', 2, 1, 1577982680513904641, '2022-10-07 22:00:32', '2022-10-07 22:00:32', 1, 1167.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'sxysxy');
INSERT INTO `orders` VALUES (1578385419278540802, '1578385419278540802', 2, 1, 1577982680513904641, '2022-10-07 22:03:04', '2022-10-07 22:03:04', 1, 138.00, '', '13653529985', '齐鲁工业大学', 'sxy', 'sxysxy');

-- ----------------------------
-- Table structure for setmeal
-- ----------------------------
DROP TABLE IF EXISTS `setmeal`;
CREATE TABLE `setmeal`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `category_id` bigint(20) NOT NULL COMMENT '菜品分类id',
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '套餐名称',
  `price` decimal(10, 2) NOT NULL COMMENT '套餐价格',
  `status` int(11) NULL DEFAULT NULL COMMENT '状态 0:停用 1:启用',
  `code` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '编码',
  `description` varchar(512) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_setmeal_name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmeal
-- ----------------------------
INSERT INTO `setmeal` VALUES (1415580119015145474, 1413386191767674881, '儿童套餐A计划', 4000.00, 1, '', '', '61d20592-b37f-4d72-a864-07ad5bb8f3bb.jpg', '2021-07-15 15:52:55', '2021-07-15 15:52:55', 1415576781934608386, 1415576781934608386, 0);
INSERT INTO `setmeal` VALUES (1577637058812334081, 1577623593842425857, '我是老八', 99900.00, 1, '', '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', '2022-10-05 20:29:21', '2022-10-07 20:40:19', 1, 1, 0);

-- ----------------------------
-- Table structure for setmeal_dish
-- ----------------------------
DROP TABLE IF EXISTS `setmeal_dish`;
CREATE TABLE `setmeal_dish`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `setmeal_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '套餐id ',
  `dish_id` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '菜品id',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '菜品名称 （冗余字段）',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '菜品原价（冗余字段）',
  `copies` int(11) NOT NULL COMMENT '份数',
  `sort` int(11) NOT NULL DEFAULT 0 COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_user` bigint(20) NOT NULL COMMENT '创建人',
  `update_user` bigint(20) NOT NULL COMMENT '修改人',
  `is_deleted` int(11) NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '套餐菜品关系' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of setmeal_dish
-- ----------------------------
INSERT INTO `setmeal_dish` VALUES (1415580119052894209, '1415580119015145474', '1397862198033297410', '老火靓汤', 49800.00, 1, 0, '2021-07-15 15:52:55', '2021-07-15 15:52:55', 1415576781934608386, 1415576781934608386, 0);
INSERT INTO `setmeal_dish` VALUES (1415580119061282817, '1415580119015145474', '1413342036832100354', '北冰洋', 500.00, 1, 0, '2021-07-15 15:52:55', '2021-07-15 15:52:55', 1415576781934608386, 1415576781934608386, 0);
INSERT INTO `setmeal_dish` VALUES (1415580119069671426, '1415580119015145474', '1413385247889891330', '米饭', 200.00, 1, 0, '2021-07-15 15:52:55', '2021-07-15 15:52:55', 1415576781934608386, 1415576781934608386, 0);
INSERT INTO `setmeal_dish` VALUES (1578364595842633730, '1577637058812334081', '1397850140982161409', '毛氏红烧肉', 6800.00, 1, 0, '2022-10-07 20:40:19', '2022-10-07 20:40:19', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1578364595842633731, '1577637058812334081', '1397850392090947585', '组庵鱼翅', 4800.00, 1, 0, '2022-10-07 20:40:19', '2022-10-07 20:40:19', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1578364595842633732, '1577637058812334081', '1397849739276890114', '辣子鸡', 7800.00, 1, 0, '2022-10-07 20:40:19', '2022-10-07 20:40:19', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1578364595842633733, '1577637058812334081', '1397850851245600769', '霸王别姬', 12800.00, 1, 0, '2022-10-07 20:40:19', '2022-10-07 20:40:19', 1, 1, 0);
INSERT INTO `setmeal_dish` VALUES (1578364595842633734, '1577637058812334081', '1397851370462687234', '邵阳猪血丸子', 13800.00, 1, 0, '2022-10-07 20:40:19', '2022-10-07 20:40:19', 1, 1, 0);

-- ----------------------------
-- Table structure for shopping_cart
-- ----------------------------
DROP TABLE IF EXISTS `shopping_cart`;
CREATE TABLE `shopping_cart`  (
  `id` bigint(20) NOT NULL COMMENT '主键',
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '名称',
  `image` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '图片',
  `user_id` bigint(20) NOT NULL COMMENT '主键',
  `dish_id` bigint(20) NULL DEFAULT NULL COMMENT '菜品id',
  `setmeal_id` bigint(20) NULL DEFAULT NULL COMMENT '套餐id',
  `dish_flavor` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT '口味',
  `number` int(11) NOT NULL DEFAULT 1 COMMENT '数量',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '购物车' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of shopping_cart
-- ----------------------------
INSERT INTO `shopping_cart` VALUES (1578385447514595330, '全家福', 'a53a4e6a-3b83-4044-87f9-9d49b30a8fdc.jpg', 1, 1397851099502260226, NULL, '不要香菜,微辣', 2, 118.00, '2022-10-07 22:03:10');
INSERT INTO `shopping_cart` VALUES (1578385447514595331, '123', 'd9f9d8ba-60c6-449c-ad2d-66f8ed3317f7.jpeg', 1, NULL, 1577637058812334081, NULL, 8, 1231.00, '2022-10-07 22:03:10');
INSERT INTO `shopping_cart` VALUES (1578385447514595332, '霸王别姬', '057dd338-e487-4bbc-a74c-0384c44a9ca3.jpg', 1, 1397850851245600769, NULL, '不要蒜,微辣', 2, 128.00, '2022-10-07 22:03:10');
INSERT INTO `shopping_cart` VALUES (1578385447514595333, '清蒸河鲜海鲜', '1405081e-f545-42e1-86a2-f7559ae2e276.jpeg', 1, 1397861683434139649, NULL, '不要香菜', 1, 388.00, '2022-10-07 22:03:10');
INSERT INTO `shopping_cart` VALUES (1578385447514595334, '老火靓汤', '583df4b7-a159-4cfc-9543-4f666120b25f.jpeg', 1, 1397862198033297410, NULL, '不要辣', 3, 498.00, '2022-10-07 22:03:10');
INSERT INTO `shopping_cart` VALUES (1578385447514595335, '上汤焗龙虾', '5b8d2da3-3744-4bb3-acdc-329056b8259d.jpeg', 1, 1397862477831122945, NULL, '不辣', 1, 1088.00, '2022-10-07 22:03:10');
INSERT INTO `shopping_cart` VALUES (1578385447514595336, '邵阳猪血丸子', '2a50628e-7758-4c51-9fbb-d37c61cdacad.jpg', 1, 1397851370462687234, NULL, '热饮,不要香菜,重辣', 2, 138.00, '2022-10-07 22:03:10');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `idNumber` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `avatar` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `status` int(10) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'sxy', '2352768777@qq.com', '2', '123123123123', '0', 1);

SET FOREIGN_KEY_CHECKS = 1;
