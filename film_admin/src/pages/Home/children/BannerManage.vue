<template>
    <div id="movie-manage">
      <!--搜索-->
      <div class="top">
        <!-- <el-col :span="12">
          <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="width: 100%">
            <el-button slot="append" icon="el-icon-search" @click="search">搜索</el-button>
          </el-input>
        </el-col> -->
        <el-col :span="2" :offset="1" style="flex:auto;align-self:flex-start">
          <el-button type="primary" size="small" @click="addBanner">添加广告</el-button>
        </el-col>
      </div>
      <!--表格-->
      <div class="banner-table">
        <el-table
          border
          :data="tableData">
          <el-table-column
            label="广告 ID"
            align="center"
            width="100"
            prop="id">
          </el-table-column>
          <el-table-column
            label="图片 URL"
            show-overflow-tooltip
            prop="img">
          </el-table-column>
          <el-table-column
            label="跳转 URL"
            show-overflow-tooltip
            prop="url">
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
          <el-form :label-position="labelPosition" :rules="rules" label-width="80px" :model="bannerInfo">
            <el-form-item label="广告图片" prop="img">
              <el-col :span="16">
                <img :src="bannerInfo.img" ref="previewImg" alt="" width="375px" height="150px">
                <div style="position: relative;height: 64px">
                  <el-button size="small" type="primary" style="position: absolute;left: 0;top: 0;cursor: pointer">点击上传</el-button>
                  <input type="file" id="file" name="file" ref="uploadImg" accept="image/png, image/jpeg, image/gif, image/jpg" style="position: absolute;left: 0;top: 0;opacity: 0;height: 32px;width: 80px;cursor: pointer" @change="changeImg">
                  <div slot="tip" class="el-upload__tip" style="position: absolute;left: 0;top: 32px;height: 32px">只能上传jpg/png文件，且不超过500kb</div>
                </div>
              </el-col>
            </el-form-item>
            <el-form-item label="跳转 URL" prop="firstTitle">
              <el-col :span="16">
                <el-input v-model="bannerInfo.url"></el-input>
              </el-col>
            </el-form-item>
          </el-form>
          <div slot="footer" class="dialog-footer">
            <el-button @click="cancel">取 消</el-button>
            <el-button type="primary" @click="manageBannerInfo()">确 定</el-button>
          </div>
        </el-dialog>
      </div>
    </div>
</template>

<script>
    import {getBanner,updateBannerInfo,upLoadFile,deleteBannerInfo} from '../../../api/index'
    import {MessageBox,Message} from 'element-ui'
    import Vue from "vue";
    export default {
        name: "BannerManage",
        data() {
          return {
            tableData:[],
            total:0,
            currentPage:1,
            bannerInfo: {},
            dialogFormVisible:false,
            dialogTitle:'',
            labelPosition:'right',
            input:'',
            searchInput:'',

            rules:{
                img: [
                    { required: true, message: '广告图片不能为空', trigger: 'blur' },
                ]
            }
          }
        },
        created(){
          this.loadCurrentPageBanner(this.currentPage,8,'');
        },
        methods: {
          async loadCurrentPageBanner(pageNum,limit,input){
            let json = await getBanner(pageNum,limit,input);
            if (json.state===200){
              this.tableData = json.data.beanList;
              this.total = json.data.tr;
            }
          },
          async currentChange(currentPage){
            this.currentPage = currentPage;
            this.loadCurrentPageBanner(this.currentPage,8,this.searchInput);
          },
          handleEdit(index, row) {
            this.dialogTitle = '编辑广告信息';
            this.bannerInfo = row;
            this.dialogFormVisible = true;
            console.log(index, row);
          },
          async handleDelete(index, row) {
            MessageBox.confirm('此操作将永久删除该广告信息, 是否继续？','提示').then(async (value)=>{
              if (value==='confirm'){
                let json = await deleteBannerInfo(row.id);
                if (json.state===200){
                  this.loadCurrentPageBanner(this.currentPage,8,this.searchInput);
                  Message.success('删除该广告成功！');
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
              _this.bannerInfo.img = this.result;
            }
          },
          //修改小吃信息
          async manageBannerInfo(){
            if (this.bannerInfo.img) {
                if(this.$refs.uploadImg.files[0]){
                    let formData = new FormData();
                    formData.append('img',this.$refs.uploadImg.files[0]);
                    let json = await upLoadFile(formData);
                    if (json.state===200){
                        if (json.data){
                            this.bannerInfo.img = 'https://mokespace.cn/weimai/upFile/'+json.data.img;
                        }
                    }else{
                        Message.error(json.message);
                        return;
                    }
                }
                //判断是编辑还是添加
                if (this.dialogTitle === '编辑广告信息') {
                  let json = await updateBannerInfo(this.bannerInfo);
                  if (json.state===200){
                    this.dialogFormVisible = false;
                    Message.success('修改广告信息成功！');
                  } else{
                    Message.error(json.message);
                  }
                } else{
                  let json = await updateBannerInfo(this.bannerInfo);
                  if (json.state===200){
                    this.loadCurrentPageBanner(this.currentPage,8,this.searchInput);
                    this.dialogFormVisible = false;
                    Message.success('添加广告成功！');
                  } else{
                    Message.error(json.message);
                  }
                }
            } else{
              Message.error('请完成必填内容！');
            }
          },
          //添加广告
          addBanner(){
            this.dialogTitle = '添加广告';
            this.bannerInfo = {};
            this.dialogFormVisible = true;
          },
          cancel(){
            this.dialogFormVisible = false;
            this.loadCurrentPageBanner(this.currentPage,8,this.searchInput);
          }
        },
    }
</script>

<style>
  .banner-table{
    width:90%;
    min-width:900px;
    margin: 0 auto;
    margin-bottom: 30px;
  }
  .top{
    display: flex;
    justify-content: center;
    /* margin-left: auto; */
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

