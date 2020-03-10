/*
备注
city: 城市（在程序载入时获取一次）
count: 返回结果数量
apiList: api列表
*/
// 静态资源地址
var staticUrl = 'https://static.sesine.com/wechat-weapp-movie'
// api地址
// var apiUrl = 'https://sesine.com/mina/api'
var apiUrl = 'https://api.douban.com/v2'
module.exports = {
    city: '',
    count: 10,
    baiduAK: 'Y1R5guY8Y2GNRdDpLz7SUeM3QgADAXec',
    apiList: {
      popular: apiUrl + '/movie/in_theaters?apikey=0df993c66c0c636e29ecbb5344252a4a',
      coming: apiUrl + '/movie/coming_soon?apikey=0df993c66c0c636e29ecbb5344252a4a',
      top: apiUrl + '/movie/top250?apikey=0df993c66c0c636e29ecbb5344252a4a',
      filmDetail: apiUrl + '/movie/subject/',
      weekly: apiUrl + '/movie/weekly?apikey=0df993c66c0c636e29ecbb5344252a4a'
    }
}
