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
          <el-button type="primary" size="small" @click="addMovie">添加小吃</el-button>
        </el-col>
      </div>
      <!--表格-->
      <div class="movie-table">
        <el-table
          border
          :data="tableData">
          <el-table-column
            label="小吃 ID"
            align="center"
            width="100"
            prop="id">
          </el-table-column>
          <el-table-column
            label="套餐名称"
            show-overflow-tooltip
            prop="firstTitle">
          </el-table-column>
          <el-table-column
            label="详细信息"
            show-overflow-tooltip
            prop="secondTitle">
          </el-table-column>
          <el-table-column
            label="价格"
            align="center"
            show-overflow-tooltip
            prop="price">
          </el-table-column>
          <el-table-column
            label="已购数量"
            prop="curNumber">
          </el-table-column>
          <el-table-column
            label="剩余数量"
            align="center"
            width="100"
            prop="totalNumber">
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
          <el-form :label-position="labelPosition" :rules="rules" label-width="80px" :model="snackInfo">
            <el-form-item label="小吃图片" prop="img">
              <el-col :span="16">
                <img :src="snackInfo.imageUrl" ref="previewImg" alt="" width="200px" height="200px">
                <div style="position: relative;height: 64px">
                  <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">点击上传</el-button>
                  <input type="file" id="file" name="file" ref="uploadImg" accept="image/png, image/jpeg, image/gif, image/jpg" style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer" @change="changeImg">
                  <div slot="tip" class="el-upload__tip" style="position: absolute;left: 0;top: 32px;height: 32px">只能上传jpg/png文件，且不超过500kb</div>
                </div>
              </el-col>
            </el-form-item>
            <el-form-item label="套餐名称" prop="firstTitle">
              <el-col :span="16">
                <el-input v-model="snackInfo.firstTitle"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="详细信息" prop="secondTitle">
              <el-col :span="16">
                <el-input v-model="snackInfo.secondTitle"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="价格" prop="price">
              <el-col :span="16">
                <el-input v-model="snackInfo.price"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="已购" prop="curNumber">
              <el-col :span="16">
                <el-input v-model="snackInfo.curNumber"></el-input>
              </el-col>
            </el-form-item>
            <el-form-item label="总数" prop="totalNumber">
              <el-col :span="16">
                <el-input v-model="snackInfo.totalNumber"></el-input>
              </el-col>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="cancel">取 消</el-button>
            <el-button type="primary" @click="manageSnackInfo()">确 定</el-button>
          </div>
        </el-dialog>
      </div>
    </div>
</template>

<script>
    import {getBSnacks,updateSnackInfo,upLoadFile,deleteSnackInfo,getOptions} from '../../../api/index'
    import {MessageBox,Message} from 'element-ui'
    import Vue from "vue";
    export default {
        name: "SnackManage",
        data() {
          return {
            tableData:[],
            total:0,
            currentPage:1,
            snackInfo: {},
            dialogFormVisible:false,
            dialogTitle:'',
            labelPosition:'right',
            input:'',
            searchInput:'',

            rules:{
                imageUrl: [
                    { required: true, message: '小吃图片不能为空', trigger: 'blur' },
                ],
                firstTitle: [
                    { required: true, message: '套餐名称不能为空',trigger: 'blur' },
                ],
                secondTitle: [
                    { required: true, message: '详细信息不能为空',trigger: 'blur' }
                ],
                price: [
                    { required: true, message: '价格不能为空',trigger: 'blur' }
                ],
                totalNumber: [
                    { required: true, message: '总数不能为空',trigger: 'blur' }
                ]
            }
          }
        },
        created(){
          this.loadCurrentPageSnack(this.currentPage,8,'');
        },
        methods: {
          async loadCurrentPageSnack(pageNum,limit,input){
            const cinemaId = this.$cookies.get("cinemaId");
            let json = await getBSnacks(pageNum,limit,input,cinemaId);
            if (json.state===200){
              this.tableData = json.data.beanList;
              this.total = json.data.tr;
            }
          },
          async currentChange(currentPage){
            this.currentPage = currentPage;
            this.loadCurrentPageSnack(this.currentPage,8,this.searchInput);
          },
          handleEdit(index, row) {
            this.dialogTitle = '编辑小吃信息';
            this.snackInfo = row;
            this.snackInfo.cinemaId = this.$cookies.get("cinemaId");
            this.dialogFormVisible = true;
            console.log(index, row);
          },
          async handleDelete(index, row) {
            MessageBox.confirm('此操作将永久删除该小吃信息, 是否继续？','提示').then(async (value)=>{
              if (value==='confirm'){
                let json = await deleteSnackInfo(row.id);
                if (json.state===200){
                  this.loadCurrentPageSnack(this.currentPage,8,this.searchInput);
                  Message.success('删除该小吃成功！');
                }
              }
            });
          },
          changeImg(e){
            let reader = new FileReader();
            console.log(this.$refs.uploadImg.files);
            reader.readAsDataURL(this.$refs.uploadImg.files[0]);
            let _this = this;
            reader.onload = function(){
              _this.$refs.previewImg.src = this.result;
              _this.snackInfo.imageUrl = this.result;
            }
          },
          //修改小吃信息
          async manageSnackInfo(){
            if (this.snackInfo.cinemaId&&this.snackInfo.imageUrl&&this.snackInfo.firstTitle&&this.snackInfo.secondTitle&&this.snackInfo.price&&this.snackInfo.totalNumber) {
                if(this.$refs.uploadImg.files[0]){
                    let formData = new FormData();
                    formData.append('img',this.$refs.uploadImg.files[0]);
                    let json = await upLoadFile(formData);
                    if (json.state===200){
                        if (json.data){
                            this.snackInfo.imageUrl = 'https://mokespace.cn/weimai/upFile/'+json.data.img;
                        }
                    }else{
                        Message.error(json.message);
                        return;
                    }
                }
                //判断是编辑还是添加
                if (this.dialogTitle === '编辑小吃信息') {
                  let json = await updateSnackInfo(this.snackInfo);
                  if (json.state===200){
                    this.dialogFormVisible = false;
                    Message.success('修改小吃信息成功！');
                  } else{
                    Message.error(json.message);
                  }
                } else{
                  let json = await updateSnackInfo(this.snackInfo);
                  if (json.state===200){
                    this.loadCurrentPageSnack(this.currentPage,8,this.searchInput);
                    this.dialogFormVisible = false;
                    Message.success('添加小吃成功！');
                  } else{
                    Message.error(json.message);
                  }
                }
            } else{
              Message.error('请完成必填内容！');
            }
          },
          //搜索小吃
          search(){
            this.searchInput = this.input;
            this.loadCurrentPageSnack(1,8,this.searchInput);
          },
          //添加小吃
          addMovie(){
            this.dialogTitle = '添加小吃';
            this.snackInfo = {};
            this.snackInfo.cinemaId = this.$cookies.get("cinemaId");
            this.dialogFormVisible = true;
          },
          cancel(){
            this.dialogFormVisible = false;
            this.loadCurrentPageSnack(this.currentPage,8,this.searchInput);
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
.upload-imgs li{position: relative;width: 150px;height: 90px;font-size: 14px;display: inline-block;margin-right: 25px;text-align: center;vertical-align: middle;}
.upload-imgs .img{position: relative;width: 94px;height: 94px;line-height: 94px;}
.upload-imgs .img img{vertical-align: middle;}
.upload-imgs .img .close{display: none;}
.upload-imgs li:hover .img .close{display: block;position: absolute;right: -50px;top: 5px;line-height: 1;font-size: 22px;color: #fff;}
</style>
