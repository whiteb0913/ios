webpackJsonp([19],{YReT:function(t,s,e){"use strict";Object.defineProperty(s,"__esModule",{value:!0});var i=e("CPGk"),a={name:"HelloWorld",data:function(){return{data:{createTime:"",images:[],praiseNum:0,replyCount:0,title:"",topicDesc:"",videos:[]},list:[],content:""}},filters:{fileTime:function(t){return i.a.dateFormat(t)}},methods:{returns:function(){this.$router.push({path:"/schoolcircle"})},deleteThis:function(){alert("删除")},approval:function(){this.$dialog.confirm({title:"提示",message:"是否同意该家长发布信息？",confirmButtonText:"同意",cancelButtonText:"不同意",className:"commentApproval"}).then(function(){}).catch(function(){})},wirteMessage:function(){this.show=!0},moreComment:function(){this.$router.push({path:"/morecomment",query:{id:this.$route.query.id,type:"school"}})},onConfirm:function(t,s){this.$toast("当前值："+t+", 当前索引："+s),this.modelShow=!this.modelShow,this.chooseClass=t},onCancel:function(t,s,e){this.modelShow=!this.modelShow},onConfirm1:function(t,s){this.$toast("当前值："+t+", 当前索引："+s),this.modelShow1=!this.modelShow1,this.chooseSubject=t},onCancel1:function(t,s,e){this.modelShow1=!this.modelShow1},tuenTOedit:function(){},selectClassesTopicDetails:function(){var t=this;this.$http({url:this.$api.class.selectSchoolTopicDetails},{schoolTopicId:this.$route.query.id}).then(function(s){console.log(s),0==s.code?t.data=s.data:t.$toast(s.msg)},function(s){t.$toast("出错了")})},getSchoolReply:function(){var t=this;this.$http({url:this.$api.class.getSchoolReply},{schoolTopicId:this.$route.query.id}).then(function(s){console.log(s),0==s.code?t.list=s.data:t.$toast(s.msg)},function(s){t.$toast("出错了")})},insertSchoolReply:function(){var t=this;if(""!=this.content){var s={content:this.content,topicId:this.$route.query.id,replyId:0,submitId:JSON.parse(localStorage.getItem("zhxy_user")).id,submitType:2};this.$http({url:this.$api.class.insertSchoolReply},s).then(function(s){console.log(s),0==s.code?(t.$toast("评论成功"),t.content="",t.getSchoolReply(),t.selectClassesTopicDetails()):t.$toast(s.msg)},function(s){t.$toast("出错了")})}else this.$toast("请输入回复内容")}},created:function(){this.selectClassesTopicDetails(),this.getSchoolReply()}},o={render:function(){var t=this,s=t.$createElement,i=t._self._c||s;return i("div",{staticStyle:{position:"absolute",top:"0",bottom:"0",left:"0",right:"0",overflow:"auto"}},[i("div",{staticClass:"loginNavFix"},[i("img",{staticClass:"return",attrs:{src:e("Du5+"),alt:""},on:{click:t.returns}}),t._v(" "),i("p",{staticClass:"title f30 cfff text-center"},[t._v("帖子详情")]),t._v(" "),1==t.$route.query.type&&1==t.$route.query.state?i("p",{staticClass:"navBtn f24 cfff pl-30",on:{click:t.approval}},[t._v("审核")]):t._e()]),t._v(" "),i("div",{staticClass:"setBox"},[i("div",{staticClass:"title-detail pl-30 f28 c333 pt-20 pb-30"},[t._v(t._s(t.data.title))]),t._v(" "),i("p",{staticClass:"f18 c999 pl-30"},[t._v(t._s(t._f("fileTime")(t.data.createTime,t.data.createTime)))]),t._v(" "),i("div",{staticClass:"borderBo c666 f26 pl-30 pt-40 pr-30 pb-40"},[t._v(t._s(t.data.topicDesc))]),t._v(" "),i("div",{staticClass:"upload"},[i("p",{staticClass:"pl-30 f28 c333 pt-20 pb-30"},[t._v("图片")]),t._v(" "),i("div",{staticClass:"iploadBox"},t._l(t.data.images,function(s,e){return i("div",{key:e,staticClass:"imgShowBox"},[i("div",{staticClass:"imgShow"},[i("img",{attrs:{src:t.$api.fileUrl+s,alt:""}})])])}))]),t._v(" "),i("div",{staticClass:"upload mt-30"},[i("p",{staticClass:"pl-30 f28 c333 pt-20 pb-30"},[t._v("视频")]),t._v(" "),i("div",{staticClass:"iploadBox"},t._l(t.data.videos,function(s,e){return i("div",{key:e,staticClass:"imgShowBox"},[i("div",{staticClass:"imgShow"},[i("video",{attrs:{src:t.$api.fileUrl+s,alt:""}})])])}))]),t._v(" "),1!=t.$route.query.type||1!=t.$route.query.state?i("div",{staticClass:"messageBtn"},[i("div",{staticClass:"teams"},[i("img",{attrs:{src:e("JODi"),alt:""}}),t._v(" "),i("p",[t._v(t._s(t.data.praiseNum))])]),t._v(" "),i("div",{staticClass:"teams",on:{click:t.wirteMessage}},[i("img",{attrs:{src:e("Nly6"),alt:""}}),t._v(" "),i("p",[t._v(t._s(t.data.replyCount))])])]):t._e(),t._v(" "),1!=t.$route.query.type||1!=t.$route.query.state?i("div",{staticClass:"comment"},[i("div",{staticClass:"shuxian l"}),t._v(" "),i("h2",{staticClass:"commTotle l"},[t._v("最新评论")]),t._v(" "),i("span",{staticClass:"commNum"},[t._v("("+t._s(t.list.length)+")")]),t._v(" "),i("div",{staticClass:"more r",on:{click:t.moreComment}},[i("p",[t._v("更多")]),t._v(" "),i("img",{attrs:{src:e("PkOM"),alt:""}})])]):t._e(),t._v(" "),1!=t.$route.query.type||1!=t.$route.query.state?i("div",{staticClass:"comm-for"},t._l(t.list,function(s,e){return i("div",{key:e,staticClass:"comm-list"},[i("img",{staticClass:"l",attrs:{src:t.$api.fileUrl+s.headImage,alt:""}}),t._v(" "),i("div",{staticClass:"comm-right l"},[i("div",{staticClass:"comm-title"},[i("div",{staticClass:"comm-name l"},[t._v(t._s(s.teacherName))]),t._v(" "),i("span",{staticClass:"r"},[t._v(t._s(t._f("fileTime")(s.create_time,s.create_time)))])]),t._v(" "),i("div",{staticClass:"comm-content"},[t._v(t._s(s.content)+"\n                    ")])])])})):t._e(),t._v(" "),i("div",{staticClass:"inputFixed"},[i("input",{directives:[{name:"model",rawName:"v-model",value:t.content,expression:"content"}],ref:"oinp",staticClass:"l",attrs:{type:"text"},domProps:{value:t.content},on:{input:function(s){s.target.composing||(t.content=s.target.value)}}}),t._v(" "),i("div",{staticClass:"l sendBtn",on:{click:t.insertSchoolReply}},[t._v("发送")])])])])},staticRenderFns:[]};var c=e("C7Lr")(a,o,!1,function(t){e("gjAC")},"data-v-f5223f48",null);s.default=c.exports},gjAC:function(t,s){}});
//# sourceMappingURL=19.e292566ba893cd776a67.js.map