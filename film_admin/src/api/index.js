import ajax from './ajax'

//登录
export const login = (username,password)=>ajax('/admin/user/login',{username,password},'POST');
//获取管理员信息
// export const getAdminInfo = (adminId)=>ajax('/admin/user/getAdminInfo',{adminId});
//获取当前页电影
export const getCurrentPageMovie = (pageNum,limit,input)=>ajax('/admin/movie/getMovies',{pageNum,limit,input});
//上传文件到服务器
export const upLoadFile = (formData)=>ajax('/admin/movie/upLoadFile',formData,'POST');
//更新/添加电影信息
export const updateMovieInfo = (movie)=>ajax('/admin/movie/addMoive',{movie},'POST');
//删除电影信息
export const deleteMovieInfo = (movieId)=>ajax('/admin/movie/deleteMovie',{movieId},'POST');
//获取当前页用户评论
export const getComments = (pageNum,limit,keyword)=>ajax('/admin/comment/getComments',{pageNum,limit,keyword});
//通过当前评论
// export const passCurrentComment = (commentId,movieId)=>ajax('/api/admin/passCurrentComment',{commentId,movieId},'POST');
//删除当前评论
export const deleteComment = (commentId)=>ajax('/admin/comment/deleteComment',{commentId},'POST');
//获取当前页用户
export const getCurrentPageUser = (pageNum,limit,input)=>ajax('/admin/user/getUsers',{pageNum,limit,input});
//禁用/解禁用户
export const banUserById = (userId)=>ajax('/admin/user/banUser',{userId},'POST');
//删除用户信息
// export const deleteUserInfo = (userId)=>ajax('/api/admin/deleteUserInfo',{userId},'POST');
//更新用户信息
//export const updateUserInfo = (userId,userName,avatar,password,sex,phone,sign,birthday)=>ajax('/api/admin/updateUserInfo',{userId,userName,avatar,password,sex,phone,sign,birthday},'POST');
//添加用户信息
//export const addUserInfo = (userName,avatar,phone,password,sex,sign,birthday)=>ajax('/api/admin/addUserInfo',{userName,avatar,phone,password,sex,sign,birthday},'POST');
//获取当前页小吃
export const getSnacks = (pageNum,limit,keyword)=>ajax('/admin/snack/getSnacks',{pageNum,limit,keyword});
//编辑/添加小吃
export const updateSnackInfo = (snack)=>ajax('/admin/snack/addSnack',{snack},'POST');
//删除小吃
export const deleteSnackInfo = (snackId)=>ajax('/admin/snack/deleteSnack',{snackId},'POST');
//获取当前页订单
export const getCurrentPageOrder = (pageNum,limit,keyword)=>ajax('/admin/order/getOrders',{pageNum,limit,keyword});
//删除订单
export const deleteOrder = (orderId)=>ajax('/admin/order/deleteOrder',{orderId},'POST');
//获取当前页影院
export const getCurrentPageCinema = (pageNum,limit,keyword)=>ajax('/admin/cinema/getCinemas',{pageNum,limit,keyword});
//获取影院品牌列表
export const getBrandList = ()=>ajax('/admin/cinema/getBrandList',{});
//更新/添加影院信息
export const updateCinemaInfo = (cinema)=>ajax('/admin/cinema/addCinema',{cinema},'POST');
//删除影院信息
export const deleteCinemaInfo = (cinemaId)=>ajax('/admin/cinema/deleteCinema',{cinemaId},'POST');
//增加影院品牌
export const addCinemaBrand = (newBrand)=>ajax('/admin/cinema/addCinemaBrand',{newBrand},'POST');
//获取当前页影厅
export const getCurrentPageHall = (pageNum,limit,keyword)=>ajax('/admin/hall/getHalls',{pageNum,limit,keyword});
//获取Options
export const getOptions = ()=>ajax('/admin/hall/getOptions',{});
//更新影厅信息
export const updateHallInfo = (hallId,cinemaId,hallTypeId)=>ajax('/admin/hall/updateHall',{hallId,cinemaId,hallTypeId},'POST');
//删除影厅
export const deleteHall = (hallId)=>ajax('/admin/hall/deleteHall',{hallId},'POST');
//添加影厅
export const addHall = (cinemaId,halltypeId)=>ajax('/admin/hall/addHall',{cinemaId,halltypeId},'POST');
//获取影厅座位信息
export const getSeats = (hallId)=>ajax('/admin/hall/getSeatByHallId',{hallId});
//修改座位信息
export const commitSeat = (hallId,newSeat,changeSeat)=>ajax('/admin/hall/commitSeat',{hallId,newSeat,changeSeat},'POST');
//获取当前页排片
export const getCurrentPageMovieSchedule = (pageNum,limit,keyword)=>ajax('/admin/schedule/getMovieSchedule',{pageNum,limit,keyword});
//删除电影排片
export const deleteMovieSchedule = (timesId,daysId)=>ajax('/admin/schedule/deleteMovieSchedule',{timesId,daysId},'POST');
//获取所有电影和影院
export const getOptions2 = ()=>ajax('/admin/schedule/getOptions');
//获取所有影厅
export const getHallByCinemaId = (cinemaId)=>ajax('/admin/schedule/getHallByCinema',{cinemaId});
//添加排片信息
export const addScheduleInfo = (movieId,cinemaId,hallId,showDate,showTime,price)=>ajax('/admin/schedule/addScheduleInfo',{movieId,cinemaId,hallId,showDate,showTime,price},'POST');

//获取当前页广告
export const getBanner = (pageNum,limit,keyword)=>ajax('/admin/banner/getBanner',{pageNum,limit,keyword});
//更新/添加广告
export const updateBannerInfo = (banner)=>ajax('/admin/banner/addBanner',{banner},'POST');
//删除广告
export const deleteBannerInfo = (bannerId)=>ajax('/admin/banner/deleteBanner',{bannerId},'POST')

//获取当前页管理员
export const getCurrentPageAdmin = (pageNum,limit,keyword)=>ajax('/admin/auser/getAdmins',{pageNum,limit,keyword});
//获取Options
export const getOptions3 = ()=>ajax('/admin/auser/getOptions',{});
//修改管理员信息
export const updateAdminInfo = (userId,name,username,password,roleId,cineamId)=>ajax('/admin/auser/updateInfo',{userId,name,username,password,roleId,cineamId},'POST');

//商家=====================================================================================================================
//获取当前页影厅
export const getCurrentPageBHall = (pageNum,limit,keyword,cinemaId)=>ajax('/admin/hall/getHalls',{pageNum,limit,keyword,cinemaId});
//获取当前页排片
export const getCurrentPageBMovieSchedule = (pageNum,limit,keyword,cinemaId)=>ajax('/admin/schedule/getMovieSchedule',{pageNum,limit,keyword,cinemaId});
//获取当前页订单
export const getCurrentPageBOrder = (pageNum,limit,keyword,cinemaId)=>ajax('/admin/order/getOrders',{pageNum,limit,keyword,cinemaId});
//获取当前页小吃
export const getBSnacks = (pageNum,limit,keyword,cinemaId)=>ajax('/admin/snack/getSnacks',{pageNum,limit,keyword,cinemaId});
