var douban = require('../../locale/fetch.js')
var config = require('../../locale/config.js')
Page({
	data: {
		films: [],
		hasMore: true,
		start: 0
	},
	onLoad: function() {
		var that = this
		// douban.fetchFilms.call(that, config.apiList.top, that.data.start)
    douban.fetchFilms.call(that, config.apiList.weekly)
	},
	onPullDownRefresh: function() {
		var that = this
    wx.showLoading({
      title: '加载中...',
    })
		that.setData({
			films: [],
			hasMore: true,
			start: 0
		})
    douban.fetchFilms.call(that, config.apiList.weekly)
    wx.hideLoading();
	},
	onReachBottom: function() {
		// var that = this
    // if (that.data.hasMore) {
		// 	douban.fetchFilms.call(that, config.apiList.top, that.data.start)
		// }
	},
	viewFilmDetail: function(e) {
		var data = e.currentTarget.dataset;
		wx.navigateTo({
			url: "/pages/subPages/filmDetail/filmDetail?id=" + data.id
		})
	}
})