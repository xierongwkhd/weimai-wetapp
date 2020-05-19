import Vue from 'vue'
import Router from 'vue-router'
import Login from '../pages/Login/Login'
import Home from '../pages/Home/Home'
import Business from '../pages/Business/Business'
import HallManage from '../pages/Home/children/HallManage'
import UserManage from '../pages/Home/children/UserManage'
import MovieManage from '../pages/Home/children/MovieManage'
import MovieSchedule from '../pages/Home/children/MovieSchedule'
import CinemaManage from '../pages/Home/children/CinemaManage'
import CommentManage from '../pages/Home/children/CommentManage'
import OrderManage from '../pages/Home/children/OrderManage'
import SnackManage from '../pages/Home/children/SnackManage'
import BannerManage from '../pages/Home/children/BannerManage'

import BOrderManage from '../pages/business/children/OrderManage'
import BSnackManage from '../pages/business/children/SnackManage'
import BMovieSchedule from '../pages/business/children/MovieSchedule'
import BHallManage from '../pages/business/children/HallManage'

Vue.use(Router);

export default new Router({
  routes: [
    {path:'/',redirect:'/login',},
    {
      path:'/login',
      name:'login',
      component:Login
    },
    {
      path: '/home',
      name: 'home',
      component: Home,
      children:[
        {path:'user_manage',component:UserManage},
        {path:'movie_manage',component:MovieManage},
        {path:'movie_schedule',component:MovieSchedule},
        {path:'cinema_manage',component:CinemaManage},
        {path:'hall_manage',component:HallManage},
        {path:'comment_manage',component:CommentManage},
        {path:'order_manage',component:OrderManage},
        {path:'snack_manage',component:SnackManage},
        {path:'/home',redirect: '/home/user_manage'},
        {path:'banner_manage',component:BannerManage}
      ]
    },
    {
      path: '/business',
      name: 'business',
      component: Business,
      children:[
        {path:'border_manage',component:BOrderManage},
        {path:'bhall_manage',component:BHallManage},
        {path:'bmovie_schedule',component:BMovieSchedule},
        {path:'bsnack_manage',component:BSnackManage},
        {path:'/business',redirect: '/business/border_manage'},
      ]
    }
  ]
})
