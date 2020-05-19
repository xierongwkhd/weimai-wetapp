<template>
    <div id="movie-manage">
      <!--搜索-->
      <div class="top">
        <el-col :span="12">
          <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="width: 100%">
            <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
          </el-input>
        </el-col>
        <el-col :span="2" :offset="1">
          <el-button type="primary" size="small" @click="addMovie">添加电影</el-button>
        </el-col>
      </div>
      <!--表格-->
      <div class="movie-table">
        <el-table
          border
          :data="tableData">
          <el-table-column
            label="电影 ID"
            align="center"
            width="70"
            prop="id">
          </el-table-column>
          <el-table-column
            label="电影名"
            width="90"
            show-overflow-tooltip
            prop="nm">
          </el-table-column>
          <el-table-column
            label="英文名"
            show-overflow-tooltip
            prop="enm">
          </el-table-column>
          <el-table-column
            label="导演"
            align="center"
            show-overflow-tooltip
            prop="dir">
          </el-table-column>
          <el-table-column
            label="版本"
            width="90"
            prop="version">
          </el-table-column>
          <el-table-column
            label="类型"
            align="center"
            width="100"
            prop="cat">
          </el-table-column>
          <el-table-column
            label="上映时间"
            width="110"
            prop="rt">
          </el-table-column>
          <el-table-column
            label="想看人数"
            prop="wish">
          </el-table-column>
          <el-table-column
            label="观看人数"
            prop="watched">
          </el-table-column>
          <el-table-column
            label="状态"
            prop="showst"
            :formatter="formatShowst">
          </el-table-column>
          <el-table-column 
          width="200"
          align="center"
          label="操作">
            <template slot-scope="scope">
              <el-button
                size="mini"
                @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
              <el-button
                size="mini"
                type="danger"
                @click="handleDelete(scope.$index, scope.row)">删除</el-button>
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
      <!--弹框-->
      <div>
        <el-dialog
          :title="dialogTitle"
          :visible.sync="dialogFormVisible"
          :modal-append-to-body="false"
          v-if="dialogFormVisible"
          :showClose="false"
        >
          <el-form :label-position="labelPosition" :rules="rules" label-width="80px" :model="movieInfo">
            <el-form-item label="电影名" prop="nm">
              <el-col :span="16">
                <el-input v-model="movieInfo.nm"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="英文名" prop="enm">
              <el-col :span="16">
                <el-input v-model="movieInfo.enm"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="海报" prop="img">
              <el-col :span="16">
                <img :src="movieInfo.img" ref="previewImg" alt="" width="150px" height="200px">
                <div style="position: relative;height: 64px">
                  <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">点击上传</el-button>
                  <input type="file" id="file" name="file" ref="uploadImg" accept="image/png, image/jpeg, image/gif, image/jpg" style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer" @change="changeImg">
                  <div slot="tip" class="el-upload__tip" style="position: absolute;left: 0;top: 32px;height: 32px">只能上传jpg/png文件，且不超过500kb</div>
                </div>
              </el-col>
            </el-form-item>
            <el-form-item label="导演" prop="dir">
              <el-col :span="16">
                <el-input v-model="movieInfo.dir"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="演员" prop="star">
              <el-col :span="16">
                <el-input v-model="movieInfo.star"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="片长" prop="dur">
              <el-col :span="16">
                <el-input v-model="movieInfo.dur"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="语言" prop="language">
              <el-col :span="16">
                <el-select v-model="movieInfo.language" placeholder="请选择语言" style="width: 100%">
                  <el-option
                    v-for="item in languageOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="上映地区" prop="src">
              <el-col :span="16">
                <el-select v-model="movieInfo.src" placeholder="请选择地区" style="width: 100%">
                  <el-option
                    v-for="item in srcOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="类型" prop="cat">
              <el-col :span="16">
                <el-select v-model="movieInfo.cat" placeholder="请选择类型" style="width: 100%">
                  <el-option
                    v-for="item in typeOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="片源" prop="version">
              <el-col :span="16">
                <el-select v-model="movieInfo.version" placeholder="请选择类型" style="width: 100%">
                  <el-option
                    v-for="item in versionOptions"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>
            <el-form-item label="上映时间" prop="rt">
              <el-col :span="16">
                <el-date-picker type="date" placeholder="选择日期" v-model="movieInfo.rt" style="width: 100%;"></el-date-picker>
              </el-col>
            </el-form-item>
            <el-form-item label="简介" prop="dra">
              <el-col :span="16">
                <el-input type="textarea" v-model="movieInfo.dra" :autosize="{ minRows: 8, maxRows: 10}"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="状态" prop="showst">
              <el-col :span="16">
                <el-select v-model="movieInfo.showst" placeholder="请选择语言" style="width: 100%">
                  <el-option
                    v-for="item in movieShowst"
                    :key="item.value"
                    :label="item.label"
                    :value="item.value">
                  </el-option>
                </el-select>
              </el-col>
            </el-form-item>

            <el-form-item label="视频标题" prop="videoName">
              <el-col :span="16">
                <el-input v-model="movieInfo.videoName"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="视频图片" prop="videoImg">
              <el-col :span="16">
                <img :src="movieInfo.videoImg" ref="previewImg1" alt="" width="200px" height="120px">
                <div style="position: relative;height: 20px">
                  <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">点击上传</el-button>
                  <input type="file" id="file" name="file" ref="uploadImg1" accept="image/png, image/jpeg, image/gif, image/jpg" style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer" @change="changeImg1">
                </div>
              </el-col>
            </el-form-item>
            <el-form-item label="宣传视频" prop="videoUrl">
              <el-col :span="16">
                <video :src="movieInfo.videoUrl" ref="previewVideo" controls :poster="movieInfo.videoImg" width="300px" height="150px"></video>
                <div style="position: relative;height: 40px">
                  <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">点击上传</el-button>
                  <input type="file" id="file" name="file" ref="uploadVideo" accept="video/*" style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer" @change="changeVideo">
                </div>
              </el-col>
            </el-form-item>
            <el-form-item label="宣传海报" prop="photos">
              <el-row :span="16">
                <ul class="upload-imgs">
                  <li v-if="isNew" v-for='(value,index) in newPhotos'>
                    <p class="img"><img :src="value" width="150px" height="90px"><a class="close" @click="delImg2(index)">×</a></p>
                  </li>
                  <li v-if="!isNew"  v-for='(value,index) in movieInfo.photosList'>
                    <p class="img"><img :src="value" width="150px" height="90px"><a class="close" @click="delImg1(index)">×</a></p>
                  </li>
                </ul>
                <div style="position: relative;height: 20px">
                  <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">点击上传</el-button>
                  <input type="file" id="file" name="file" ref="uploadImgs" accept="image/png, image/jpeg, image/gif, image/jpg" style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer" @change="addImg">
                </div>
              </el-row>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="cancel">取 消</el-button>
            <el-button type="primary" @click="manageMovieInfo()">确 定</el-button>
          </div>
        </el-dialog>
      </div>

      <!-- loading -->
    <div>
      <el-dialog
        title="电影添加中..."
        :visible.sync="loadingDialogFormVisible"
        :modal-append-to-body="false"
        v-if="loadingDialogFormVisible"
        :show-close="false"
      >
        <div class='sk-fading-circle'>
          <div class='sk-circle sk-circle-1'></div>
          <div class='sk-circle sk-circle-2'></div>
          <div class='sk-circle sk-circle-3'></div>
          <div class='sk-circle sk-circle-4'></div>
          <div class='sk-circle sk-circle-5'></div>
          <div class='sk-circle sk-circle-6'></div>
          <div class='sk-circle sk-circle-7'></div>
          <div class='sk-circle sk-circle-8'></div>
          <div class='sk-circle sk-circle-9'></div>
          <div class='sk-circle sk-circle-10'></div>
          <div class='sk-circle sk-circle-11'></div>
          <div class='sk-circle sk-circle-12'></div>
        </div>
      </el-dialog>
    </div>
    </div>
</template>

<script>
    import {upLoadFile,getCurrentPageMovie,addMovieInfo,updateMovieInfo,deleteMovieInfo} from '../../../api/index'
    import {MessageBox,Message} from 'element-ui'
    import Vue from "vue";
    export default {
        name: "MovieManage",
        data() {
          return {
            //服务器地址
            server:'http://localhost:8080',
            tableData:[],
            total:0,
            currentPage:1,
            movieInfo:{},
            newPhotos:[],
            isNew: false,
            dialogFormVisible:false,
            dialogTitle:'',
            labelPosition:'right',
            input:'',
            searchInput:'',
            loadingDialogFormVisible:false,
            rules:{
              nm: [
                { required: true, message: '电影名不能为空', trigger: 'blur' },
              ],
              img: [
                { required: true, message: '请上传电影海报', trigger: 'blur' },
              ],
              dir: [
                { required: true, message: '导演信息不能为空', trigger: 'blur' },
              ],
              star: [
                { required: true, message: '主演信息不能为空', trigger: 'blur' },
              ],
              dur: [
                { required: true, message: '片长信息不能为空', trigger: 'blur' },
              ],
              language: [
                { required: true, message: '请选择语言', trigger: 'change' },
              ],
              cat: [
                { required: true, message: '请选择电影类型', trigger: 'change' },
              ],
              rt: [
                { required: true, message: '请选择上映日期', trigger: 'blur' },
              ],
              dra: [
                { required: true, message: '电影简介信息不能为空', trigger: 'blur' },
              ]
            },
            movieShowst:[{
              value: 1,
              label: '想看'
            },{
              value: 2,
              label: '预售'
            },{
              value: 3,
              label: '上映'
            }],
            srcOptions:[{
              value: '中国大陆',
              label: '中国大陆'
            },{
              value: '北美',
              label:'北美'
            }],
            languageOptions: [{
              value: '粤语',
              label: '粤语'
            }, {
              value: '国语',
              label: '国语'
            }, {
              value: '英语',
              label: '英语'
            }, {
              value: '日语',
              label: '日语'
            }, {
              value: '韩语',
              label: '韩语'
            }, {
              value: '其它',
              label: '其它'
            }],
            versionOptions: [{
              value: 'v2d imax',
              label: '2D、imax'
            },{
              value: 'v3d imax',
              label: '3D、imax'
            }],
            typeOptions: [{
              value: '动漫',
              label: '动漫'
            }, {
              value: '言情',
              label: '言情'
            }, {
              value: '科幻',
              label: '科幻'
            }, {
              value: '喜剧',
              label: '喜剧'
            }, {
              value: '爱情',
              label: '爱情'
            }, {
              value: '剧情',
              label: '剧情'
            }, {
              value: '动作',
              label: '动作'
            }, {
              value: '冒险',
              label: '冒险'
            }, {
              value: '青春',
              label: '青春'
            }, {
              value: '悬疑',
              label: '悬疑'
            }, {
              value: '恐怖',
              label: '恐怖'
            }, {
              value: '其它',
              label: '其它'
            }
            ],
            pickerPublicDate: {
              disabledDate(time) {
                return time.getTime() < Date.now();
              },
            }
          }
        },
        created(){
          this.loadCurrentPageMovie(this.currentPage,8,'');
        },
        methods: {
          async loadCurrentPageMovie(pageNum,limit,input){
            let json = await getCurrentPageMovie(pageNum,limit,input);
            if (json.state===200){
              this.tableData = json.data.beanList;
              console.log(this.tableData);
              this.total = json.data.tr;
            }
          },
          async currentChange(currentPage){
            this.currentPage = currentPage;
            this.loadCurrentPageMovie(this.currentPage,8,this.searchInput);
          },
          formatShowst(row, column, cellValue){
            var ret = ''  //你想在页面展示的值
            if (cellValue===1) {
              ret = "想看"  //根据自己的需求设定
            } else if(cellValue==2){
              ret = "预售"
            }else {
              ret = "上映"
            }
            return ret;
          },
          handleEdit(index, row) {
            this.dialogTitle = '编辑电影信息';
            this.movieInfo = row;
            this.isNew = false;
            this.dialogFormVisible = true;
            console.log(index, row);
          },
          async handleDelete(index, row) {
            console.log(index, row);
            MessageBox.confirm('此操作将永久删除该电影所有信息, 是否继续？','提示').then(async (value)=>{
              if (value==='confirm'){
                let json = await deleteMovieInfo(row.id);
                if (json.state===200){
                  this.loadCurrentPageMovie(this.currentPage,8,this.searchInput);
                  Message.success('删除该电影成功！');
                }
              }
            });
          },
          changeImg(e){
            let reader = new FileReader();
            console.log(this.$refs.uploadImg.files);
            reader.readAsDataURL(this.$refs.uploadImg.files[0]);//发起异步请求
            let _this = this;
            reader.onload = function(){
              //读取完成后，将结果赋值给img的src
              _this.$refs.previewImg.src = this.result;
              _this.movieInfo.img = this.result;
            }
          },
          changeImg1(e){
            let reader = new FileReader();
            console.log(this.$refs.uploadImg1.files);
            reader.readAsDataURL(this.$refs.uploadImg1.files[0]);//发起异步请求
            let _this = this;
            reader.onload = function(){
              //读取完成后，将结果赋值给img的src
              _this.$refs.previewImg1.src = this.result;
              _this.movieInfo.videoImg = this.result;
            }
          },
          changeVideo(e){
            let reader = new FileReader();
            console.log(this.$refs.uploadVideo.files);
            reader.readAsDataURL(this.$refs.uploadVideo.files[0]);//发起异步请求
            let _this = this;
            reader.onload = function(){
              //读取完成后，将结果赋值给img的src
              _this.$refs.previewVideo.src = this.result;
              _this.movieInfo.videoUrl = this.result;
            }
          },
          async addImg(e){
            let formData = new FormData();
            formData.append('img',this.$refs.uploadImgs.files[0]);
            let json = await upLoadFile(formData);
            if (json.state==200){
              // this.movieInfo.photosList.push("file:///E:/file/"+json.data.img);
              if (this.dialogTitle === '编辑电影信息') {
                this.movieInfo.photosList.push("https://mokespace.cn/weimai/upFile/"+json.data.img);
              } else{
                this.newPhotos.push("https://mokespace.cn/weimai/upFile/"+json.data.img);
              }
            }
            console.log(this.movieInfo)
            this.$refs.uploadImgs.files[0]==null;
          },
          delImg1(index){
            this.movieInfo.photosList.splice(index,1);
          },
          delImg2(index){
            this.movieInfo.newPhotos.splice(index,1);
          },
          //修改电影信息
          async manageMovieInfo(){
            if (this.movieInfo.nm&&this.movieInfo.img&&this.movieInfo.dir&&this.movieInfo.star&&this.movieInfo.dur&&this.movieInfo.cat&&this.movieInfo.language&&this.movieInfo.rt&&this.movieInfo.dra) {
              this.loadingDialogFormVisible  = true;
              //先上传文件获取url
              let formData = new FormData();
              formData.append('img',this.$refs.uploadImg.files[0]);
              formData.append('videoImg',this.$refs.uploadImg1.files[0]);
              formData.append('video',this.$refs.uploadVideo.files[0]);
              let json = await upLoadFile(formData);
              if (json.state===200){
                if (this.movieInfo.rt) {
                  let date = new Date(this.movieInfo.rt);
                  //this.movieInfo.rt = date.getFullYear()+'-'+(date.getMonth()+1)+'-'+date.getDate();
                  this.movieInfo.rt = date.getFullYear()+'-'+ (date.getMonth()+1>=10 ? (date.getMonth()+1) : '0'+(date.getMonth() + 1))+'-'+(date.getDate()>=10 ? date.getDate() : '0'+date.getDate());
                }
                if (json.data){
                  if(json.data.img)
                    this.movieInfo.img = 'https://mokespace.cn/weimai/upFile/'+json.data.img;
                  if(json.data.videoImg)
                    this.movieInfo.videoImg = 'https://mokespace.cn/weimai/upFile/'+json.data.videoImg;
                  if(json.data.video)
                    this.movieInfo.videoUrl = 'https://mokespace.cn/weimai/upFile/'+json.data.video;
                }
                //判断是编辑还是添加
                if (this.dialogTitle === '编辑电影信息') {
                  json = await updateMovieInfo(this.movieInfo);
                  if (json.state===200){
                    this.dialogFormVisible = false;
                    this.loadingDialogFormVisible  = false;
                    Message.success('修改电影信息成功！');
                  } else{
                    Message.error(json.message);
                  }
                } else{
                  this.movieInfo.photosList = this.newPhotos;
                  json = await updateMovieInfo(this.movieInfo);
                  if (json.state===200){
                    this.loadCurrentPageMovie(this.currentPage,8,this.searchInput);
                    this.dialogFormVisible = false;
                    this.loadingDialogFormVisible  = false;
                    this.newPhotos = [];
                    Message.success('添加电影成功！');
                  } else{
                    Message.error(json.message);
                  }
                }
              }
            } else{
              Message.error('请完成必填内容！');
            }
          },
          //搜索电影
          search(){
            this.searchInput = this.input;
            this.loadCurrentPageMovie(1,8,this.searchInput);
          },
          //添加电影
          addMovie(){
            this.dialogTitle = '添加电影';
            this.movieInfo = {};
            this.isNew = true;
            this.dialogFormVisible = true;
          },
          cancel(){
            this.dialogFormVisible = false;
            this.newPhotos = [];
            this.loadCurrentPageMovie(this.currentPage,8,this.searchInput);
          }
        },
    }
</script>

<style>
  .movie-table{
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
.upload-imgs{margin: 10px 0 30px 0;overflow: hidden;font-size: 0;}
.upload-imgs li{position: relative;width: 150px;height: 90px;font-size: 14px;display: inline-block;margin-right: 20px;margin-top: 10px;text-align: center;vertical-align: middle;}
.upload-imgs .img{position: relative;width: 94px;height: 94px;line-height: 94px;}
.upload-imgs .img img{vertical-align: middle;}
.upload-imgs .img .close{display: none;}
.upload-imgs li:hover .img .close{display: block;position: absolute;right: -50px;top: 5px;line-height: 1;font-size: 22px;color: #fff;}
.sk-fading-circle {
  width: 4em;
  height: 4em;
  position: relative;
  margin: auto;
}
.sk-fading-circle .sk-circle {
  width: 100%;
  height: 100%;
  position: absolute;
  left: 0;
  top: 0;
}
.sk-fading-circle .sk-circle:before {
  content: '';
  display: block;
  margin: 0 auto;
  width: 15%;
  height: 15%;
  background-color: #337ab7;
  border-radius: 100%;
  -webkit-animation: sk-fading-circle-delay 1.2s infinite ease-in-out both;
          animation: sk-fading-circle-delay 1.2s infinite ease-in-out both;
}
.sk-fading-circle .sk-circle-2 {
  -webkit-transform: rotate(30deg);
          transform: rotate(30deg);
}
.sk-fading-circle .sk-circle-3 {
  -webkit-transform: rotate(60deg);
          transform: rotate(60deg);
}
.sk-fading-circle .sk-circle-4 {
  -webkit-transform: rotate(90deg);
          transform: rotate(90deg);
}
.sk-fading-circle .sk-circle-5 {
  -webkit-transform: rotate(120deg);
          transform: rotate(120deg);
}
.sk-fading-circle .sk-circle-6 {
  -webkit-transform: rotate(150deg);
          transform: rotate(150deg);
}
.sk-fading-circle .sk-circle-7 {
  -webkit-transform: rotate(180deg);
          transform: rotate(180deg);
}
.sk-fading-circle .sk-circle-8 {
  -webkit-transform: rotate(210deg);
          transform: rotate(210deg);
}
.sk-fading-circle .sk-circle-9 {
  -webkit-transform: rotate(240deg);
          transform: rotate(240deg);
}
.sk-fading-circle .sk-circle-10 {
  -webkit-transform: rotate(270deg);
          transform: rotate(270deg);
}
.sk-fading-circle .sk-circle-11 {
  -webkit-transform: rotate(300deg);
          transform: rotate(300deg);
}
.sk-fading-circle .sk-circle-12 {
  -webkit-transform: rotate(330deg);
          transform: rotate(330deg);
}
.sk-fading-circle .sk-circle-2:before {
  -webkit-animation-delay: -1.1s;
          animation-delay: -1.1s;
}
.sk-fading-circle .sk-circle-3:before {
  -webkit-animation-delay: -1s;
          animation-delay: -1s;
}
.sk-fading-circle .sk-circle-4:before {
  -webkit-animation-delay: -0.9s;
          animation-delay: -0.9s;
}
.sk-fading-circle .sk-circle-5:before {
  -webkit-animation-delay: -0.8s;
          animation-delay: -0.8s;
}
.sk-fading-circle .sk-circle-6:before {
  -webkit-animation-delay: -0.7s;
          animation-delay: -0.7s;
}
.sk-fading-circle .sk-circle-7:before {
  -webkit-animation-delay: -0.6s;
          animation-delay: -0.6s;
}
.sk-fading-circle .sk-circle-8:before {
  -webkit-animation-delay: -0.5s;
          animation-delay: -0.5s;
}
.sk-fading-circle .sk-circle-9:before {
  -webkit-animation-delay: -0.4s;
          animation-delay: -0.4s;
}
.sk-fading-circle .sk-circle-10:before {
  -webkit-animation-delay: -0.3s;
          animation-delay: -0.3s;
}
.sk-fading-circle .sk-circle-11:before {
  -webkit-animation-delay: -0.2s;
          animation-delay: -0.2s;
}
.sk-fading-circle .sk-circle-12:before {
  -webkit-animation-delay: -0.1s;
          animation-delay: -0.1s;
}

@-webkit-keyframes sk-fading-circle-delay {
  0%, 39%, 100% {
    opacity: 0;
  }
  40% {
    opacity: 1;
  }
}

@keyframes sk-fading-circle-delay {
  0%, 39%, 100% {
    opacity: 0;
  }
  40% {
    opacity: 1;
  }
}
</style>
