<template>
    <div id="movie-schedule">
      <!--搜索-->
      <div class="top">
        <el-col :span="12">
          <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="width: 100%">
            <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
          </el-input>
        </el-col>
        <el-col :span="2" :offset="1">
          <el-button type="primary" size="small" @click="addSchedule">安排电影</el-button>
        </el-col>
      </div>
      <!--表格-->
      <div class="schedule-table">
        <el-table
          border
          :data="tableData"
          style="width: 100%">
          <el-table-column
            label="排片 ID"
            align="center"
            width="100"
            prop="id">
          </el-table-column>
          <el-table-column
            label="电影名"
            show-overflow-tooltip
            prop="movieNm">
          </el-table-column>
          <el-table-column
            label="影院名"
            show-overflow-tooltip
            prop="cinemaNm">
          </el-table-column>
          <el-table-column
            label="放映大厅"
            prop="hallNm">
          </el-table-column>
          <el-table-column
            label="放映日期"
            prop="days.day">
          </el-table-column>
          <el-table-column
            label="放映时间"
            prop="time">
          </el-table-column>
          <el-table-column
            label="售价（元）"
            prop="price">
          </el-table-column>
          <el-table-column 
          width="100"
          align="center"
          label="操作">
            <template slot-scope="scope">
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row)">撤销</el-button>
            </template>
          </el-table-column>
        </el-table>
      </div>
      <!--分页-->
      <div class="block" v-if="tableData.length">
        <el-pagination
          @current-change="currentChange"
          background
          layout="prev, pager, next"
          :page-size="8"
          :page-count="total">
        </el-pagination>
      </div>
      <!--添加排片-->
      <div>
        <el-dialog
          title="添加排片"
          :visible.sync="addDialogFormVisible"
          :modal-append-to-body="false"
          v-if="addDialogFormVisible"
          :show-close="false"
        >
          <el-form :label-position="labelPosition" :rules="rules" label-width="80px" :model="scheduleInfo">
            <el-form-item label="电影名" prop="movieId">
              <el-col :span="12">
                <el-select v-model="scheduleInfo.movieId" placeholder="请选择" @change="changeMovie" style="width: 100%">
                  <el-option
                    v-for="item in movieOptions"
                    :key="item.id"
                    :label="item.nm"
                    :value="item.id">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="影院" prop="cinemaId">
              <el-col :span="12">
                <el-select v-model="scheduleInfo.cinemaId" placeholder="请选择" @change="changeCinema" style="width: 100%">
                  <el-option
                    v-for="item in cinemaOptions"
                    :key="item.id"
                    :label="item.nm"
                    :value="item.id"
                    >
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="影厅" prop="hallId">
              <el-col :span="12">
                <el-select v-model="scheduleInfo.hallId" placeholder="请选择" style="width: 100%">
                  <el-option
                    v-for="item in hallOptions"
                    :key="item.id"
                    :label="item.id+' 号厅'"
                    :value="item.id">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="上映日期" prop="public_date">
              <el-col :span="12">
                <el-date-picker
                  v-model="moviePublicDate"
                  type="date"
                  readonly
                  style="width: 100%"
                >
                </el-date-picker>
              </el-col>
            </el-form-item>
            <el-form-item label="放映日期" prop="movieShowDate">
              <el-col :span="12">
                <el-date-picker
                  v-model="scheduleInfo.movieShowDate"
                  type="date"
                  placeholder="选择日期"
                  :picker-options="datePickerOptions"
                  value-format="yyyy-MM-dd"
                  style="width: 100%"
                >
                </el-date-picker>
              </el-col>
            </el-form-item>
            <el-form-item label="放映时间" prop="movieShowTime">
              <el-col :span="12">
                <el-select v-model="scheduleInfo.movieShowTime" placeholder="请选择时间" style="width: 100%">
                  <i slot="prefix" class="el-input__icon el-icon-time"></i>
                  <el-option
                    v-for="item in timeOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="售价" prop="price">
              <el-col :span="12">
                <el-input v-model="scheduleInfo.price" style="width: 100%"></el-input>
              </el-col>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="addDialogFormVisible = false">取 消</el-button>
            <el-button type="primary" @click="addScheduleInfo">确 定</el-button>
          </div>
        </el-dialog>
      </div>
    </div>
</template>

<script>
    import {getCurrentPageMovieSchedule,getOptions2,getHallByCinemaId,addScheduleInfo,deleteMovieSchedule} from '../../../api/index'
    import {MessageBox,Message} from 'element-ui'
    export default {
        name: "MovieSchedule",
        data() {
          let checkPrice = (rule, value, callback) => {
            if (!value) {
              callback(new Error('售价不能为空'));
            } else {
              if (/((^[1-9]\d*)|^0)(\.\d{0,2}){0,1}$/.test(value)){
                callback();
              } else{
                callback(new Error('请输入正确格式的售价'));
              }
            }
          };
          return {
            tableData:[],
            total:0,
            currentPage:1,
            scheduleInfo:{},
            dialogFormVisible:false,
            addDialogFormVisible:false,
            dialogTitle:'',
            labelPosition:'right',
            input:'',
            searchInput:'',
            rules: {
              movieId: [
                { required: true, message: '电影名不能为空', trigger: 'change' },
              ],
              cinemaId: [
                { required: true, message: '影院名不能为空', trigger: 'change' },
              ],
              hallId: [
                { required: true, message: '影厅名不能为空', trigger: 'change' },
              ],
              movieShowDate: [
                { required: true, message: '放映日期不能为空', trigger: 'change' },
              ],
              movieShowTime: [
                { required: true, message: '放映时间不能为空', trigger: 'change' },
              ],
              price: [
                { required: true, message: '售价不能为空', trigger: 'blur' },
                { validator: checkPrice, trigger: 'blur' }
              ]
            },

            movieOptions: [],
            cinemaOptions: [],
            hallOptions: [],
            timeOptions:
            [
              {label:'08:05',value:'08:05'},
              {label:'09:05',value:'09:05'},
              {label:'10:05',value:'10:05'},
              {label:'11:05',value:'11:05'},
              {label:'12:05',value:'12:05'},
              {label:'14:05',value:'14:05'},
              {label:'16:05',value:'16:05'},
              {label:'20:05',value:'20:05'},
              {label:'21:05',value:'21:05'},
            ],

            moviePublicDate:'',

            datePickerOptions:{
              disabledDate: this.disabledDate
            }
          }
        },
        created(){
          this.loadCurrentPageMovieSchedule(this.currentPage,8,'');
        },
        methods: {
          async loadCurrentPageMovieSchedule(currentPage,pageSize,input){
            let json = await getCurrentPageMovieSchedule(currentPage,pageSize,input);
            if (json.state===200){
              this.tableData = json.data.beanList;
              this.total = json.data.tr;
            }
          },
          async currentChange(currentPage){
            this.currentPage = currentPage;
            this.loadCurrentPageMovieSchedule(this.currentPage,8,this.searchInput);
          },
          handleEdit(index, row) {
            console.log(index, row);
          },
          async handleDelete(index, row) {
            MessageBox.confirm('此操作将永久删除该电影排片所有信息, 是否继续？','提示').then(async (value)=>{
              if (value==='confirm'){
                let json = await deleteMovieSchedule(row.id,row.days.id);
                if (json.state===200){
                  Message.success('删除该电影排片成功！');
                  this.loadCurrentPageMovieSchedule(this.currentPage,8,this.searchInput);
                  console.log(this.tableData);
                }
              }
            });
          },
          //搜索电影
          search(){
            this.searchInput = this.input;
            this.loadCurrentPageMovieSchedule(1,8,this.searchInput);
          },
          //新增电影排片
          async addSchedule(){
            this.scheduleInfo = {};
            this.moviePublicDate = '';
            let json = await getOptions2();
            if (json.state===200){
              this.movieOptions = json.data.movies;
              this.cinemaOptions = json.data.cinemas;
            }
            this.addDialogFormVisible = true;
          },
          //选择影院
          async changeCinema(value){
            this.hallOptions = [];
            let json = await getHallByCinemaId(value);
            if (json.state===200){
              this.hallOptions = json.data;
            }
          },
          //选择电影
          changeMovie(value){
            if (value){
              this.movieOptions.forEach((val)=>{
                if (val.id===value){
                  this.moviePublicDate = val.rt;
                }
              })
            }
          },
          //限制可选日期
          disabledDate(time){
            if (this.scheduleInfo.movieId){
              if (new Date(this.moviePublicDate)-new Date()>0){
                return time.getTime() < new Date(this.moviePublicDate);
              } else{
                return time.getTime() < new Date()
              }
            } else{
              return time.getTime() > 0;
            }
          },
          async addScheduleInfo(){
            console.log(this.scheduleInfo);
            if (this.scheduleInfo.movieId&&this.scheduleInfo.cinemaId&&this.scheduleInfo.hallId
                &&this.scheduleInfo.movieShowDate&&this.scheduleInfo.movieShowTime&&this.scheduleInfo.price
                &&/((^[1-9]\d*)|^0)(\.\d{0,2}){0,1}$/.test(this.scheduleInfo.price)) {
              let json = await addScheduleInfo(this.scheduleInfo.movieId,this.scheduleInfo.cinemaId,this.scheduleInfo.hallId,this.scheduleInfo.movieShowDate,this.scheduleInfo.movieShowTime,this.scheduleInfo.price);
              if (json.state===200){
                Message.success('添加电影排片成功！');
                this.addDialogFormVisible = false;
                this.loadCurrentPageMovieSchedule(this.currentPage,8,this.searchInput);
              }
            } else{
              Message.error('请完成必填内容！');
            }
          }
        },
    }
</script>

<style>
  .schedule-table{
    width:90%;
    min-width:900px;
    margin: 0 auto;
    margin-bottom: 30px;
  }
  .top{
    display: flex;
    justify-content: center;
    align-items: center;
    /* padding: 30px 0; */
    margin-bottom: 30px;
  }
  .block{
    text-align: center;
  }
  .el-dialog__header{
    text-align: center;
  }
  .el-dialog__body .el-form-item{
    padding-left: 20%;
  }
</style>
