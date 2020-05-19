const app = getApp();
const util = require('../../../utils/util.js')
const throttle = util.throttle
const citys = [{
    'id': '1',
    'city_name': '上海',
    'city_pre': 'S',
    'city_pinyin': 'Shanghai',
    'city_short': 'sh',
    'count': '311'
  },
  {
    'id': '2',
    'city_name': '北京',
    'city_pre': 'B',
    'city_pinyin': 'Beijing',
    'city_short': 'bj',
    'count': '208'
  },
  {
    'id': '3',
    'city_name': '深圳',
    'city_pre': 'S',
    'city_pinyin': 'Shenzhen',
    'city_short': 'sz',
    'count': '260'
  },
  {
    'id': '4',
    'city_name': '重庆',
    'city_pre': 'C',
    'city_pinyin': 'Chongqing',
    'city_short': 'cq',
    'count': '227'
  },
  {
    'id': '5',
    'city_name': '广州',
    'city_pre': 'G',
    'city_pinyin': 'Guangzhou',
    'city_short': 'gz',
    'count': '182'
  },
  {
    'id': '6',
    'city_name': '成都',
    'city_pre': 'C',
    'city_pinyin': 'Chengdu',
    'city_short': 'cd',
    'count': '165'
  },
  {
    'id': '7',
    'city_name': '武汉',
    'city_pre': 'W',
    'city_pinyin': 'Wuhan',
    'city_short': 'wh',
    'count': '122'
  },
  {
    'id': '8',
    'city_name': '东莞',
    'city_pre': 'D',
    'city_pinyin': 'Dongguan',
    'city_short': 'dg',
    'count': '135'
  },
  {
    'id': '9',
    'city_name': '天津',
    'city_pre': 'T',
    'city_pinyin': 'Tianjin',
    'city_short': 'tj',
    'count': '96'
  },
  {
    'id': '10',
    'city_name': '杭州',
    'city_pre': 'H',
    'city_pinyin': 'Hangzhou',
    'city_short': 'hz',
    'count': '152'
  },
  {
    'id': '11',
    'city_name': '沈阳',
    'city_pre': 'S',
    'city_pinyin': 'Shenyang',
    'city_short': 'sy',
    'count': '70'
  },
  {
    'id': '12',
    'city_name': '佛山',
    'city_pre': 'F',
    'city_pinyin': 'Foshan',
    'city_short': 'fs',
    'count': '119'
  },
  {
    'id': '13',
    'city_name': '合肥',
    'city_pre': 'H',
    'city_pinyin': 'Hefei',
    'city_short': 'hf',
    'count': '83'
  },
  {
    'id': '14',
    'city_name': '南京',
    'city_pre': 'N',
    'city_pinyin': 'Nanjing',
    'city_short': 'nj',
    'count': '95'
  },
  {
    'id': '15',
    'city_name': '长沙',
    'city_pre': 'C',
    'city_pinyin': 'Changsha',
    'city_short': 'cs',
    'count': '90'
  },
  {
    'id': '16',
    'city_name': '西安',
    'city_pre': 'X',
    'city_pinyin': 'Xian',
    'city_short': 'xa',
    'count': '103'
  },
  {
    'id': '17',
    'city_name': '郑州',
    'city_pre': 'Z',
    'city_pinyin': 'Zhengzhou',
    'city_short': 'zz',
    'count': '94'
  },
  {
    'id': '18',
    'city_name': '宁波',
    'city_pre': 'N',
    'city_pinyin': 'Ningbo',
    'city_short': 'nb',
    'count': '68'
  },
  {
    'id': '19',
    'city_name': '大连',
    'city_pre': 'D',
    'city_pinyin': 'Dalian',
    'city_short': 'dl',
    'count': '53'
  },
  {
    'id': '20',
    'city_name': '青岛',
    'city_pre': 'Q',
    'city_pinyin': 'QingDao',
    'city_short': 'qd',
    'count': '63'
  },
  {
    'id': '21',
    'city_name': '苏州',
    'city_pre': 'S',
    'city_pinyin': 'Suzhou',
    'city_short': 'sz',
    'count': '76'
  },
  {
    'id': '22',
    'city_name': '温州',
    'city_pre': 'W',
    'city_pinyin': 'Wenzhou',
    'city_short': 'wz',
    'count': '79'
  },
  {
    'id': '23',
    'city_name': '厦门',
    'city_pre': 'X',
    'city_pinyin': 'Xiamen',
    'city_short': 'xm',
    'count': '48'
  },
  {
    'id': '24',
    'city_name': '惠州',
    'city_pre': 'H',
    'city_pinyin': 'Huizhou',
    'city_short': 'hz',
    'count': '52'
  },
  {
    'id': '25',
    'city_name': '福州',
    'city_pre': 'F',
    'city_pinyin': 'Fuzhou',
    'city_short': 'fz',
    'count': '47'
  },
  {
    'id': '26',
    'city_name': '昆明',
    'city_pre': 'K',
    'city_pinyin': 'Kunming',
    'city_short': 'km',
    'count': '70'
  },
  {
    'id': '27',
    'city_name': '无锡',
    'city_pre': 'W',
    'city_pinyin': 'Wuxi',
    'city_short': 'wx',
    'count': '66'
  },
  {
    'id': '28',
    'city_name': '烟台',
    'city_pre': 'Y',
    'city_pinyin': 'Yantai',
    'city_short': 'yt',
    'count': '36'
  },
  {
    'id': '29',
    'city_name': '南昌',
    'city_pre': 'N',
    'city_pinyin': 'Nanchang',
    'city_short': 'nc',
    'count': '52'
  },
  {
    'id': '30',
    'city_name': '石家庄',
    'city_pre': 'S',
    'city_pinyin': 'Shijiazhuang',
    'city_short': 'sjz',
    'count': '66'
  },
  {
    'id': '31',
    'city_name': '常州',
    'city_pre': 'C',
    'city_pinyin': 'Changzhou',
    'city_short': 'cz',
    'count': '44'
  },
  {
    'id': '32',
    'city_name': '济南',
    'city_pre': 'J',
    'city_pinyin': 'Jinan',
    'city_short': 'jn',
    'count': '45'
  },
  {
    'id': '33',
    'city_name': '兰州',
    'city_pre': 'L',
    'city_pinyin': 'Lanzhou',
    'city_short': 'lz',
    'count': '35'
  },
  {
    'id': '34',
    'city_name': '台州',
    'city_pre': 'T',
    'city_pinyin': 'Taizhou',
    'city_short': 'tz',
    'count': '58'
  },
  {
    'id': '35',
    'city_name': '南宁',
    'city_pre': 'N',
    'city_pinyin': 'Nanning',
    'city_short': 'nn',
    'count': '47'
  },
  {
    'id': '36',
    'city_name': '中山',
    'city_pre': 'Z',
    'city_pinyin': 'Zhongshan',
    'city_short': 'zs',
    'count': '63'
  },
  {
    'id': '37',
    'city_name': '贵阳',
    'city_pre': 'G',
    'city_pinyin': 'Guiyang',
    'city_short': 'gy',
    'count': '36'
  },
  {
    'id': '38',
    'city_name': '太原',
    'city_pre': 'T',
    'city_pinyin': 'Taiyuan',
    'city_short': 'ty',
    'count': '34'
  },
  {
    'id': '39',
    'city_name': '南通',
    'city_pre': 'N',
    'city_pinyin': 'Nantong',
    'city_short': 'nt',
    'count': '61'
  },
  {
    'id': '40',
    'city_name': '丽水',
    'city_pre': 'L',
    'city_pinyin': 'Lishui',
    'city_short': 'ls',
    'count': '30'
  },
  {
    'id': '41',
    'city_name': '芜湖',
    'city_pre': 'W',
    'city_pinyin': 'Wuhu',
    'city_short': 'wh',
    'count': '41'
  },
  {
    'id': '42',
    'city_name': '乌鲁木齐',
    'city_pre': 'W',
    'city_pinyin': 'Wulumuqi',
    'city_short': 'wlmq',
    'count': '38'
  },
  {
    'id': '43',
    'city_name': '盐城',
    'city_pre': 'Y',
    'city_pinyin': 'Yancheng',
    'city_short': 'yc',
    'count': '34'
  },
  {
    'id': '44',
    'city_name': '新乡',
    'city_pre': 'X',
    'city_pinyin': 'Xinxiang',
    'city_short': 'xx',
    'count': '31'
  },
  {
    'id': '45',
    'city_name': '江门',
    'city_pre': 'J',
    'city_pinyin': 'Jiangmen',
    'city_short': 'jm',
    'count': '39'
  },
  {
    'id': '46',
    'city_name': '长春',
    'city_pre': 'C',
    'city_pinyin': 'Changchun',
    'city_short': 'cc',
    'count': '54'
  },
  {
    'id': '47',
    'city_name': '洛阳',
    'city_pre': 'L',
    'city_pinyin': 'Luoyang',
    'city_short': 'ly',
    'count': '28'
  },
  {
    'id': '48',
    'city_name': '赣州',
    'city_pre': 'G',
    'city_pinyin': 'Ganzhou',
    'city_short': 'gz',
    'count': '44'
  },
  {
    'id': '49',
    'city_name': '淄博',
    'city_pre': 'Z',
    'city_pinyin': 'Zibo',
    'city_short': 'zb',
    'count': '24'
  },
  {
    'id': '50',
    'city_name': '银川',
    'city_pre': 'Y',
    'city_pinyin': 'Yinchuan',
    'city_short': 'yc',
    'count': '28'
  },
  {
    'id': '51',
    'city_name': '淮安',
    'city_pre': 'H',
    'city_pinyin': 'Huaian',
    'city_short': 'ha',
    'count': '33'
  },
  {
    'id': '52',
    'city_name': '哈尔滨',
    'city_pre': 'H',
    'city_pinyin': 'Harbin',
    'city_short': 'heb',
    'count': '51'
  },
  {
    'id': '53',
    'city_name': '衢州',
    'city_pre': 'Q',
    'city_pinyin': 'Quzhou',
    'city_short': 'qz',
    'count': '23'
  },
  {
    'id': '54',
    'city_name': '威海',
    'city_pre': 'W',
    'city_pinyin': 'Weihai',
    'city_short': 'wh',
    'count': '23'
  },
  {
    'id': '55',
    'city_name': '泉州',
    'city_pre': 'Q',
    'city_pinyin': 'Quanzhou',
    'city_short': 'qz',
    'count': '40'
  },
  {
    'id': '56',
    'city_name': '唐山',
    'city_pre': 'T',
    'city_pinyin': 'Tangshan',
    'city_short': 'ts',
    'count': '31'
  },
  {
    'id': '57',
    'city_name': '湖州',
    'city_pre': 'H',
    'city_pinyin': 'Huzhou',
    'city_short': 'hz',
    'count': '36'
  },
  {
    'id': '58',
    'city_name': '徐州',
    'city_pre': 'X',
    'city_pinyin': 'Xuzhou',
    'city_short': 'xz',
    'count': '43'
  },
  {
    'id': '59',
    'city_name': '大庆',
    'city_pre': 'D',
    'city_pinyin': 'Daqing',
    'city_short': 'dq',
    'count': '31'
  },
  {
    'id': '60',
    'city_name': '临沂',
    'city_pre': 'L',
    'city_pinyin': 'Linyi',
    'city_short': 'ly',
    'count': '41'
  },
  {
    'id': '61',
    'city_name': '株洲',
    'city_pre': 'Z',
    'city_pinyin': 'Zhuzhou',
    'city_short': 'zz',
    'count': '22'
  },
  {
    'id': '62',
    'city_name': '上饶',
    'city_pre': 'S',
    'city_pinyin': 'Shangrao',
    'city_short': 'sr',
    'count': '42'
  },
  {
    'id': '63',
    'city_name': '常德',
    'city_pre': 'C',
    'city_pinyin': 'Changde',
    'city_short': 'cd',
    'count': '40'
  },
  {
    'id': '64',
    'city_name': '榆林',
    'city_pre': 'Y',
    'city_pinyin': 'Yulin',
    'city_short': 'yl',
    'count': '25'
  },
  {
    'id': '65',
    'city_name': '潍坊',
    'city_pre': 'W',
    'city_pinyin': 'Weifang',
    'city_short': 'wf',
    'count': '25'
  },
  {
    'id': '66',
    'city_name': '邯郸',
    'city_pre': 'H',
    'city_pinyin': 'Handan',
    'city_short': 'hd',
    'count': '30'
  },
  {
    'id': '67',
    'city_name': '岳阳',
    'city_pre': 'Y',
    'city_pinyin': 'Yueyang',
    'city_short': 'yy',
    'count': '27'
  },
  {
    'id': '68',
    'city_name': '衡阳',
    'city_pre': 'H',
    'city_pinyin': 'Hengyang',
    'city_short': 'hy',
    'count': '28'
  },
  {
    'id': '69',
    'city_name': '珠海',
    'city_pre': 'Z',
    'city_pinyin': 'Zhuhai',
    'city_short': 'zh',
    'count': '30'
  },
  {
    'id': '70',
    'city_name': '东营',
    'city_pre': 'D',
    'city_pinyin': 'Dongying',
    'city_short': 'dy',
    'count': '17'
  },
  {
    'id': '71',
    'city_name': '郴州',
    'city_pre': 'C',
    'city_pinyin': 'Chenzhou',
    'city_short': 'cz',
    'count': '34'
  },
  {
    'id': '72',
    'city_name': '绍兴',
    'city_pre': 'S',
    'city_pinyin': 'Shaoxing',
    'city_short': 'sx',
    'count': '27'
  },
  {
    'id': '73',
    'city_name': '南充',
    'city_pre': 'N',
    'city_pinyin': 'Nanchong',
    'city_short': 'nc',
    'count': '30'
  },
  {
    'id': '74',
    'city_name': '扬州',
    'city_pre': 'Y',
    'city_pinyin': 'Yangzhou',
    'city_short': 'yz',
    'count': '31'
  },
  {
    'id': '75',
    'city_name': '马鞍山',
    'city_pre': 'M',
    'city_pinyin': 'Maanshan',
    'city_short': 'mas',
    'count': '26'
  },
  {
    'id': '76',
    'city_name': '宜春',
    'city_pre': 'Y',
    'city_pinyin': 'Yichun',
    'city_short': 'yc',
    'count': '26'
  },
  {
    'id': '77',
    'city_name': '湛江',
    'city_pre': 'Z',
    'city_pinyin': 'Zhanjiang',
    'city_short': 'zj',
    'count': '24'
  },
  {
    'id': '78',
    'city_name': '十堰',
    'city_pre': 'S',
    'city_pinyin': 'Shiyan',
    'city_short': 'sy',
    'count': '20'
  },
  {
    'id': '79',
    'city_name': '海口',
    'city_pre': 'H',
    'city_pinyin': 'Haikou',
    'city_short': 'hk',
    'count': '31'
  },
  {
    'id': '80',
    'city_name': '运城',
    'city_pre': 'Y',
    'city_pinyin': 'Yuncheng',
    'city_short': 'yc',
    'count': '28'
  },
  {
    'id': '81',
    'city_name': '菏泽',
    'city_pre': 'H',
    'city_pinyin': 'Heze',
    'city_short': 'hz',
    'count': '22'
  },
  {
    'id': '82',
    'city_name': '九江',
    'city_pre': 'J',
    'city_pinyin': 'Jiujiang',
    'city_short': 'jj',
    'count': '39'
  },
  {
    'id': '83',
    'city_name': '南阳',
    'city_pre': 'N',
    'city_pinyin': 'Nanyang',
    'city_short': 'ny',
    'count': '35'
  },
  {
    'id': '84',
    'city_name': '昆山',
    'city_pre': 'K',
    'city_pinyin': 'Kunshan',
    'city_short': 'ks',
    'count': '20'
  },
  {
    'id': '85',
    'city_name': '桂林',
    'city_pre': 'G',
    'city_pinyin': 'Guilin',
    'city_short': 'gl',
    'count': '34'
  },
  {
    'id': '86',
    'city_name': '金华',
    'city_pre': 'J',
    'city_pinyin': 'Jinhua',
    'city_short': 'jh',
    'count': '31'
  },
  {
    'id': '87',
    'city_name': '湘潭',
    'city_pre': 'X',
    'city_pinyin': 'Xiangtan',
    'city_short': 'xt',
    'count': '21'
  },
  {
    'id': '88',
    'city_name': '济宁',
    'city_pre': 'J',
    'city_pinyin': 'Jining',
    'city_short': 'jn',
    'count': '22'
  },
  {
    'id': '89',
    'city_name': '西宁',
    'city_pre': 'X',
    'city_pinyin': 'Xining',
    'city_short': 'xn',
    'count': '19'
  },
  {
    'id': '90',
    'city_name': '遵义',
    'city_pre': 'Z',
    'city_pinyin': 'Zunyi',
    'city_short': 'zy',
    'count': '29'
  },
  {
    'id': '91',
    'city_name': '红河',
    'city_pre': 'H',
    'city_pinyin': 'Honghe',
    'city_short': 'hh',
    'count': '22'
  },
  {
    'id': '92',
    'city_name': '张家口',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangjiakou',
    'city_short': 'zjk',
    'count': '24'
  },
  {
    'id': '93',
    'city_name': '呼和浩特',
    'city_pre': 'H',
    'city_pinyin': 'Hohhot',
    'city_short': 'hhht',
    'count': '32'
  },
  {
    'id': '94',
    'city_name': '娄底',
    'city_pre': 'L',
    'city_pinyin': 'Loudi',
    'city_short': 'ld',
    'count': '14'
  },
  {
    'id': '95',
    'city_name': '滁州',
    'city_pre': 'C',
    'city_pinyin': 'Chuzhou',
    'city_short': 'cz',
    'count': '25'
  },
  {
    'id': '96',
    'city_name': '安庆',
    'city_pre': 'A',
    'city_pinyin': 'Anqing',
    'city_short': 'aq',
    'count': '22'
  },
  {
    'id': '97',
    'city_name': '肇庆',
    'city_pre': 'Z',
    'city_pinyin': 'Zhaoqing',
    'city_short': 'zq',
    'count': '21'
  },
  {
    'id': '98',
    'city_name': '宿迁',
    'city_pre': 'S',
    'city_pinyin': 'Suqian',
    'city_short': 'sq',
    'count': '25'
  },
  {
    'id': '99',
    'city_name': '汕头',
    'city_pre': 'S',
    'city_pinyin': 'Shantou',
    'city_short': 'st',
    'count': '27'
  },
  {
    'id': '100',
    'city_name': '绵阳',
    'city_pre': 'M',
    'city_pinyin': 'Mianyang',
    'city_short': 'my',
    'count': '24'
  },
  {
    'id': '101',
    'city_name': '信阳',
    'city_pre': 'X',
    'city_pinyin': 'Xinyang',
    'city_short': 'xy',
    'count': '20'
  },
  {
    'id': '102',
    'city_name': '新余',
    'city_pre': 'X',
    'city_pinyin': 'Xinyu',
    'city_short': 'xy',
    'count': '12'
  },
  {
    'id': '103',
    'city_name': '嘉兴',
    'city_pre': 'J',
    'city_pinyin': 'Jiaxing',
    'city_short': 'jx',
    'count': '32'
  },
  {
    'id': '104',
    'city_name': '怀化',
    'city_pre': 'H',
    'city_pinyin': 'Huaihua',
    'city_short': 'hh',
    'count': '24'
  },
  {
    'id': '105',
    'city_name': '保定',
    'city_pre': 'B',
    'city_pinyin': 'Baoding',
    'city_short': 'bd',
    'count': '30'
  },
  {
    'id': '106',
    'city_name': '黄石',
    'city_pre': 'H',
    'city_pinyin': 'Huangshi',
    'city_short': 'hs',
    'count': '13'
  },
  {
    'id': '107',
    'city_name': '黄山',
    'city_pre': 'H',
    'city_pinyin': 'Huangshan',
    'city_short': 'hs',
    'count': '16'
  },
  {
    'id': '108',
    'city_name': '平顶山',
    'city_pre': 'P',
    'city_pinyin': 'Pingdingshan',
    'city_short': 'pds',
    'count': '24'
  },
  {
    'id': '109',
    'city_name': '焦作',
    'city_pre': 'J',
    'city_pinyin': 'Jiaozuo',
    'city_short': 'jz',
    'count': '21'
  },
  {
    'id': '110',
    'city_name': '镇江',
    'city_pre': 'Z',
    'city_pinyin': 'Zhenjiang',
    'city_short': 'zj',
    'count': '19'
  },
  {
    'id': '111',
    'city_name': '日照',
    'city_pre': 'R',
    'city_pinyin': 'Rizhao',
    'city_short': 'rz',
    'count': '16'
  },
  {
    'id': '112',
    'city_name': '安阳',
    'city_pre': 'A',
    'city_pinyin': 'Anyang',
    'city_short': 'ay',
    'count': '14'
  },
  {
    'id': '113',
    'city_name': '龙岩',
    'city_pre': 'L',
    'city_pinyin': 'Longyan',
    'city_short': 'ly',
    'count': '15'
  },
  {
    'id': '114',
    'city_name': '六安',
    'city_pre': 'L',
    'city_pinyin': 'luan',
    'city_short': 'la',
    'count': '24'
  },
  {
    'id': '115',
    'city_name': '吴江',
    'city_pre': 'W',
    'city_pinyin': 'Wujiang',
    'city_short': 'wj',
    'count': '8'
  },
  {
    'id': '116',
    'city_name': '吉安',
    'city_pre': 'J',
    'city_pinyin': 'Jian',
    'city_short': 'ja',
    'count': '25'
  },
  {
    'id': '117',
    'city_name': '舟山',
    'city_pre': 'Z',
    'city_pinyin': 'Zhoushan',
    'city_short': 'zs',
    'count': '15'
  },
  {
    'id': '118',
    'city_name': '滨州',
    'city_pre': 'B',
    'city_pinyin': 'Binzhou',
    'city_short': 'bz',
    'count': '14'
  },
  {
    'id': '119',
    'city_name': '柳州',
    'city_pre': 'L',
    'city_pinyin': 'Liuzhou',
    'city_short': 'lz',
    'count': '20'
  },
  {
    'id': '120',
    'city_name': '连云港',
    'city_pre': 'L',
    'city_pinyin': 'Lianyungang',
    'city_short': 'lyg',
    'count': '20'
  },
  {
    'id': '121',
    'city_name': '三明',
    'city_pre': 'S',
    'city_pinyin': 'Sanming',
    'city_short': 'sm',
    'count': '18'
  },
  {
    'id': '122',
    'city_name': '包头',
    'city_pre': 'B',
    'city_pinyin': 'Baotou',
    'city_short': 'bt',
    'count': '20'
  },
  {
    'id': '123',
    'city_name': '盘锦',
    'city_pre': 'P',
    'city_pinyin': 'Panjin',
    'city_short': 'pj',
    'count': '11'
  },
  {
    'id': '124',
    'city_name': '江阴',
    'city_pre': 'J',
    'city_pinyin': 'Jiangyin',
    'city_short': 'jy',
    'count': '18'
  },
  {
    'id': '125',
    'city_name': '余姚',
    'city_pre': 'Y',
    'city_pinyin': 'Yuyao',
    'city_short': 'yy',
    'count': '10'
  },
  {
    'id': '126',
    'city_name': '枣庄',
    'city_pre': 'Z',
    'city_pinyin': 'Zaozhuang',
    'city_short': 'zz',
    'count': '17'
  },
  {
    'id': '127',
    'city_name': '抚州',
    'city_pre': 'F',
    'city_pinyin': 'Fuzhou',
    'city_short': 'fz',
    'count': '25'
  },
  {
    'id': '128',
    'city_name': '呼伦贝尔',
    'city_pre': 'H',
    'city_pinyin': 'Hulun Buir',
    'city_short': 'hlbe',
    'count': '14'
  },
  {
    'id': '129',
    'city_name': '开封',
    'city_pre': 'K',
    'city_pinyin': 'Kaifeng',
    'city_short': 'kf',
    'count': '17'
  },
  {
    'id': '130',
    'city_name': '乐山',
    'city_pre': 'L',
    'city_pinyin': 'Leshan',
    'city_short': 'ls',
    'count': '19'
  },
  {
    'id': '131',
    'city_name': '泰安',
    'city_pre': 'T',
    'city_pinyin': 'Taian',
    'city_short': 'ta',
    'count': '17'
  },
  {
    'id': '132',
    'city_name': '泰州',
    'city_pre': 'T',
    'city_pinyin': 'Taizhou',
    'city_short': 'tz',
    'count': '22'
  },
  {
    'id': '133',
    'city_name': '遂宁',
    'city_pre': 'S',
    'city_pinyin': 'Suining',
    'city_short': 'sn',
    'count': '15'
  },
  {
    'id': '134',
    'city_name': '漳州',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangzhou',
    'city_short': 'zz',
    'count': '22'
  },
  {
    'id': '135',
    'city_name': '抚顺',
    'city_pre': 'F',
    'city_pinyin': 'Fushun',
    'city_short': 'fs',
    'count': '11'
  },
  {
    'id': '136',
    'city_name': '韶关',
    'city_pre': 'S',
    'city_pinyin': 'Shaoguan',
    'city_short': 'sg',
    'count': '21'
  },
  {
    'id': '137',
    'city_name': '鄂尔多斯',
    'city_pre': 'E',
    'city_pinyin': 'Eerduosi',
    'city_short': 'eeds',
    'count': '20'
  },
  {
    'id': '138',
    'city_name': '黄冈',
    'city_pre': 'H',
    'city_pinyin': 'Huanggang',
    'city_short': 'hg',
    'count': '23'
  },
  {
    'id': '139',
    'city_name': '宜兴',
    'city_pre': 'Y',
    'city_pinyin': 'Yixing',
    'city_short': 'yx',
    'count': '10'
  },
  {
    'id': '140',
    'city_name': '德州',
    'city_pre': 'D',
    'city_pinyin': 'Dezhou',
    'city_short': 'dz',
    'count': '18'
  },
  {
    'id': '141',
    'city_name': '聊城',
    'city_pre': 'L',
    'city_pinyin': 'Liaocheng',
    'city_short': 'lc',
    'count': '16'
  },
  {
    'id': '142',
    'city_name': '晋江',
    'city_pre': 'J',
    'city_pinyin': 'Jinjiang',
    'city_short': 'jj',
    'count': '11'
  },
  {
    'id': '143',
    'city_name': '鞍山',
    'city_pre': 'A',
    'city_pinyin': 'Anshan',
    'city_short': 'as',
    'count': '16'
  },
  {
    'id': '144',
    'city_name': '梅州',
    'city_pre': 'M',
    'city_pinyin': 'Meizhou',
    'city_short': 'mz',
    'count': '18'
  },
  {
    'id': '145',
    'city_name': '义乌',
    'city_pre': 'Y',
    'city_pinyin': 'Yiwu',
    'city_short': 'yw',
    'count': '22'
  },
  {
    'id': '146',
    'city_name': '眉山',
    'city_pre': 'M',
    'city_pinyin': 'Meishan',
    'city_short': 'ms',
    'count': '16'
  },
  {
    'id': '147',
    'city_name': '益阳',
    'city_pre': 'Y',
    'city_pinyin': 'Yiyang',
    'city_short': 'yy',
    'count': '24'
  },
  {
    'id': '148',
    'city_name': '吕梁',
    'city_pre': 'L',
    'city_pinyin': 'Lvliang',
    'city_short': 'll',
    'count': '17'
  },
  {
    'id': '149',
    'city_name': '浏阳',
    'city_pre': 'L',
    'city_pinyin': 'Liuyang',
    'city_short': 'ly',
    'count': '15'
  },
  {
    'id': '150',
    'city_name': '即墨',
    'city_pre': 'J',
    'city_pinyin': 'Jimo',
    'city_short': 'jm',
    'count': '6'
  },
  {
    'id': '151',
    'city_name': '荆州',
    'city_pre': 'J',
    'city_pinyin': 'Jingzhou',
    'city_short': 'jz',
    'count': '25'
  },
  {
    'id': '152',
    'city_name': '慈溪',
    'city_pre': 'C',
    'city_pinyin': 'Cixi',
    'city_short': 'cx',
    'count': '10'
  },
  {
    'id': '153',
    'city_name': '潮州',
    'city_pre': 'C',
    'city_pinyin': 'Chaozhou',
    'city_short': 'cz',
    'count': '9'
  },
  {
    'id': '154',
    'city_name': '咸宁',
    'city_pre': 'X',
    'city_pinyin': 'Xianning',
    'city_short': 'xn',
    'count': '16'
  },
  {
    'id': '155',
    'city_name': '巴彦淖尔',
    'city_pre': 'B',
    'city_pinyin': 'Bayannaoer',
    'city_short': 'byze',
    'count': '12'
  },
  {
    'id': '156',
    'city_name': '蚌埠',
    'city_pre': 'B',
    'city_pinyin': 'Bengbu',
    'city_short': 'bb',
    'count': '22'
  },
  {
    'id': '157',
    'city_name': '阜阳',
    'city_pre': 'F',
    'city_pinyin': 'Fuyang',
    'city_short': 'fy',
    'count': '26'
  },
  {
    'id': '158',
    'city_name': '恩施',
    'city_pre': 'E',
    'city_pinyin': 'Enshi',
    'city_short': 'es',
    'count': '15'
  },
  {
    'id': '159',
    'city_name': '常熟',
    'city_pre': 'C',
    'city_pinyin': 'Changshu',
    'city_short': 'cs',
    'count': '16'
  },
  {
    'id': '160',
    'city_name': '晋城',
    'city_pre': 'J',
    'city_pinyin': 'Jincheng',
    'city_short': 'jc',
    'count': '11'
  },
  {
    'id': '161',
    'city_name': '寿光',
    'city_pre': 'S',
    'city_pinyin': 'Shouguang',
    'city_short': 'sg',
    'count': '7'
  },
  {
    'id': '162',
    'city_name': '海宁',
    'city_pre': 'H',
    'city_pinyin': 'Haining',
    'city_short': 'hn',
    'count': '9'
  },
  {
    'id': '163',
    'city_name': '靖江',
    'city_pre': 'J',
    'city_pinyin': 'Jingjiang',
    'city_short': 'jj',
    'count': '12'
  },
  {
    'id': '164',
    'city_name': '营口',
    'city_pre': 'Y',
    'city_pinyin': 'Yingkou',
    'city_short': 'yk',
    'count': '15'
  },
  {
    'id': '165',
    'city_name': '邵阳',
    'city_pre': 'S',
    'city_pinyin': 'Shaoyang',
    'city_short': 'sy',
    'count': '20'
  },
  {
    'id': '166',
    'city_name': '荆门',
    'city_pre': 'J',
    'city_pinyin': 'Jingmen',
    'city_short': 'jm',
    'count': '18'
  },
  {
    'id': '167',
    'city_name': '大同',
    'city_pre': 'D',
    'city_pinyin': 'Datong',
    'city_short': 'dt',
    'count': '21'
  },
  {
    'id': '168',
    'city_name': '张家港',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangjiagang',
    'city_short': 'zjg',
    'count': '20'
  },
  {
    'id': '169',
    'city_name': '六盘水',
    'city_pre': 'L',
    'city_pinyin': 'Liupanshui',
    'city_short': 'lps',
    'count': '10'
  },
  {
    'id': '170',
    'city_name': '宝鸡',
    'city_pre': 'B',
    'city_pinyin': 'Baoji',
    'city_short': 'bj',
    'count': '28'
  },
  {
    'id': '171',
    'city_name': '永州',
    'city_pre': 'Y',
    'city_pinyin': 'Yongzhou',
    'city_short': 'yz',
    'count': '19'
  },
  {
    'id': '172',
    'city_name': '亳州',
    'city_pre': 'B',
    'city_pinyin': 'Bozhou',
    'city_short': 'bz',
    'count': '13'
  },
  {
    'id': '173',
    'city_name': '泸州',
    'city_pre': 'L',
    'city_pinyin': 'Luzhou',
    'city_short': 'lz',
    'count': '16'
  },
  {
    'id': '174',
    'city_name': '茂名',
    'city_pre': 'M',
    'city_pinyin': 'Maoming',
    'city_short': 'mm',
    'count': '16'
  },
  {
    'id': '175',
    'city_name': '沧州',
    'city_pre': 'C',
    'city_pinyin': 'Cangzhou',
    'city_short': 'cz',
    'count': '19'
  },
  {
    'id': '176',
    'city_name': '咸阳',
    'city_pre': 'X',
    'city_pinyin': 'Xianyang',
    'city_short': 'xy',
    'count': '23'
  },
  {
    'id': '177',
    'city_name': '桐乡',
    'city_pre': 'T',
    'city_pinyin': 'Tongxiang',
    'city_short': 'tx',
    'count': '9'
  },
  {
    'id': '178',
    'city_name': '葫芦岛',
    'city_pre': 'H',
    'city_pinyin': 'Huludao',
    'city_short': 'hld',
    'count': '12'
  },
  {
    'id': '179',
    'city_name': '周口',
    'city_pre': 'Z',
    'city_pinyin': 'Zhoukou',
    'city_short': 'zk',
    'count': '23'
  },
  {
    'id': '180',
    'city_name': '濮阳',
    'city_pre': 'P',
    'city_pinyin': 'Puyang',
    'city_short': 'py',
    'count': '19'
  },
  {
    'id': '181',
    'city_name': '莆田',
    'city_pre': 'P',
    'city_pinyin': 'Putian',
    'city_short': 'pt',
    'count': '16'
  },
  {
    'id': '182',
    'city_name': '清远',
    'city_pre': 'Q',
    'city_pinyin': 'Qingyuan',
    'city_short': 'qy',
    'count': '15'
  },
  {
    'id': '183',
    'city_name': '萍乡',
    'city_pre': 'P',
    'city_pinyin': 'Pingxiang',
    'city_short': 'px',
    'count': '12'
  },
  {
    'id': '184',
    'city_name': '秦皇岛',
    'city_pre': 'Q',
    'city_pinyin': 'Qinhuangdao',
    'city_short': 'qhd',
    'count': '13'
  },
  {
    'id': '185',
    'city_name': '宜昌',
    'city_pre': 'Y',
    'city_pinyin': 'Yichang',
    'city_short': 'yc',
    'count': '18'
  },
  {
    'id': '186',
    'city_name': '宜宾',
    'city_pre': 'Y',
    'city_pinyin': 'Yibin',
    'city_short': 'yb',
    'count': '24'
  },
  {
    'id': '187',
    'city_name': '瑞安',
    'city_pre': 'R',
    'city_pinyin': 'Ruian',
    'city_short': 'ra',
    'count': '7'
  },
  {
    'id': '188',
    'city_name': '揭阳',
    'city_pre': 'J',
    'city_pinyin': 'Jieyang',
    'city_short': 'jy',
    'count': '20'
  },
  {
    'id': '189',
    'city_name': '赤峰',
    'city_pre': 'C',
    'city_pinyin': 'Chifeng',
    'city_short': 'cf',
    'count': '19'
  },
  {
    'id': '190',
    'city_name': '诸暨',
    'city_pre': 'Z',
    'city_pinyin': 'Zhuji',
    'city_short': 'zj',
    'count': '12'
  },
  {
    'id': '191',
    'city_name': '商丘',
    'city_pre': 'S',
    'city_pinyin': 'Shangqiu',
    'city_short': 'sq',
    'count': '28'
  },
  {
    'id': '192',
    'city_name': '许昌',
    'city_pre': 'X',
    'city_pinyin': 'Xuchang',
    'city_short': 'xc',
    'count': '10'
  },
  {
    'id': '193',
    'city_name': '河源',
    'city_pre': 'H',
    'city_pinyin': 'Heyuan',
    'city_short': 'hy',
    'count': '21'
  },
  {
    'id': '194',
    'city_name': '内江',
    'city_pre': 'N',
    'city_pinyin': 'Neijiang',
    'city_short': 'nj',
    'count': '13'
  },
  {
    'id': '195',
    'city_name': '北海',
    'city_pre': 'B',
    'city_pinyin': 'Beihai',
    'city_short': 'bh',
    'count': '11'
  },
  {
    'id': '196',
    'city_name': '襄阳',
    'city_pre': 'X',
    'city_pinyin': 'Xiangyang',
    'city_short': 'xy',
    'count': '26'
  },
  {
    'id': '197',
    'city_name': '玉林',
    'city_pre': 'Y',
    'city_pinyin': 'Yulin',
    'city_short': 'yl',
    'count': '17'
  },
  {
    'id': '198',
    'city_name': '宣城',
    'city_pre': 'X',
    'city_pinyin': 'Xuancheng',
    'city_short': 'xc',
    'count': '16'
  },
  {
    'id': '199',
    'city_name': '渭南',
    'city_pre': 'W',
    'city_pinyin': 'Weinan',
    'city_short': 'wn',
    'count': '18'
  },
  {
    'id': '200',
    'city_name': '仙桃',
    'city_pre': 'X',
    'city_pinyin': 'Xiantao',
    'city_short': 'xt',
    'count': '11'
  },
  {
    'id': '201',
    'city_name': '如皋',
    'city_pre': 'R',
    'city_pinyin': 'Rugao',
    'city_short': 'rg',
    'count': '8'
  },
  {
    'id': '202',
    'city_name': '太仓',
    'city_pre': 'T',
    'city_pinyin': 'Taicang',
    'city_short': 'tc',
    'count': '6'
  },
  {
    'id': '203',
    'city_name': '邢台',
    'city_pre': 'G',
    'city_pinyin': 'Xingtai',
    'city_short': 'gt',
    'count': '15'
  },
  {
    'id': '204',
    'city_name': '承德',
    'city_pre': 'C',
    'city_pinyin': 'Chengde',
    'city_short': 'cd',
    'count': '15'
  },
  {
    'id': '205',
    'city_name': '南平',
    'city_pre': 'N',
    'city_pinyin': 'Nanping',
    'city_short': 'np',
    'count': '13'
  },
  {
    'id': '206',
    'city_name': '大理',
    'city_pre': 'D',
    'city_pinyin': 'Dali',
    'city_short': 'dl',
    'count': '30'
  },
  {
    'id': '207',
    'city_name': '阿克苏',
    'city_pre': 'A',
    'city_pinyin': 'Akesu',
    'city_short': 'aks',
    'count': '8'
  },
  {
    'id': '208',
    'city_name': '齐齐哈尔',
    'city_pre': 'Q',
    'city_pinyin': 'Qiqihar',
    'city_short': 'qqhe',
    'count': '13'
  },
  {
    'id': '209',
    'city_name': '阳江',
    'city_pre': 'Y',
    'city_pinyin': 'Yangjiang',
    'city_short': 'yj',
    'count': '18'
  },
  {
    'id': '210',
    'city_name': '泰兴',
    'city_pre': 'T',
    'city_pinyin': 'Taixing',
    'city_short': 'tx',
    'count': '7'
  },
  {
    'id': '211',
    'city_name': '延安',
    'city_pre': 'Y',
    'city_pinyin': 'Yanan',
    'city_short': 'ya',
    'count': '25'
  },
  {
    'id': '212',
    'city_name': '锦州',
    'city_pre': 'J',
    'city_pinyin': 'Jinzhou',
    'city_short': 'jz',
    'count': '16'
  },
  {
    'id': '213',
    'city_name': '自贡',
    'city_pre': 'Z',
    'city_pinyin': 'Zigong',
    'city_short': 'zg',
    'count': '14'
  },
  {
    'id': '214',
    'city_name': '廊坊',
    'city_pre': 'L',
    'city_pinyin': 'Langfang',
    'city_short': 'lf',
    'count': '20'
  },
  {
    'id': '215',
    'city_name': '淮北',
    'city_pre': 'H',
    'city_pinyin': 'Huaibei',
    'city_short': 'hb',
    'count': '8'
  },
  {
    'id': '216',
    'city_name': '莱芜',
    'city_pre': 'L',
    'city_pinyin': 'Laiwu',
    'city_short': 'lw',
    'count': '5'
  },
  {
    'id': '217',
    'city_name': '安顺',
    'city_pre': 'A',
    'city_pinyin': 'Anshun',
    'city_short': 'as',
    'count': '14'
  },
  {
    'id': '218',
    'city_name': '济源',
    'city_pre': 'J',
    'city_pinyin': 'Jiyuan',
    'city_short': 'jy',
    'count': '5'
  },
  {
    'id': '219',
    'city_name': '达州',
    'city_pre': 'D',
    'city_pinyin': 'Dazhou',
    'city_short': 'dz',
    'count': '15'
  },
  {
    'id': '220',
    'city_name': '海门',
    'city_pre': 'H',
    'city_pinyin': 'Haimen',
    'city_short': 'hm',
    'count': '8'
  },
  {
    'id': '221',
    'city_name': '吉林市',
    'city_pre': 'J',
    'city_pinyin': 'Jilin',
    'city_short': 'jls',
    'count': '18'
  },
  {
    'id': '222',
    'city_name': '资阳',
    'city_pre': 'Z',
    'city_pinyin': 'Ziyang',
    'city_short': 'zy',
    'count': '9'
  },
  {
    'id': '223',
    'city_name': '玉溪',
    'city_pre': 'Y',
    'city_pinyin': 'Yuxi',
    'city_short': 'yx',
    'count': '16'
  },
  {
    'id': '224',
    'city_name': '德阳',
    'city_pre': 'D',
    'city_pinyin': 'Deyang',
    'city_short': 'dy',
    'count': '22'
  },
  {
    'id': '225',
    'city_name': '胶州',
    'city_pre': 'J',
    'city_pinyin': 'Jiaozhou',
    'city_short': 'jz',
    'count': '2'
  },
  {
    'id': '226',
    'city_name': '梧州',
    'city_pre': 'W',
    'city_pinyin': 'Wuzhou',
    'city_short': 'wz',
    'count': '11'
  },
  {
    'id': '227',
    'city_name': '东港',
    'city_pre': 'D',
    'city_pinyin': 'Donggang',
    'city_short': 'dg',
    'count': '2'
  },
  {
    'id': '228',
    'city_name': '宁德',
    'city_pre': 'N',
    'city_pinyin': 'Ningde',
    'city_short': 'nd',
    'count': '12'
  },
  {
    'id': '229',
    'city_name': '三亚',
    'city_pre': 'S',
    'city_pinyin': 'Sanya',
    'city_short': 'sy',
    'count': '16'
  },
  {
    'id': '230',
    'city_name': '驻马店',
    'city_pre': 'Z',
    'city_pinyin': 'Zhumadian',
    'city_short': 'zmd',
    'count': '23'
  },
  {
    'id': '231',
    'city_name': '东阳',
    'city_pre': 'D',
    'city_pinyin': 'Dongyang',
    'city_short': 'dy',
    'count': '7'
  },
  {
    'id': '232',
    'city_name': '三河',
    'city_pre': 'S',
    'city_pinyin': 'Sanhe',
    'city_short': 'sh',
    'count': '8'
  },
  {
    'id': '233',
    'city_name': '扬中',
    'city_pre': 'Y',
    'city_pinyin': 'Yangzhong',
    'city_short': 'yz',
    'count': '4'
  },
  {
    'id': '234',
    'city_name': '攀枝花',
    'city_pre': 'P',
    'city_pinyin': 'Panzhihua',
    'city_short': 'pzh',
    'count': '11'
  },
  {
    'id': '235',
    'city_name': '佳木斯',
    'city_pre': 'J',
    'city_pinyin': 'Jiamusi',
    'city_short': 'jms',
    'count': '14'
  },
  {
    'id': '236',
    'city_name': '迁安',
    'city_pre': 'Q',
    'city_pinyin': 'Qianan',
    'city_short': 'qa',
    'count': '3'
  },
  {
    'id': '237',
    'city_name': '钦州',
    'city_pre': 'Q',
    'city_pinyin': 'Qinzhou',
    'city_short': 'qz',
    'count': '9'
  },
  {
    'id': '238',
    'city_name': '延边',
    'city_pre': 'Y',
    'city_pinyin': 'Yanbian',
    'city_short': 'yb',
    'count': '8'
  },
  {
    'id': '239',
    'city_name': '宁国',
    'city_pre': 'N',
    'city_pinyin': 'Ningguo',
    'city_short': 'ng',
    'count': '3'
  },
  {
    'id': '240',
    'city_name': '曲靖',
    'city_pre': 'Q',
    'city_pinyin': 'Qujing',
    'city_short': 'qj',
    'count': '22'
  },
  {
    'id': '241',
    'city_name': '保山',
    'city_pre': 'B',
    'city_pinyin': 'Baoshan',
    'city_short': 'bs',
    'count': '11'
  },
  {
    'id': '242',
    'city_name': '通化',
    'city_pre': 'T',
    'city_pinyin': 'Tonghua',
    'city_short': 'th',
    'count': '12'
  },
  {
    'id': '243',
    'city_name': '通辽',
    'city_pre': 'T',
    'city_pinyin': 'Tongliao',
    'city_short': 'tl',
    'count': '15'
  },
  {
    'id': '244',
    'city_name': '孝感',
    'city_pre': 'X',
    'city_pinyin': 'Xiaogan',
    'city_short': 'xg',
    'count': '19'
  },
  {
    'id': '245',
    'city_name': '防城港',
    'city_pre': 'F',
    'city_pinyin': 'Fangchenggang',
    'city_short': 'fcg',
    'count': '8'
  },
  {
    'id': '246',
    'city_name': '贵港',
    'city_pre': 'G',
    'city_pinyin': 'Guigang',
    'city_short': 'gg',
    'count': '5'
  },
  {
    'id': '247',
    'city_name': '铜仁',
    'city_pre': 'T',
    'city_pinyin': 'Tongren',
    'city_short': 'tr',
    'count': '15'
  },
  {
    'id': '248',
    'city_name': '阜新',
    'city_pre': 'F',
    'city_pinyin': 'Fuxin',
    'city_short': 'fx',
    'count': '9'
  },
  {
    'id': '249',
    'city_name': '福清',
    'city_pre': 'F',
    'city_pinyin': 'Fuqing',
    'city_short': 'fq',
    'count': '8'
  },
  {
    'id': '250',
    'city_name': '文山',
    'city_pre': 'W',
    'city_pinyin': 'Wenshan',
    'city_short': 'ws',
    'count': '13'
  },
  {
    'id': '251',
    'city_name': '高平',
    'city_pre': 'G',
    'city_pinyin': 'Gaoping',
    'city_short': 'gp',
    'count': '3'
  },
  {
    'id': '252',
    'city_name': '温岭',
    'city_pre': 'W',
    'city_pinyin': 'Wenling',
    'city_short': 'wl',
    'count': '13'
  },
  {
    'id': '253',
    'city_name': '安康',
    'city_pre': 'A',
    'city_pinyin': 'Ankang',
    'city_short': 'ak',
    'count': '17'
  },
  {
    'id': '254',
    'city_name': '海盐',
    'city_pre': 'H',
    'city_pinyin': 'Haiyan',
    'city_short': 'hy',
    'count': '4'
  },
  {
    'id': '255',
    'city_name': '长治',
    'city_pre': 'C',
    'city_pinyin': 'Changzhi',
    'city_short': 'cz',
    'count': '23'
  },
  {
    'id': '256',
    'city_name': '鹤壁',
    'city_pre': 'H',
    'city_pinyin': 'Hebi',
    'city_short': 'hb',
    'count': '7'
  },
  {
    'id': '257',
    'city_name': '汉中',
    'city_pre': 'H',
    'city_pinyin': 'Hanzhong',
    'city_short': 'hz',
    'count': '21'
  },
  {
    'id': '258',
    'city_name': '石嘴山',
    'city_pre': 'S',
    'city_pinyin': 'Shizuishan',
    'city_short': 'szs',
    'count': '8'
  },
  {
    'id': '259',
    'city_name': '随州',
    'city_pre': 'S',
    'city_pinyin': 'Suizhou',
    'city_short': 'sz',
    'count': '7'
  },
  {
    'id': '260',
    'city_name': '宿州',
    'city_pre': 'S',
    'city_pinyin': 'Suzhou',
    'city_short': 'sz',
    'count': '16'
  },
  {
    'id': '261',
    'city_name': '绥化',
    'city_pre': 'S',
    'city_pinyin': 'Suihua',
    'city_short': 'sh',
    'count': '13'
  },
  {
    'id': '262',
    'city_name': '海安',
    'city_pre': 'H',
    'city_pinyin': 'Haian',
    'city_short': 'ha',
    'count': '3'
  },
  {
    'id': '263',
    'city_name': '思茅',
    'city_pre': 'S',
    'city_pinyin': 'Simao',
    'city_short': 'sm',
    'count': '7'
  },
  {
    'id': '264',
    'city_name': '龙口',
    'city_pre': 'L',
    'city_pinyin': 'Longkou',
    'city_short': 'lk',
    'count': '3'
  },
  {
    'id': '265',
    'city_name': '临汾',
    'city_pre': 'L',
    'city_pinyin': 'Linfen',
    'city_short': 'lf',
    'count': '29'
  },
  {
    'id': '266',
    'city_name': '丹东',
    'city_pre': 'D',
    'city_pinyin': 'Dandong',
    'city_short': 'dd',
    'count': '8'
  },
  {
    'id': '267',
    'city_name': '耒阳',
    'city_pre': 'L',
    'city_pinyin': 'Leiyang',
    'city_short': 'ly',
    'count': '3'
  },
  {
    'id': '268',
    'city_name': '辽阳',
    'city_pre': 'L',
    'city_pinyin': 'Liaoyang',
    'city_short': 'ly',
    'count': '8'
  },
  {
    'id': '269',
    'city_name': '鹰潭',
    'city_pre': 'Y',
    'city_pinyin': 'Yingtan',
    'city_short': 'yt',
    'count': '6'
  },
  {
    'id': '270',
    'city_name': '临海',
    'city_pre': 'L',
    'city_pinyin': 'Linhai',
    'city_short': 'lh',
    'count': '7'
  },
  {
    'id': '271',
    'city_name': '丹阳',
    'city_pre': 'D',
    'city_pinyin': 'Danyang',
    'city_short': 'dy',
    'count': '8'
  },
  {
    'id': '272',
    'city_name': '景德镇',
    'city_pre': 'J',
    'city_pinyin': 'Jingdezhen',
    'city_short': 'jdz',
    'count': '7'
  },
  {
    'id': '273',
    'city_name': '溧阳',
    'city_pre': 'L',
    'city_pinyin': 'Liyang',
    'city_short': 'ly',
    'count': '5'
  },
  {
    'id': '274',
    'city_name': '陇南',
    'city_pre': 'L',
    'city_pinyin': 'Longnan',
    'city_short': 'ln',
    'count': '10'
  },
  {
    'id': '275',
    'city_name': '仪征',
    'city_pre': 'Y',
    'city_pinyin': 'Yizheng',
    'city_short': 'yz',
    'count': '4'
  },
  {
    'id': '276',
    'city_name': '云浮',
    'city_pre': 'Y',
    'city_pinyin': 'Yunfu',
    'city_short': 'yf',
    'count': '10'
  },
  {
    'id': '277',
    'city_name': '廉江',
    'city_pre': 'L',
    'city_pinyin': 'Lianjiang',
    'city_short': 'lj',
    'count': '4'
  },
  {
    'id': '278',
    'city_name': '辽源',
    'city_pre': 'L',
    'city_pinyin': 'Liaoyuan',
    'city_short': 'ly',
    'count': '9'
  },
  {
    'id': '279',
    'city_name': '涿州',
    'city_pre': 'Z',
    'city_pinyin': 'Zhuozhou',
    'city_short': 'zz',
    'count': '4'
  },
  {
    'id': '280',
    'city_name': '固原',
    'city_pre': 'G',
    'city_pinyin': 'Guyuan',
    'city_short': 'gy',
    'count': '2'
  },
  {
    'id': '281',
    'city_name': '儋州市',
    'city_pre': 'D',
    'city_pinyin': 'danzhou',
    'city_short': 'dzs',
    'count': '3'
  },
  {
    'id': '282',
    'city_name': '永康',
    'city_pre': 'Y',
    'city_pinyin': 'Yongkang',
    'city_short': 'yk',
    'count': '6'
  },
  {
    'id': '283',
    'city_name': '汕尾',
    'city_pre': 'S',
    'city_pinyin': 'Shanwei',
    'city_short': 'sw',
    'count': '12'
  },
  {
    'id': '284',
    'city_name': '鄂州',
    'city_pre': 'E',
    'city_pinyin': 'Ezhou',
    'city_short': 'ez',
    'count': '6'
  },
  {
    'id': '285',
    'city_name': '兴化',
    'city_pre': 'X',
    'city_pinyin': 'Xinghua',
    'city_short': 'xh',
    'count': '4'
  },
  {
    'id': '286',
    'city_name': '松滋',
    'city_pre': 'S',
    'city_pinyin': 'Songzi',
    'city_short': 'sz',
    'count': '2'
  },
  {
    'id': '287',
    'city_name': '峨眉山',
    'city_pre': 'E',
    'city_pinyin': 'Emeishan',
    'city_short': 'ems',
    'count': '3'
  },
  {
    'id': '288',
    'city_name': '朝阳',
    'city_pre': 'C',
    'city_pinyin': 'Chaoyang',
    'city_short': 'cy',
    'count': '9'
  },
  {
    'id': '289',
    'city_name': '喀什',
    'city_pre': 'K',
    'city_pinyin': 'Kashgar',
    'city_short': 'ks',
    'count': '7'
  },
  {
    'id': '290',
    'city_name': '巢湖',
    'city_pre': 'C',
    'city_pinyin': 'Chaohu',
    'city_short': 'ch',
    'count': '3'
  },
  {
    'id': '291',
    'city_name': '永安',
    'city_pre': 'Y',
    'city_pinyin': 'Yongan',
    'city_short': 'ya',
    'count': '2'
  },
  {
    'id': '292',
    'city_name': '四平',
    'city_pre': 'S',
    'city_pinyin': 'Siping',
    'city_short': 'sp',
    'count': '13'
  },
  {
    'id': '293',
    'city_name': '松原',
    'city_pre': 'S',
    'city_pinyin': 'Songyuan',
    'city_short': 'sy',
    'count': '10'
  },
  {
    'id': '294',
    'city_name': '西双版纳',
    'city_pre': 'X',
    'city_pinyin': 'Xishuangbanna',
    'city_short': 'xsbn',
    'count': '6'
  },
  {
    'id': '295',
    'city_name': '莱阳',
    'city_pre': 'L',
    'city_pinyin': 'Laiyang',
    'city_short': 'ly',
    'count': '4'
  },
  {
    'id': '296',
    'city_name': '长葛',
    'city_pre': 'C',
    'city_pinyin': 'Changge',
    'city_short': 'cg',
    'count': '2'
  },
  {
    'id': '297',
    'city_name': '盖州',
    'city_pre': 'G',
    'city_pinyin': 'Gaizhou',
    'city_short': 'gz',
    'count': '3'
  },
  {
    'id': '298',
    'city_name': '湘西',
    'city_pre': 'X',
    'city_pinyin': 'Xiangxi',
    'city_short': 'xx',
    'count': '13'
  },
  {
    'id': '299',
    'city_name': '奉化',
    'city_pre': 'F',
    'city_pinyin': 'Fenghua',
    'city_short': 'fh',
    'count': '3'
  },
  {
    'id': '300',
    'city_name': '利川',
    'city_pre': 'L',
    'city_pinyin': 'Lichuan',
    'city_short': 'lc',
    'count': '3'
  },
  {
    'id': '301',
    'city_name': '邹城',
    'city_pre': 'Z',
    'city_pinyin': 'Zoucheng',
    'city_short': 'zc',
    'count': '2'
  },
  {
    'id': '302',
    'city_name': '高邮',
    'city_pre': 'G',
    'city_pinyin': 'Gaoyou',
    'city_short': 'gy',
    'count': '4'
  },
  {
    'id': '303',
    'city_name': '本溪',
    'city_pre': 'B',
    'city_pinyin': 'Benxi',
    'city_short': 'bx',
    'count': '10'
  },
  {
    'id': '304',
    'city_name': '拉萨',
    'city_pre': 'L',
    'city_pinyin': 'Lhasa',
    'city_short': 'ls',
    'count': '5'
  },
  {
    'id': '305',
    'city_name': '北流',
    'city_pre': 'B',
    'city_pinyin': 'Beiliu',
    'city_short': 'bl',
    'count': '3'
  },
  {
    'id': '306',
    'city_name': '毕节',
    'city_pre': 'B',
    'city_pinyin': 'Bijie',
    'city_short': 'bj',
    'count': '13'
  },
  {
    'id': '307',
    'city_name': '富阳',
    'city_pre': 'F',
    'city_pinyin': 'Fuyang',
    'city_short': 'fy',
    'count': '4'
  },
  {
    'id': '308',
    'city_name': '五家渠',
    'city_pre': 'W',
    'city_pinyin': 'Wujiaqu',
    'city_short': 'wgq',
    'count': '4'
  },
  {
    'id': '309',
    'city_name': '铜陵',
    'city_pre': 'T',
    'city_pinyin': 'Tongling',
    'city_short': 'tl',
    'count': '8'
  },
  {
    'id': '310',
    'city_name': '广元',
    'city_pre': 'G',
    'city_pinyin': 'Guangyuan',
    'city_short': 'gy',
    'count': '14'
  },
  {
    'id': '311',
    'city_name': '天门',
    'city_pre': 'T',
    'city_pinyin': 'Tianmen',
    'city_short': 'tm',
    'count': '4'
  },
  {
    'id': '312',
    'city_name': '天水',
    'city_pre': 'T',
    'city_pinyin': 'Tianshui',
    'city_short': 'ts',
    'count': '12'
  },
  {
    'id': '313',
    'city_name': '肥城',
    'city_pre': 'F',
    'city_pinyin': 'Feicheng',
    'city_short': 'fc',
    'count': '2'
  },
  {
    'id': '314',
    'city_name': '西昌',
    'city_pre': 'X',
    'city_pinyin': 'Xichang',
    'city_short': 'xc',
    'count': '3'
  },
  {
    'id': '315',
    'city_name': '滕州',
    'city_pre': 'T',
    'city_pinyin': 'Tengzhou',
    'city_short': 'tz',
    'count': '4'
  },
  {
    'id': '316',
    'city_name': '铜川',
    'city_pre': 'T',
    'city_pinyin': 'Tongchuan',
    'city_short': 'tc',
    'count': '5'
  },
  {
    'id': '317',
    'city_name': '临安',
    'city_pre': 'L',
    'city_pinyin': 'Linan',
    'city_short': 'la',
    'count': '4'
  },
  {
    'id': '318',
    'city_name': '百色',
    'city_pre': 'B',
    'city_pinyin': 'Baise',
    'city_short': 'bs',
    'count': '16'
  },
  {
    'id': '319',
    'city_name': '孝义',
    'city_pre': 'X',
    'city_pinyin': 'Xiaoyi',
    'city_short': 'xy',
    'count': '3'
  },
  {
    'id': '320',
    'city_name': '铁岭',
    'city_pre': 'T',
    'city_pinyin': 'Tieling',
    'city_short': 'tl',
    'count': '8'
  },
  {
    'id': '321',
    'city_name': '禹州',
    'city_pre': 'Y',
    'city_pinyin': 'Yuzhou',
    'city_short': 'yz',
    'count': '2'
  },
  {
    'id': '322',
    'city_name': '淮南',
    'city_pre': 'H',
    'city_pinyin': 'Huainan',
    'city_short': 'hn',
    'count': '12'
  },
  {
    'id': '323',
    'city_name': '青州',
    'city_pre': 'Q',
    'city_pinyin': 'Qingzhou',
    'city_short': 'qz',
    'count': '4'
  },
  {
    'id': '324',
    'city_name': '张掖',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangye',
    'city_short': 'zy',
    'count': '3'
  },
  {
    'id': '325',
    'city_name': '潜江',
    'city_pre': 'Q',
    'city_pinyin': 'Qianjiang',
    'city_short': 'qj',
    'count': '9'
  },
  {
    'id': '326',
    'city_name': '启东',
    'city_pre': 'Q',
    'city_pinyin': 'Qidong',
    'city_short': 'qd',
    'count': '11'
  },
  {
    'id': '327',
    'city_name': '化州',
    'city_pre': 'H',
    'city_pinyin': 'Huazhou',
    'city_short': 'hz',
    'count': '4'
  },
  {
    'id': '328',
    'city_name': '诸城',
    'city_pre': 'Z',
    'city_pinyin': 'Zhucheng',
    'city_short': 'zc',
    'count': '1'
  },
  {
    'id': '329',
    'city_name': '满洲里',
    'city_pre': 'M',
    'city_pinyin': 'Manzhouli',
    'city_short': 'mzl',
    'count': '7'
  },
  {
    'id': '330',
    'city_name': '芒市',
    'city_pre': 'M',
    'city_pinyin': 'Mangshi',
    'city_short': 'ms',
    'count': '3'
  },
  {
    'id': '331',
    'city_name': '阳泉',
    'city_pre': 'Y',
    'city_pinyin': 'Yangquan',
    'city_short': 'yq',
    'count': '10'
  },
  {
    'id': '332',
    'city_name': '侯马',
    'city_pre': 'H',
    'city_pinyin': 'Houma',
    'city_short': 'hm',
    'count': '3'
  },
  {
    'id': '333',
    'city_name': '赤壁',
    'city_pre': 'C',
    'city_pinyin': 'Chibi',
    'city_short': 'cb',
    'count': '3'
  },
  {
    'id': '334',
    'city_name': '金坛',
    'city_pre': 'J',
    'city_pinyin': 'Jintan',
    'city_short': 'jt',
    'count': '3'
  },
  {
    'id': '335',
    'city_name': '从化',
    'city_pre': 'C',
    'city_pinyin': 'Conghua',
    'city_short': 'ch',
    'count': '3'
  },
  {
    'id': '336',
    'city_name': '英德',
    'city_pre': 'Y',
    'city_pinyin': 'Yingde',
    'city_short': 'yd',
    'count': '2'
  },
  {
    'id': '337',
    'city_name': '江油',
    'city_pre': 'J',
    'city_pinyin': 'Jiangyou',
    'city_short': 'jy',
    'count': '4'
  },
  {
    'id': '338',
    'city_name': '嘉峪关',
    'city_pre': 'J',
    'city_pinyin': 'Jiayuguan',
    'city_short': 'jyg',
    'count': '5'
  },
  {
    'id': '339',
    'city_name': '白山',
    'city_pre': 'B',
    'city_pinyin': 'Baishan',
    'city_short': 'bs',
    'count': '9'
  },
  {
    'id': '340',
    'city_name': '伊犁',
    'city_pre': 'Y',
    'city_pinyin': 'Yili',
    'city_short': 'yl',
    'count': '13'
  },
  {
    'id': '341',
    'city_name': '平湖',
    'city_pre': 'P',
    'city_pinyin': 'Pinghu',
    'city_short': 'ph',
    'count': '3'
  },
  {
    'id': '342',
    'city_name': '江都',
    'city_pre': 'J',
    'city_pinyin': 'Jiangdu',
    'city_short': 'jd',
    'count': '4'
  },
  {
    'id': '343',
    'city_name': '兖州',
    'city_pre': 'Y',
    'city_pinyin': 'Yanzhou',
    'city_short': 'yz',
    'count': '2'
  },
  {
    'id': '344',
    'city_name': '南安',
    'city_pre': 'N',
    'city_pinyin': 'Nanan',
    'city_short': 'na',
    'count': '4'
  },
  {
    'id': '345',
    'city_name': '姜堰',
    'city_pre': 'J',
    'city_pinyin': 'Jiangyan',
    'city_short': 'jy',
    'count': '2'
  },
  {
    'id': '346',
    'city_name': '牡丹江',
    'city_pre': 'M',
    'city_pinyin': 'Mudanjiang',
    'city_short': 'mdj',
    'count': '13'
  },
  {
    'id': '347',
    'city_name': '东台',
    'city_pre': 'D',
    'city_pinyin': 'Dongtai',
    'city_short': 'dt',
    'count': '2'
  },
  {
    'id': '348',
    'city_name': '三门峡',
    'city_pre': 'S',
    'city_pinyin': 'Sanmenxia',
    'city_short': 'smx',
    'count': '9'
  },
  {
    'id': '349',
    'city_name': '都江堰',
    'city_pre': 'D',
    'city_pinyin': 'Dujiangyan',
    'city_short': 'djy',
    'count': '2'
  },
  {
    'id': '350',
    'city_name': '鹤岗',
    'city_pre': 'H',
    'city_pinyin': 'Hegang',
    'city_short': 'hg',
    'count': '4'
  },
  {
    'id': '351',
    'city_name': '凯里',
    'city_pre': 'K',
    'city_pinyin': 'Kaili',
    'city_short': 'kl',
    'count': '5'
  },
  {
    'id': '352',
    'city_name': '沙河',
    'city_pre': 'S',
    'city_pinyin': 'Shahe',
    'city_short': 'sh',
    'count': '3'
  },
  {
    'id': '353',
    'city_name': '衡水',
    'city_pre': 'H',
    'city_pinyin': 'Hengshui',
    'city_short': 'hs',
    'count': '13'
  },
  {
    'id': '354',
    'city_name': '宣威',
    'city_pre': 'X',
    'city_pinyin': 'Xuanwei',
    'city_short': 'xw',
    'count': '4'
  },
  {
    'id': '355',
    'city_name': '河津',
    'city_pre': 'H',
    'city_pinyin': 'Hejin',
    'city_short': 'hj',
    'count': '2'
  },
  {
    'id': '356',
    'city_name': '商洛',
    'city_pre': 'S',
    'city_pinyin': 'Shangluo',
    'city_short': 'sl',
    'count': '13'
  },
  {
    'id': '357',
    'city_name': '鹤山',
    'city_pre': 'H',
    'city_pinyin': 'Heshan',
    'city_short': 'hs',
    'count': '3'
  },
  {
    'id': '358',
    'city_name': '上虞',
    'city_pre': 'S',
    'city_pinyin': 'Shangyu',
    'city_short': 'sy',
    'count': '4'
  },
  {
    'id': '359',
    'city_name': '雅安',
    'city_pre': 'Y',
    'city_pinyin': 'Yaan',
    'city_short': 'ya',
    'count': '10'
  },
  {
    'id': '360',
    'city_name': '开原',
    'city_pre': 'K',
    'city_pinyin': 'Kaiyuan',
    'city_short': 'ky',
    'count': '2'
  },
  {
    'id': '361',
    'city_name': '张家界',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangjiajie',
    'city_short': 'zgj',
    'count': '7'
  },
  {
    'id': '362',
    'city_name': '句容',
    'city_pre': 'J',
    'city_pinyin': 'Jurong',
    'city_short': 'jr',
    'count': '5'
  },
  {
    'id': '363',
    'city_name': '贺州',
    'city_pre': 'H',
    'city_pinyin': 'Hezhou',
    'city_short': 'hz',
    'count': '4'
  },
  {
    'id': '364',
    'city_name': '白城',
    'city_pre': 'B',
    'city_pinyin': 'Baicheng',
    'city_short': 'bc',
    'count': '5'
  },
  {
    'id': '365',
    'city_name': '汾阳',
    'city_pre': 'F',
    'city_pinyin': 'Fenyang',
    'city_short': 'fy',
    'count': '2'
  },
  {
    'id': '366',
    'city_name': '白银',
    'city_pre': 'B',
    'city_pinyin': 'Baiyin',
    'city_short': 'by',
    'count': '10'
  },
  {
    'id': '367',
    'city_name': '遵化',
    'city_pre': 'Z',
    'city_pinyin': 'Zunhua',
    'city_short': 'zh',
    'count': '2'
  },
  {
    'id': '368',
    'city_name': '漳平',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangping',
    'city_short': 'zp',
    'count': '1'
  },
  {
    'id': '369',
    'city_name': '招远',
    'city_pre': 'Z',
    'city_pinyin': 'Zhaoyuan',
    'city_short': 'zy',
    'count': '1'
  },
  {
    'id': '370',
    'city_name': '霸州',
    'city_pre': 'B',
    'city_pinyin': 'Bazhou',
    'city_short': 'bz',
    'count': '2'
  },
  {
    'id': '371',
    'city_name': '宜都',
    'city_pre': 'Y',
    'city_pinyin': 'Yidu',
    'city_short': 'yd',
    'count': '2'
  },
  {
    'id': '372',
    'city_name': '项城',
    'city_pre': 'X',
    'city_pinyin': 'Xiangcheng',
    'city_short': 'xc',
    'count': '4'
  },
  {
    'id': '373',
    'city_name': '湘乡',
    'city_pre': 'X',
    'city_pinyin': 'Xiangxiang',
    'city_short': 'xx',
    'count': '3'
  },
  {
    'id': '374',
    'city_name': '应城',
    'city_pre': 'Y',
    'city_pinyin': 'Yingcheng',
    'city_short': 'yc',
    'count': '1'
  },
  {
    'id': '375',
    'city_name': '忻州',
    'city_pre': 'X',
    'city_pinyin': 'Xinzhou',
    'city_short': 'xz',
    'count': '16'
  },
  {
    'id': '376',
    'city_name': '兴宁',
    'city_pre': 'X',
    'city_pinyin': 'Xingning',
    'city_short': 'xn',
    'count': '1'
  },
  {
    'id': '377',
    'city_name': '洋浦市',
    'city_pre': 'X',
    'city_pinyin': 'yangpushi',
    'city_short': 'xps',
    'count': '1'
  },
  {
    'id': '378',
    'city_name': '兴平',
    'city_pre': 'X',
    'city_pinyin': 'Xingping',
    'city_short': 'xp',
    'count': '1'
  },
  {
    'id': '379',
    'city_name': '伊宁',
    'city_pre': 'Y',
    'city_pinyin': 'Yining',
    'city_short': 'yn',
    'count': '5'
  },
  {
    'id': '380',
    'city_name': '锡林浩特',
    'city_pre': 'X',
    'city_pinyin': 'Xilinhot',
    'city_short': 'xlht',
    'count': '4'
  },
  {
    'id': '381',
    'city_name': '永城',
    'city_pre': 'Y',
    'city_pinyin': 'Yongcheng',
    'city_short': 'yc',
    'count': '1'
  },
  {
    'id': '382',
    'city_name': '安陆',
    'city_pre': 'A',
    'city_pinyin': 'Anlu',
    'city_short': 'al',
    'count': '1'
  },
  {
    'id': '383',
    'city_name': '樟树',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangshu',
    'city_short': 'zs',
    'count': '4'
  },
  {
    'id': '384',
    'city_name': '兴城',
    'city_pre': 'X',
    'city_pinyin': 'Xingcheng',
    'city_short': 'xc',
    'count': '1'
  },
  {
    'id': '385',
    'city_name': '枝江',
    'city_pre': 'Z',
    'city_pinyin': 'Zhijiang',
    'city_short': 'zj',
    'count': '2'
  },
  {
    'id': '386',
    'city_name': '安达',
    'city_pre': 'A',
    'city_pinyin': 'Anda',
    'city_short': 'ad',
    'count': '3'
  },
  {
    'id': '387',
    'city_name': '信宜',
    'city_pre': 'X',
    'city_pinyin': 'Xinyi',
    'city_short': 'xy',
    'count': '2'
  },
  {
    'id': '388',
    'city_name': '宜州',
    'city_pre': 'Y',
    'city_pinyin': 'Yizhou',
    'city_short': 'yz',
    'count': '2'
  },
  {
    'id': '389',
    'city_name': '安宁',
    'city_pre': 'A',
    'city_pinyin': 'Anning',
    'city_short': 'an',
    'count': '1'
  },
  {
    'id': '390',
    'city_name': '兴义',
    'city_pre': 'X',
    'city_pinyin': 'Xingyi',
    'city_short': 'xy',
    'count': '5'
  },
  {
    'id': '391',
    'city_name': '钟祥',
    'city_pre': 'Z',
    'city_pinyin': 'Zhongxiang',
    'city_short': 'zx',
    'count': '2'
  },
  {
    'id': '392',
    'city_name': '中卫',
    'city_pre': 'Z',
    'city_pinyin': 'Zhongwei',
    'city_short': 'zw',
    'count': '3'
  },
  {
    'id': '393',
    'city_name': '巴中',
    'city_pre': 'B',
    'city_pinyin': 'Bazhong',
    'city_short': 'bz',
    'count': '10'
  },
  {
    'id': '394',
    'city_name': '大石桥',
    'city_pre': 'D',
    'city_pinyin': 'Dashiqiao',
    'city_short': 'ddq',
    'count': '2'
  },
  {
    'id': '395',
    'city_name': '兰溪',
    'city_pre': 'L',
    'city_pinyin': 'Lanxi',
    'city_short': 'lx',
    'count': '2'
  },
  {
    'id': '396',
    'city_name': '莱州',
    'city_pre': 'L',
    'city_pinyin': 'Laizhou',
    'city_short': 'lz',
    'count': '2'
  },
  {
    'id': '397',
    'city_name': '涟源',
    'city_pre': 'L',
    'city_pinyin': 'Lianyuan',
    'city_short': 'ly',
    'count': '2'
  },
  {
    'id': '398',
    'city_name': '乐平',
    'city_pre': 'L',
    'city_pinyin': 'Leping',
    'city_short': 'lp',
    'count': '3'
  },
  {
    'id': '399',
    'city_name': '冷水江',
    'city_pre': 'L',
    'city_pinyin': 'Lengshuijiang',
    'city_short': 'lsj',
    'count': '2'
  },
  {
    'id': '400',
    'city_name': '鸡西',
    'city_pre': 'J',
    'city_pinyin': 'Jixi',
    'city_short': 'jx',
    'count': '3'
  },
  {
    'id': '401',
    'city_name': '酒泉',
    'city_pre': 'J',
    'city_pinyin': 'Jiuquan',
    'city_short': 'jq',
    'count': '14'
  },
  {
    'id': '402',
    'city_name': '登封',
    'city_pre': 'D',
    'city_pinyin': 'Dengfeng',
    'city_short': 'df',
    'count': '1'
  },
  {
    'id': '403',
    'city_name': '来宾',
    'city_pre': 'L',
    'city_pinyin': 'Laibin',
    'city_short': 'lb',
    'count': '7'
  },
  {
    'id': '404',
    'city_name': '库尔勒',
    'city_pre': 'K',
    'city_pinyin': 'Korla',
    'city_short': 'kel',
    'count': '4'
  },
  {
    'id': '405',
    'city_name': '开平',
    'city_pre': 'K',
    'city_pinyin': 'Kaiping',
    'city_short': 'kp',
    'count': '4'
  },
  {
    'id': '406',
    'city_name': '丽江',
    'city_pre': 'L',
    'city_pinyin': 'Lijiang',
    'city_short': 'lj',
    'count': '5'
  },
  {
    'id': '407',
    'city_name': '鹿泉',
    'city_pre': 'L',
    'city_pinyin': 'Luquan',
    'city_short': 'lq',
    'count': '1'
  },
  {
    'id': '408',
    'city_name': '漯河',
    'city_pre': 'L',
    'city_pinyin': 'Luohe',
    'city_short': 'lh',
    'count': '15'
  },
  {
    'id': '409',
    'city_name': '丹江口',
    'city_pre': 'D',
    'city_pinyin': 'Danjiangkou',
    'city_short': 'djk',
    'count': '3'
  },
  {
    'id': '410',
    'city_name': '孟州',
    'city_pre': 'M',
    'city_pinyin': 'Mengzhou',
    'city_short': 'mz',
    'count': '3'
  },
  {
    'id': '411',
    'city_name': '梅河口',
    'city_pre': 'M',
    'city_pinyin': 'Meihekou',
    'city_short': 'mhk',
    'count': '3'
  },
  {
    'id': '412',
    'city_name': '麻城',
    'city_pre': 'M',
    'city_pinyin': 'Macheng',
    'city_short': 'mc',
    'count': '3'
  },
  {
    'id': '413',
    'city_name': '陵水',
    'city_pre': 'L',
    'city_pinyin': 'Lingshui',
    'city_short': 'ls',
    'count': '1'
  },
  {
    'id': '414',
    'city_name': '临沧',
    'city_pre': 'L',
    'city_pinyin': 'Lincang',
    'city_short': 'lc',
    'count': '15'
  },
  {
    'id': '415',
    'city_name': '醴陵',
    'city_pre': 'L',
    'city_pinyin': 'Liling',
    'city_short': 'll',
    'count': '3'
  },
  {
    'id': '416',
    'city_name': '龙泉',
    'city_pre': 'L',
    'city_pinyin': 'Longquan',
    'city_short': 'lq',
    'count': '1'
  },
  {
    'id': '417',
    'city_name': '龙海',
    'city_pre': 'L',
    'city_pinyin': 'Longhai',
    'city_short': 'lh',
    'count': '1'
  },
  {
    'id': '418',
    'city_name': '临清',
    'city_pre': 'L',
    'city_pinyin': 'Linqing',
    'city_short': 'lq',
    'count': '2'
  },
  {
    'id': '419',
    'city_name': '河池',
    'city_pre': 'H',
    'city_pinyin': 'Hechi',
    'city_short': 'hc',
    'count': '13'
  },
  {
    'id': '420',
    'city_name': '都匀',
    'city_pre': 'D',
    'city_pinyin': 'Duyun',
    'city_short': 'dy',
    'count': '1'
  },
  {
    'id': '421',
    'city_name': '汉川',
    'city_pre': 'H',
    'city_pinyin': 'Hanchuan',
    'city_short': 'hc',
    'count': '1'
  },
  {
    'id': '422',
    'city_name': '洪湖',
    'city_pre': 'H',
    'city_pinyin': 'Honghu',
    'city_short': 'hh',
    'count': '4'
  },
  {
    'id': '423',
    'city_name': '合作',
    'city_pre': 'G',
    'city_pinyin': 'Hezuo',
    'city_short': 'gz',
    'count': '1'
  },
  {
    'id': '424',
    'city_name': '敦煌',
    'city_pre': 'D',
    'city_pinyin': 'Dunhuang',
    'city_short': 'dh',
    'count': '1'
  },
  {
    'id': '425',
    'city_name': '格尔木',
    'city_pre': 'G',
    'city_pinyin': 'Geermu',
    'city_short': 'gem',
    'count': '2'
  },
  {
    'id': '426',
    'city_name': '高安',
    'city_pre': 'G',
    'city_pinyin': 'Gaoan',
    'city_short': 'ga',
    'count': '3'
  },
  {
    'id': '427',
    'city_name': '丰城',
    'city_pre': 'F',
    'city_pinyin': 'Fengcheng',
    'city_short': 'fc',
    'count': '4'
  },
  {
    'id': '428',
    'city_name': '韩城',
    'city_pre': 'H',
    'city_pinyin': 'Hancheng',
    'city_short': 'hc',
    'count': '2'
  },
  {
    'id': '429',
    'city_name': '贵溪',
    'city_pre': 'G',
    'city_pinyin': 'Guixi',
    'city_short': 'gx',
    'count': '4'
  },
  {
    'id': '430',
    'city_name': '广汉',
    'city_pre': 'G',
    'city_pinyin': 'Guanghan',
    'city_short': 'gh',
    'count': '1'
  },
  {
    'id': '431',
    'city_name': '迪庆',
    'city_pre': 'D',
    'city_pinyin': 'Diqing',
    'city_short': 'dq',
    'count': '2'
  },
  {
    'id': '432',
    'city_name': '金昌',
    'city_pre': 'J',
    'city_pinyin': 'Jinchang',
    'city_short': 'jc',
    'count': '4'
  },
  {
    'id': '433',
    'city_name': '德兴',
    'city_pre': 'D',
    'city_pinyin': 'Dexing',
    'city_short': 'dx',
    'count': '1'
  },
  {
    'id': '434',
    'city_name': '界首',
    'city_pre': 'J',
    'city_pinyin': 'Jieshou',
    'city_short': 'js',
    'count': '1'
  },
  {
    'id': '435',
    'city_name': '晋中',
    'city_pre': 'J',
    'city_pinyin': 'Jinzhong',
    'city_short': 'jz',
    'count': '18'
  },
  {
    'id': '436',
    'city_name': '灯塔',
    'city_pre': 'D',
    'city_pinyin': 'Dengta',
    'city_short': 'dd',
    'count': '1'
  },
  {
    'id': '437',
    'city_name': '邓州',
    'city_pre': 'D',
    'city_pinyin': 'Dengzhou',
    'city_short': 'dz',
    'count': '1'
  },
  {
    'id': '438',
    'city_name': '定西',
    'city_pre': 'D',
    'city_pinyin': 'Dingxi',
    'city_short': 'dx',
    'count': '11'
  },
  {
    'id': '439',
    'city_name': '珲春',
    'city_pre': 'H',
    'city_pinyin': 'Huichun',
    'city_short': 'hc',
    'count': '4'
  },
  {
    'id': '440',
    'city_name': '华蓥',
    'city_pre': 'H',
    'city_pinyin': 'Huaying',
    'city_short': 'hy',
    'count': '1'
  },
  {
    'id': '442',
    'city_name': '建德',
    'city_pre': 'J',
    'city_pinyin': 'Jiande',
    'city_short': 'jd',
    'count': '3'
  },
  {
    'id': '443',
    'city_name': '虎林',
    'city_pre': 'H',
    'city_pinyin': 'Hulin',
    'city_short': 'hl',
    'count': '1'
  },
  {
    'id': '444',
    'city_name': '朔州',
    'city_pre': 'S',
    'city_pinyin': 'Shuozhou',
    'city_short': 'sz',
    'count': '8'
  },
  {
    'id': '445',
    'city_name': '双鸭山',
    'city_pre': 'S',
    'city_pinyin': 'Shuangyashan',
    'city_short': 'sys',
    'count': '9'
  },
  {
    'id': '446',
    'city_name': '石狮',
    'city_pre': 'S',
    'city_pinyin': 'Shishi',
    'city_short': 'ss',
    'count': '3'
  },
  {
    'id': '447',
    'city_name': '塔城',
    'city_pre': 'D',
    'city_pinyin': 'Tacheng',
    'city_short': 'dc',
    'count': '10'
  },
  {
    'id': '448',
    'city_name': '长乐',
    'city_pre': 'C',
    'city_pinyin': 'Changle',
    'city_short': 'cl',
    'count': '5'
  },
  {
    'id': '449',
    'city_name': '四会',
    'city_pre': 'S',
    'city_pinyin': 'Sihui',
    'city_short': 'sh',
    'count': '1'
  },
  {
    'id': '450',
    'city_name': '射阳',
    'city_pre': 'S',
    'city_pinyin': 'Sheyangshi',
    'city_short': 'sys',
    'count': '2'
  },
  {
    'id': '451',
    'city_name': '神农架',
    'city_pre': 'S',
    'city_pinyin': 'Shennongjia',
    'city_short': 'snjlo',
    'count': '1'
  },
  {
    'id': '452',
    'city_name': '嵊州',
    'city_pre': 'S',
    'city_pinyin': 'Shengzhou',
    'city_short': 'sz',
    'count': '5'
  },
  {
    'id': '453',
    'city_name': '昌邑',
    'city_pre': 'C',
    'city_pinyin': 'Changyi',
    'city_short': 'cy',
    'count': '3'
  },
  {
    'id': '454',
    'city_name': '石河子',
    'city_pre': 'D',
    'city_pinyin': 'Shihezi',
    'city_short': 'dhz',
    'count': '6'
  },
  {
    'id': '455',
    'city_name': '什邡',
    'city_pre': 'S',
    'city_pinyin': 'Shifang',
    'city_short': 'sf',
    'count': '1'
  },
  {
    'id': '456',
    'city_name': '昌吉',
    'city_pre': 'C',
    'city_pinyin': 'Changji',
    'city_short': 'cj',
    'count': '8'
  },
  {
    'id': '457',
    'city_name': '乌海',
    'city_pre': 'W',
    'city_pinyin': 'Wuhai',
    'city_short': 'wh',
    'count': '5'
  },
  {
    'id': '458',
    'city_name': '吴川',
    'city_pre': 'W',
    'city_pinyin': 'Wuchuan',
    'city_short': 'wc',
    'count': '2'
  },
  {
    'id': '459',
    'city_name': '武安',
    'city_pre': 'W',
    'city_pinyin': 'Wuan',
    'city_short': 'wa',
    'count': '2'
  },
  {
    'id': '460',
    'city_name': '吴忠',
    'city_pre': 'W',
    'city_pinyin': 'Wuzhong',
    'city_short': 'wz',
    'count': '5'
  },
  {
    'id': '461',
    'city_name': '武威',
    'city_pre': 'W',
    'city_pinyin': 'Wuwei',
    'city_short': 'ww',
    'count': '6'
  },
  {
    'id': '462',
    'city_name': '乌兰浩特',
    'city_pre': 'W',
    'city_pinyin': 'Wulanhot',
    'city_short': 'wlht',
    'count': '10'
  },
  {
    'id': '463',
    'city_name': '桐城',
    'city_pre': 'T',
    'city_pinyin': 'Tongcheng',
    'city_short': 'tc',
    'count': '2'
  },
  {
    'id': '464',
    'city_name': '铁力',
    'city_pre': 'T',
    'city_pinyin': 'Tieli',
    'city_short': 'tl',
    'count': '1'
  },
  {
    'id': '465',
    'city_name': '岑溪',
    'city_pre': 'C',
    'city_pinyin': 'Cenxi',
    'city_short': 'cx',
    'count': '1'
  },
  {
    'id': '466',
    'city_name': '博乐',
    'city_pre': 'B',
    'city_pinyin': 'Bole',
    'city_short': 'bl',
    'count': '2'
  },
  {
    'id': '467',
    'city_name': '泊头',
    'city_pre': 'B',
    'city_pinyin': 'Botou',
    'city_short': 'bt',
    'count': '2'
  },
  {
    'id': '468',
    'city_name': '瓦房店',
    'city_pre': 'W',
    'city_pinyin': 'Wafangdian',
    'city_short': 'wfd',
    'count': '3'
  },
  {
    'id': '469',
    'city_name': '平凉',
    'city_pre': 'P',
    'city_pinyin': 'Pingliang',
    'city_short': 'pl',
    'count': '13'
  },
  {
    'id': '470',
    'city_name': '平度',
    'city_pre': 'P',
    'city_pinyin': 'Pingdu',
    'city_short': 'pd',
    'count': '2'
  },
  {
    'id': '471',
    'city_name': '蓬莱',
    'city_pre': 'P',
    'city_pinyin': 'Penglai',
    'city_short': 'pl',
    'count': '3'
  },
  {
    'id': '472',
    'city_name': '黔南',
    'city_pre': 'Q',
    'city_pinyin': 'Qiannan',
    'city_short': 'qn',
    'count': '14'
  },
  {
    'id': '473',
    'city_name': '普兰店',
    'city_pre': 'P',
    'city_pinyin': 'Pulandian',
    'city_short': 'pld',
    'count': '2'
  },
  {
    'id': '474',
    'city_name': '邳州',
    'city_pre': 'P',
    'city_pinyin': 'Pizhou',
    'city_short': 'pz',
    'count': '4'
  },
  {
    'id': '475',
    'city_name': '楚雄',
    'city_pre': 'C',
    'city_pinyin': 'Chuxiong',
    'city_short': 'cx',
    'count': '16'
  },
  {
    'id': '476',
    'city_name': '大丰',
    'city_pre': 'D',
    'city_pinyin': 'Dafeng',
    'city_short': 'df',
    'count': '3'
  },
  {
    'id': '477',
    'city_name': '绵竹',
    'city_pre': 'M',
    'city_pinyin': 'Mianzhu',
    'city_short': 'mz',
    'count': '2'
  },
  {
    'id': '478',
    'city_name': '池州',
    'city_pre': 'C',
    'city_pinyin': 'Chizhou',
    'city_short': 'cz',
    'count': '8'
  },
  {
    'id': '479',
    'city_name': '讷河',
    'city_pre': 'N',
    'city_pinyin': 'Nehe',
    'city_short': 'nh',
    'count': '1'
  },
  {
    'id': '480',
    'city_name': '崇州',
    'city_pre': 'C',
    'city_pinyin': 'Chongzhou',
    'city_short': 'cz',
    'count': '4'
  },
  {
    'id': '481',
    'city_name': '庆阳',
    'city_pre': 'Q',
    'city_pinyin': 'Qingyang',
    'city_short': 'qy',
    'count': '11'
  },
  {
    'id': '482',
    'city_name': '汝州',
    'city_pre': 'R',
    'city_pinyin': 'Ruzhou',
    'city_short': 'rz',
    'count': '1'
  },
  {
    'id': '483',
    'city_name': '乳山',
    'city_pre': 'R',
    'city_pinyin': 'Rushan',
    'city_short': 'rs',
    'count': '1'
  },
  {
    'id': '484',
    'city_name': '瑞昌',
    'city_pre': 'R',
    'city_pinyin': 'Ruichang',
    'city_short': 'rc',
    'count': '3'
  },
  {
    'id': '485',
    'city_name': '邵武',
    'city_pre': 'S',
    'city_pinyin': 'Shaowu',
    'city_short': 'sw',
    'count': '3'
  },
  {
    'id': '486',
    'city_name': '尚志',
    'city_pre': 'S',
    'city_pinyin': 'Shangzhi',
    'city_short': 'sz',
    'count': '2'
  },
  {
    'id': '487',
    'city_name': '上高市',
    'city_pre': 'S',
    'city_pinyin': 'Shanggaoshi',
    'city_short': 'sgs',
    'count': '1'
  },
  {
    'id': '488',
    'city_name': '曲阜',
    'city_pre': 'Q',
    'city_pinyin': 'Qufu',
    'city_short': 'qf',
    'count': '2'
  },
  {
    'id': '489',
    'city_name': '邛崃',
    'city_pre': 'Q',
    'city_pinyin': 'Qionglai',
    'city_short': 'ql',
    'count': '1'
  },
  {
    'id': '490',
    'city_name': '琼海',
    'city_pre': 'Q',
    'city_pinyin': 'Qionghai',
    'city_short': 'qh',
    'count': '4'
  },
  {
    'id': '491',
    'city_name': '荣成',
    'city_pre': 'R',
    'city_pinyin': 'Rongcheng',
    'city_short': 'rc',
    'count': '2'
  },
  {
    'id': '492',
    'city_name': '仁怀',
    'city_pre': 'R',
    'city_pinyin': 'Renhuai',
    'city_short': 'rh',
    'count': '1'
  },
  {
    'id': '493',
    'city_name': '澄迈县',
    'city_pre': 'C',
    'city_pinyin': 'Chengmaixian',
    'city_short': 'cmx',
    'count': '2'
  },
  {
    'id': '494',
    'city_name': '调兵山',
    'city_pre': 'D',
    'city_pinyin': 'Diaobingshan',
    'city_short': 'dbs',
    'count': '2'
  },
  {
    'id': '495',
    'city_name': '巩义',
    'city_pre': 'G',
    'city_pinyin': 'Gongyi',
    'city_short': 'gy',
    'count': '2'
  },
  {
    'id': '496',
    'city_name': '万宁',
    'city_pre': 'W',
    'city_pinyin': 'Wanning',
    'city_short': 'wn',
    'count': '1'
  },
  {
    'id': '975',
    'city_name': '高州',
    'city_pre': 'G',
    'city_pinyin': 'Gaozhou',
    'city_short': 'gz',
    'count': '3'
  },
  {
    'id': '976',
    'city_name': '伊春',
    'city_pre': 'Y',
    'city_pinyin': 'Yichun',
    'city_short': 'yc',
    'count': '4'
  },
  {
    'id': '977',
    'city_name': '章丘',
    'city_pre': 'Z',
    'city_pinyin': 'Zhangqiu',
    'city_short': 'zq',
    'count': '3'
  },
  {
    'id': '978',
    'city_name': '常宁',
    'city_pre': 'C',
    'city_pinyin': 'Changning',
    'city_short': 'cn',
    'count': '1'
  },
  {
    'id': '979',
    'city_name': '福鼎',
    'city_pre': 'F',
    'city_pinyin': 'Fuding',
    'city_short': 'fd',
    'count': '1'
  },
  {
    'id': '980',
    'city_name': '广水',
    'city_pre': 'G',
    'city_pinyin': 'Guangshui',
    'city_short': 'as',
    'count': '4'
  },
  {
    'id': '981',
    'city_name': '广安',
    'city_pre': 'G',
    'city_pinyin': 'Guangan',
    'city_short': 'ga',
    'count': '9'
  },
  {
    'id': '982',
    'city_name': '介休',
    'city_pre': 'J',
    'city_pinyin': 'Jiexiu',
    'city_short': 'jx',
    'count': '2'
  },
  {
    'id': '983',
    'city_name': '临夏',
    'city_pre': 'L',
    'city_pinyin': 'Linxia',
    'city_short': 'lx',
    'count': '9'
  },
  {
    'id': '984',
    'city_name': '海东',
    'city_pre': 'h',
    'city_pinyin': 'haidong',
    'city_short': 'hd',
    'count': '6'
  },
  {
    'id': '985',
    'city_name': '乐清',
    'city_pre': 'L',
    'city_pinyin': 'Leqing',
    'city_short': 'lq',
    'count': '6'
  },
  {
    'id': '986',
    'city_name': '吐鲁番',
    'city_pre': 'T',
    'city_pinyin': 'Turpan',
    'city_short': 'tlf',
    'count': '3'
  },
  {
    'id': '987',
    'city_name': '屯昌县',
    'city_pre': 'T',
    'city_pinyin': 'Tunchangxian',
    'city_short': 'tcx',
    'count': '2'
  },
  {
    'id': '988',
    'city_name': '双辽',
    'city_pre': 'S',
    'city_pinyin': 'Shuangliao',
    'city_short': 'sl',
    'count': '3'
  },
  {
    'id': '989',
    'city_name': '定州',
    'city_pre': 'D',
    'city_pinyin': 'Dingzhou',
    'city_short': 'dz',
    'count': '4'
  },
  {
    'id': '990',
    'city_name': '黔西南州',
    'city_pre': 'Q',
    'city_pinyin': 'Qianxinan',
    'city_short': 'qxn',
    'count': '10'
  },
  {
    'id': '991',
    'city_name': '崇左',
    'city_pre': 'C',
    'city_pinyin': 'Chongzuo',
    'city_short': 'cz',
    'count': '8'
  },
  {
    'id': '992',
    'city_name': '乌兰察布',
    'city_pre': 'W',
    'city_pinyin': 'Wulanchabu',
    'city_short': 'wlcb',
    'count': '12'
  },
  {
    'id': '993',
    'city_name': '昭通',
    'city_pre': 'Z',
    'city_pinyin': 'Zhaotong',
    'city_short': 'zt',
    'count': '7'
  },
  {
    'id': '994',
    'city_name': '德宏',
    'city_pre': 'D',
    'city_pinyin': 'Dehong',
    'city_short': 'dh',
    'count': '8'
  },
  {
    'id': '995',
    'city_name': '七台河',
    'city_pre': 'Q',
    'city_pinyin': 'Qitaihe',
    'city_short': 'qth',
    'count': '3'
  },
  {
    'id': '996',
    'city_name': '敦化',
    'city_pre': 'D',
    'city_pinyin': 'Dunhua',
    'city_short': 'dh',
    'count': '7'
  },
  {
    'id': '997',
    'city_name': '克拉玛依',
    'city_pre': 'K',
    'city_pinyin': 'Karamay',
    'city_short': 'klmy',
    'count': '4'
  },
  {
    'id': '998',
    'city_name': '东方',
    'city_pre': 'd',
    'city_pinyin': 'dongfang',
    'city_short': 'df',
    'count': '3'
  },
  {
    'id': '999',
    'city_name': '高密',
    'city_pre': 'G',
    'city_pinyin': 'Gaomi',
    'city_short': 'gm',
    'count': '1'
  },
  {
    'id': '1000',
    'city_name': '公主岭',
    'city_pre': 'G',
    'city_pinyin': 'Gongzhuling',
    'city_short': 'gzl',
    'count': '5'
  },
  {
    'id': '1001',
    'city_name': '海城',
    'city_pre': 'H',
    'city_pinyin': 'Haicheng',
    'city_short': 'hc',
    'count': '2'
  },
  {
    'id': '1002',
    'city_name': '阿勒泰',
    'city_pre': 'A',
    'city_pinyin': 'Aletai',
    'city_short': 'alt',
    'count': '3'
  },
  {
    'id': '1003',
    'city_name': '任丘',
    'city_pre': 'R',
    'city_pinyin': 'Renqiu',
    'city_short': 'rq',
    'count': '3'
  },
  {
    'id': '1004',
    'city_name': '双城',
    'city_pre': 'S',
    'city_pinyin': 'Shuangcheng',
    'city_short': 'sc',
    'count': '2'
  },
  {
    'id': '1005',
    'city_name': '庄河',
    'city_pre': 'Z',
    'city_pinyin': 'Zhuanghe',
    'city_short': 'zh',
    'count': '2'
  },
  {
    'id': '1006',
    'city_name': '当阳',
    'city_pre': 'D',
    'city_pinyin': 'Dangyang',
    'city_short': 'dy',
    'count': '2'
  },
  {
    'id': '1007',
    'city_name': '华阴',
    'city_pre': 'H',
    'city_pinyin': 'Huayin',
    'city_short': 'hy',
    'count': '1'
  },
  {
    'id': '1008',
    'city_name': '阆中',
    'city_pre': 'L',
    'city_pinyin': 'Langzhong',
    'city_short': 'lz',
    'count': '2'
  },
  {
    'id': '1009',
    'city_name': '霍州',
    'city_pre': 'H',
    'city_pinyin': 'Huozhou',
    'city_short': 'hz',
    'count': '1'
  },
  {
    'id': '1010',
    'city_name': '桦甸',
    'city_pre': 'H',
    'city_pinyin': 'Huadian',
    'city_short': 'hd',
    'count': '3'
  },
  {
    'id': '1011',
    'city_name': '吉首',
    'city_pre': 'J',
    'city_pinyin': 'Jishou',
    'city_short': 'js',
    'count': '1'
  },
  {
    'id': '1012',
    'city_name': '哈密',
    'city_pre': 'H',
    'city_pinyin': 'Hami',
    'city_short': 'hm',
    'count': '6'
  },
  {
    'id': '1013',
    'city_name': '河间',
    'city_pre': 'H',
    'city_pinyin': 'Hejian',
    'city_short': 'hj',
    'count': '1'
  },
  {
    'id': '1014',
    'city_name': '巴音郭楞',
    'city_pre': 'b',
    'city_pinyin': 'bayinguoleng',
    'city_short': 'bygl',
    'count': '3'
  },
  {
    'id': '1015',
    'city_name': '简阳',
    'city_pre': 'J',
    'city_pinyin': 'Jianyang',
    'city_short': 'jy',
    'count': '2'
  },
  {
    'id': '1016',
    'city_name': '北安',
    'city_pre': 'B',
    'city_pinyin': 'Beian',
    'city_short': 'ba',
    'count': '2'
  },
  {
    'id': '1017',
    'city_name': '沅江',
    'city_pre': 'Y',
    'city_pinyin': 'Yuanjiang',
    'city_short': 'yj',
    'count': '1'
  },
  {
    'id': '1018',
    'city_name': '天长',
    'city_pre': 'T',
    'city_pinyin': 'Tianchang',
    'city_short': 'tc',
    'count': '1'
  },
  {
    'id': '1019',
    'city_name': '洮南',
    'city_pre': 'T',
    'city_pinyin': 'Taonan',
    'city_short': 'tn',
    'count': '2'
  },
  {
    'id': '1020',
    'city_name': '大兴安岭',
    'city_pre': 'D',
    'city_pinyin': 'Daxinganling',
    'city_short': 'dxal',
    'count': '4'
  },
  {
    'id': '1021',
    'city_name': '图门',
    'city_pre': 'T',
    'city_pinyin': 'Tumen',
    'city_short': 'tm',
    'count': '1'
  },
  {
    'id': '1022',
    'city_name': '甘南',
    'city_pre': 'G',
    'city_pinyin': 'Gannan',
    'city_short': 'gn',
    'count': '9'
  },
  {
    'id': '1023',
    'city_name': '福安',
    'city_pre': 'F',
    'city_pinyin': 'Fuan',
    'city_short': 'fa',
    'count': '3'
  },
  {
    'id': '1024',
    'city_name': '大冶',
    'city_pre': 'D',
    'city_pinyin': 'Daye',
    'city_short': 'dy',
    'count': '1'
  },
  {
    'id': '1025',
    'city_name': '时光市',
    'city_pre': 'S',
    'city_pinyin': 'Shiguangshi',
    'city_short': 'sgs',
    'count': '7'
  },
  {
    'id': '1026',
    'city_name': '东兴',
    'city_pre': 'D',
    'city_pinyin': 'Dongxing',
    'city_short': 'dx',
    'count': '2'
  },
  {
    'id': '1027',
    'city_name': '瑞金',
    'city_pre': 'R',
    'city_pinyin': 'Ruijin',
    'city_short': 'rj',
    'count': '2'
  },
  {
    'id': '1028',
    'city_name': '汨罗',
    'city_pre': 'M',
    'city_pinyin': 'Miluo',
    'city_short': 'ml',
    'count': '2'
  },
  {
    'id': '1029',
    'city_name': '辛集',
    'city_pre': 'X',
    'city_pinyin': 'Xinji',
    'city_short': 'xj',
    'count': '1'
  },
  {
    'id': '1030',
    'city_name': '新密',
    'city_pre': 'X',
    'city_pinyin': 'Xinmi',
    'city_short': 'xm',
    'count': '1'
  },
  {
    'id': '1031',
    'city_name': '延吉',
    'city_pre': 'Y',
    'city_pinyin': 'Yanji',
    'city_short': 'yj',
    'count': '3'
  },
  {
    'id': '1032',
    'city_name': '老河口',
    'city_pre': 'L',
    'city_pinyin': 'Laohekou',
    'city_short': 'lhk',
    'count': '2'
  },
  {
    'id': '1033',
    'city_name': '昌江',
    'city_pre': 'c',
    'city_pinyin': 'changjiang',
    'city_short': 'cj',
    'count': '1'
  },
  {
    'id': '1034',
    'city_name': '乐东',
    'city_pre': 'l',
    'city_pinyin': 'ledong',
    'city_short': 'ld',
    'count': '3'
  },
  {
    'id': '1035',
    'city_name': '锡林郭勒',
    'city_pre': 'X',
    'city_pinyin': 'Xilinguole',
    'city_short': 'xlgl',
    'count': '6'
  },
  {
    'id': '1036',
    'city_name': '五常',
    'city_pre': 'W',
    'city_pinyin': 'Wuchang',
    'city_short': 'wc',
    'count': '1'
  },
  {
    'id': '1037',
    'city_name': '五大连池',
    'city_pre': 'W',
    'city_pinyin': 'Wudalianchi',
    'city_short': 'wdlc',
    'count': '1'
  },
  {
    'id': '1038',
    'city_name': '文昌',
    'city_pre': 'w',
    'city_pinyin': 'wenchang',
    'city_short': 'wc',
    'count': '3'
  },
  {
    'id': '1039',
    'city_name': '临湘',
    'city_pre': 'L',
    'city_pinyin': 'Linxiang',
    'city_short': 'lx',
    'count': '1'
  },
  {
    'id': '1040',
    'city_name': '龙井',
    'city_pre': 'L',
    'city_pinyin': 'Longjing',
    'city_short': 'lj',
    'count': '1'
  },
  {
    'id': '1041',
    'city_name': '高碑店',
    'city_pre': 'G',
    'city_pinyin': 'Gaobeidian',
    'city_short': 'gbd',
    'count': '2'
  },
  {
    'id': '1042',
    'city_name': '潞城',
    'city_pre': 'L',
    'city_pinyin': 'Lucheng',
    'city_short': 'lc',
    'count': '1'
  },
  {
    'id': '1589',
    'city_name': '恩平',
    'city_pre': 'E',
    'city_pinyin': 'Enping',
    'city_short': 'ep',
    'count': '1'
  },
  {
    'id': '2634',
    'city_name': '台山',
    'city_pre': 'T',
    'city_pinyin': 'Taishan',
    'city_short': 'ts',
    'count': '1'
  },
  {
    'id': '3194',
    'city_name': '雷州',
    'city_pre': 'L',
    'city_pinyin': 'Leizhou',
    'city_short': 'lz',
    'count': '1'
  },
  {
    'id': '3735',
    'city_name': '黑河',
    'city_pre': 'H',
    'city_pinyin': 'Heihe',
    'city_short': 'hh',
    'count': '3'
  },
  {
    'id': '3777',
    'city_name': '新郑',
    'city_pre': 'X',
    'city_pinyin': 'Xinzheng',
    'city_short': 'xz',
    'count': '3'
  },
  {
    'id': '4277',
    'city_name': '德惠',
    'city_pre': 'D',
    'city_pinyin': 'Dehui',
    'city_short': 'dh',
    'count': '2'
  },
  {
    'id': '4295',
    'city_name': '蛟河',
    'city_pre': 'J',
    'city_pinyin': 'Jiaohe',
    'city_short': 'jh',
    'count': '2'
  },
  {
    'id': '4304',
    'city_name': '林州',
    'city_pre': 'L',
    'city_pinyin': 'Linzhou',
    'city_short': 'lz',
    'count': '1'
  },
  {
    'id': '4311',
    'city_name': '磐石',
    'city_pre': 'P',
    'city_pinyin': 'Panshi',
    'city_short': 'pd',
    'count': '3'
  },
  {
    'id': '5398',
    'city_name': '二连浩特',
    'city_pre': 'E',
    'city_pinyin': 'Elianhot',
    'city_short': 'elht',
    'count': '1'
  },
  {
    'id': '5968',
    'city_name': '莱西',
    'city_pre': 'L',
    'city_pinyin': 'Laixi',
    'city_short': 'lx',
    'count': '1'
  },
  {
    'id': '5982',
    'city_name': '黔东南',
    'city_pre': 'Q',
    'city_pinyin': 'Qiandongnan',
    'city_short': 'qdn',
    'count': '13'
  },
  {
    'id': '6536',
    'city_name': '陆丰',
    'city_pre': 'L',
    'city_pinyin': 'Lufeng',
    'city_short': 'lf',
    'count': '1'
  },
  {
    'id': '7658',
    'city_name': '清镇',
    'city_pre': 'Q',
    'city_pinyin': 'Qingzhen',
    'city_short': 'qz',
    'count': '1'
  },
  {
    'id': '8197',
    'city_name': '辉县',
    'city_pre': 'H',
    'city_pinyin': 'Huixian',
    'city_short': 'hx',
    'count': '2'
  },
  {
    'id': '9039',
    'city_name': '甘孜',
    'city_pre': 'G',
    'city_pinyin': 'Ganzi',
    'city_short': 'gz',
    'count': '10'
  },
  {
    'id': '9117',
    'city_name': '凉山',
    'city_pre': 'L',
    'city_pinyin': 'Liangshan',
    'city_short': 'ls',
    'count': '5'
  },
  {
    'id': '9161',
    'city_name': '阿拉善',
    'city_pre': 'A',
    'city_pinyin': 'Alashan',
    'city_short': 'als',
    'count': '4'
  },
  {
    'id': '9293',
    'city_name': '兴安',
    'city_pre': 'X',
    'city_pinyin': 'Xingan',
    'city_short': 'xa',
    'count': '2'
  },
  {
    'id': '9294',
    'city_name': '新乐',
    'city_pre': 'X',
    'city_pinyin': 'Xinle',
    'city_short': 'xl',
    'count': '2'
  },
  {
    'id': '9306',
    'city_name': '白沙',
    'city_pre': 'b',
    'city_pinyin': 'baisha',
    'city_short': 'bs',
    'count': '1'
  },
  {
    'id': '9316',
    'city_name': '定安县',
    'city_pre': 'd',
    'city_pinyin': 'dinganxian',
    'city_short': 'dax',
    'count': '1'
  },
  {
    'id': '9334',
    'city_name': '凌源',
    'city_pre': 'L',
    'city_pinyin': 'Lingyuan',
    'city_short': 'ly',
    'count': '1'
  },
  {
    'id': '9343',
    'city_name': '密山',
    'city_pre': 'M',
    'city_pinyin': 'Mishan',
    'city_short': 'ms',
    'count': '1'
  },
  {
    'id': '9344',
    'city_name': '南雄',
    'city_pre': 'N',
    'city_pinyin': 'Nanxiong',
    'city_short': 'nx',
    'count': '1'
  },
  {
    'id': '9346',
    'city_name': '彭州市',
    'city_pre': 'P',
    'city_pinyin': 'Pengzhoushi',
    'city_short': 'pzs',
    'count': '1'
  },
  {
    'id': '9645',
    'city_name': '阿坝',
    'city_pre': 'A',
    'city_pinyin': 'Aba',
    'city_short': 'ab',
    'count': '8'
  },
  {
    'id': '9672',
    'city_name': '普洱',
    'city_pre': 'p',
    'city_pinyin': 'puer',
    'city_short': '',
    'count': '7'
  },
  {
    'id': '9767',
    'city_name': '德令哈',
    'city_pre': 'D',
    'city_pinyin': 'Delingha',
    'city_short': 'dlh',
    'count': '3'
  },
  {
    'id': '9795',
    'city_name': '怒江',
    'city_pre': 'N',
    'city_pinyin': 'Nujiang',
    'city_short': 'nj',
    'count': '3'
  },
  {
    'id': '9822',
    'city_name': '阿拉尔',
    'city_pre': 'A',
    'city_pinyin': 'Alaer',
    'city_short': 'ale',
    'count': '2'
  },
  {
    'id': '9825',
    'city_name': '博尔塔拉',
    'city_pre': 'b',
    'city_pinyin': 'boertala',
    'city_short': 'bedl',
    'count': '2'
  },
  {
    'id': '9846',
    'city_name': '海南藏族自治州',
    'city_pre': 'H',
    'city_pinyin': 'Hainanzangzuzizhizhou',
    'city_short': 'hnczzzz',
    'count': '2'
  },
  {
    'id': '9856',
    'city_name': '克孜勒',
    'city_pre': 'k',
    'city_pinyin': 'kezile',
    'city_short': 'kzl',
    'count': '2'
  },
  {
    'id': '9875',
    'city_name': '沭阳',
    'city_pre': 'S',
    'city_pinyin': 'Shuyang',
    'city_short': 'sy',
    'count': '2'
  },
  {
    'id': '9898',
    'city_name': '昌都',
    'city_pre': 'C',
    'city_pinyin': 'Changdu',
    'city_short': 'cd',
    'count': '1'
  },
  {
    'id': '9910',
    'city_name': '海北',
    'city_pre': 'h',
    'city_pinyin': 'haibei',
    'city_short': 'hb',
    'count': '1'
  },
  {
    'id': '9917',
    'city_name': '井冈山',
    'city_pre': 'J',
    'city_pinyin': 'Jinggangshan',
    'city_short': 'jgs',
    'count': '1'
  },
  {
    'id': '9922',
    'city_name': '林芝',
    'city_pre': 'L',
    'city_pinyin': 'Linzhi',
    'city_short': 'lz',
    'count': '1'
  },
  {
    'id': '9932',
    'city_name': '栖霞',
    'city_pre': 'Q',
    'city_pinyin': 'Qixia',
    'city_short': 'qx',
    'count': '2'
  },
  {
    'id': '9934',
    'city_name': '瑞丽',
    'city_pre': 'R',
    'city_pinyin': 'Ruili',
    'city_short': 'rl',
    'count': '1'
  },
  {
    'id': '9937',
    'city_name': '山南',
    'city_pre': 'S',
    'city_pinyin': 'Shannan',
    'city_short': 'sn',
    'count': '1'
  },
  {
    'id': '9944',
    'city_name': '卫辉',
    'city_pre': 'W',
    'city_pinyin': 'Weihui',
    'city_short': 'wh',
    'count': '1'
  },
  {
    'id': '9953',
    'city_name': '玉树',
    'city_pre': 'y',
    'city_pinyin': 'yushu',
    'city_short': 'ys',
    'count': '1'
  },
  {
    'id': '11695',
    'city_name': '舒兰',
    'city_pre': 'S',
    'city_pinyin': 'Shulan',
    'city_short': 'sl',
    'count': '1'
  },
  {
    'id': '11703',
    'city_name': '武夷山',
    'city_pre': 'W',
    'city_pinyin': 'Wuyishan',
    'city_short': 'wys',
    'count': '1'
  },
  {
    'id': '12272',
    'city_name': '石首',
    'city_pre': 'S',
    'city_pinyin': 'Shishou',
    'city_short': 'ds',
    'count': '1'
  }
]

Page({
  data: {
    citylist: [],
    navTop: 0, //侧边导航距离窗口顶部的距离,
    navItemHeight: 0, //侧边导航项的高度
    sections: [], //所有section，保存每个section的节点在文档的位置信息
    inNavbar: false, //手指是否在侧边导航，主要是区别后面wx.pageScrollTo触发的滚动还是直接触发的滚动
    searchValue: '', //查询值
    result: [] //城市查询结果列表
  },
  onLoad() {
    this.normalizeCityList(citys)
  },
  onReady() {
    const query = wx.createSelectorQuery()
    query.select('.citylist-nav').boundingClientRect();
    query.select('.citylist-nav-item').boundingClientRect();
    query.selectAll('.section').fields({
      dataset: true,
      size: true,
      rect: true
    });
    query.exec((res) => {
      let sections = []
      let Y = 0
      res[2].forEach(item => {
        sections.push({
          top: Y,
          height: item.height,
          title: item.dataset.title
        })
        Y += item.height
      })
      this.setData({
        navTop: res[0].top,
        navItemHeight: res[1].height,
        sections
      })
    })
  },
  onUnload(){
    wx.hideToast()
  },
  //页面滚动监听，使用函数节流优化
  onPageScroll: throttle(function(e){
    if (this.data.inNavbar || this.data.searchValue) {
      return //如果是侧边栏的wx.pageScrollTo触发的滚动则不执行下面的程序
    }
    const sections = this.data.sections
    const scrollTop = e.scrollTop
    this.handlePageScroll(sections, scrollTop)
  }),
  //页面滚动的处理程序
  handlePageScroll(sections, scrollTop) {
    for (let item of sections) {
      if (scrollTop >= item.top && scrollTop < item.top + item.height) {
        wx.showToast({
          title: item.title,
          icon: 'none',
          duration:500
        })
        break;
      }
    }
  },
  //处理API返回的城市列表数据
  normalizeCityList(citys) {
    let map = {}
    citys.forEach(item => {
      const key = item.city_pre.toUpperCase()
      //如果没有该字母索引，就创建该字母索引
      if (!map[key]) {
        map[key] = {
          title: key,
          items: []
        }
      }
      map[key].items.push(item)
    })
    let list = []
    for (let [index, value] of Object.entries(map)) {
      list.push(value)
    }
    //按字母顺序排序
    list.sort((a, b) => a.title.charCodeAt(0) - b.title.charCodeAt(0))
    //创建热门城市
    const hot = {
      title: '热门城市',
      index: '热门',
      style: 'inline',
      items: citys.slice(0, 10)
    }
    list.unshift(hot)
    //创建当前定位城市
    let current = {
      title: '当前定位城市',
      index: '定位',
      style: 'inline',
      items:[]
    };
    //判断是否获得用户定位城市
    if (app.globalData.userLocation.status===1){
      let city = citys.find(item => item.city_name === app.globalData.userLocation.cityName) || { city_name: '定位失败，请点击重试'}
      current.items = [city]
    } else {
      current.items = [{
        city_name:'定位失败，请点击重试'
      }]
    }
    list.unshift(current)
    this.setData({
      citylist: list
    })
  },
  //点击城市的事件处理程序
  selectCity(e) {
    const cityName = e.currentTarget.dataset.city.city_name
    const _this = this
    if (cityName ==='定位失败，请点击重试'){
      wx.showModal({
        title: '',
        content: '需要先授权定位才可获得您的位置信息',
        confirmText: "打开定位",
        success(res){
          if (res.confirm){
            wx.openSetting({
              success(data){
                if (data.authSetting['scope.userLocation']){
                  //app的globalData改变不能重新触发页面渲染？
                  app.initPage()
                }
              }
            })
          }
        }
      })
    } else {
      // wx.showModal({
      //   title: '提示',
      //   content: '没有获取猫眼城市ID的API，所以暂不支持切换城市',
      //   success(res) {
      //     if (res.confirm) {
      app.globalData.selectCity.cityName = cityName
      app.globalData.isRefresh = true
      wx.navigateBack({
        delta: 1
      })
      //     }
      //   }
      // })
    }
  },
  //侧边栏导航的点击事件处理
  navSelect(e) {
    const {
      citylist,
      sections
    } = this.data
    const index = e.currentTarget.dataset.index
    wx.showToast({
      icon: 'none',
      title: citylist[index].title
    })
    wx.pageScrollTo({
      scrollTop: sections[index].top,
      duration: 0
    })
  },
  //在侧边栏上滑动的事件处理,使用函数节流优化
  handleTouchmove: throttle(function(e){
    const {
      navTop,
      navItemHeight,
      citylist,
      sections
    } = this.data
    let index = Math.floor((e.changedTouches[0].clientY - navTop) / navItemHeight)
    if (index < 0 || index > citylist.length - 1) {
      return
    }
    wx.showToast({
      icon: 'none',
      title: citylist[index].title,
      duration: 500
    })
    wx.pageScrollTo({
      scrollTop: sections[index].top,
      duration: 0
    })
  }),
  //input框输入是的查询事件
  search(e) {
    const value = e.detail.value.trim().toUpperCase()
    let result = []
    if (value) {
      result = citys.filter(item => {
        if (value.length === 1 && value >= 'A' && value <= 'Z') {
          return value === item.city_pre.toUpperCase()
        }
        return item.city_name.includes(value) || item.city_pinyin.toUpperCase().includes(value) || item.city_short.toUpperCase().includes(value)
      })
    }
    this.setData({
      searchValue: value,
      result,
    })
  },
  //设置手指在侧边导航中
  handleTouchstart() {
    this.setData({
      inNavbar: true
    })
  },
  //设置手指离开侧边导航中
  handleTouchend() {
    this.setData({
      inNavbar: false
    })
  }
})