webpackJsonp([38],{XaEU:function(t,s,e){"use strict";Object.defineProperty(s,"__esModule",{value:!0});var a=e("CPGk"),i={name:"HelloWorld",data:function(){return{columns:["全部科目","化学","英语","语文","数学","美术"],columnClass:["1111","2222","英语","语文","数学","美术"],show:!0,shows:!1,subject:!0,level:!0,modelShow:!1,modelShow2:!1,nowSbject:"全部科目",nowClass:"11111",idManage:!1,allChecked:!1,list:[]}},filters:{fileTime:function(t){return a.a.dateFormat(t)}},methods:{returns:function(){this.$router.push({path:"/indexs"})},linkTo:function(t){this.idManage?this.list[t].checked=!this.list[t].checked:this.$router.push({path:"/teachingresourcesdetail",query:{id:this.list[t].id}})},changeManage:function(){this.shows=!0,this.idManage=!this.idManage},closePop:function(){this.shows=!1,this.idManage=!this.idManage},next:function(){this.$router.push({path:"/setteachingresources"})},changeAllChecked:function(){if(this.allChecked=!this.allChecked,this.allChecked)for(var t in this.list)this.list[t].checked=!0;else for(var t in this.list)this.list[t].checked=!1},deleteFn:function(){var t=[];for(var s in this.list)this.list[s].checked&&t.push(this.list[s].id);alert(t.toString())},getAllResourceByTeacherId:function(){var t=this;this.$toast.loading({mask:!0,duration:0}),this.$http({url:this.$api.teachingresources.getAllResourceByTeacherId},{teacherId:JSON.parse(localStorage.getItem("zhxy_user")).id}).then(function(s){if(console.log(s),0==s.code){for(var e in s.data)s.data[e].checked=!1;t.list=s.data,t.$toast.clear()}else t.$toast(s.msg)},function(s){t.$toast.clear()})}},created:function(){this.getAllResourceByTeacherId()}},c={render:function(){var t=this,s=t.$createElement,a=t._self._c||s;return a("div",[a("div",{staticClass:"loginNavFix"},[a("img",{staticClass:"return",attrs:{src:e("Du5+"),alt:""},on:{click:t.returns}}),t._v(" "),a("p",{staticClass:"title f30 cfff text-center"},[t._v("教材资源")]),t._v(" "),t.idManage?a("p",{staticClass:"navBtn f24 cfff pl-30",on:{click:t.changeManage}},[t._v("取消")]):a("p",{staticClass:"navBtn f24 cfff pl-30",on:{click:t.changeManage}},[t._v("管理")])]),t._v(" "),a("div",{staticClass:"item-for"},t._l(t.list,function(s,i){return a("div",{key:i,staticClass:"item-list pr-30",on:{click:function(s){t.linkTo(i)}}},[a("div",{staticClass:"cc3 home-lin2"},[t.idManage?a("div",[s.checked?a("img",{staticClass:"checked",attrs:{src:e("6/Ch"),alt:""}}):a("img",{staticClass:"noChecked",attrs:{src:e("cd4R"),alt:""}})]):t._e(),t._v(" "),a("p",{staticClass:"item-con c000 f30"},[t._v(t._s(s.title))]),t._v(" "),a("span",{staticClass:"item-time f24"},[t._v(t._s(t._f("fileTime")(s.create_time,s.create_time)))])])])})),t._v(" "),t.idManage?a("div",{staticClass:"deleteBo"},[a("div",{staticClass:"allBtn",on:{click:t.changeAllChecked}},[t.allChecked?a("img",{staticClass:"allCheckedCanleNo",attrs:{src:e("6/Ch"),alt:""}}):a("img",{staticClass:"allCheckedCanle ml-28 mr-30",attrs:{src:e("cd4R"),alt:""}}),t._v(" "),a("div",{staticClass:"allText f26 c000"},[t._v("全选")])]),t._v(" "),a("div",{staticClass:"deleteBtn f28 cfff",on:{click:t.deleteFn}},[t._v("删除")])]):a("div",{staticClass:"centerBtn f26 cfff text-center",on:{click:t.next}},[t._v("新增文章")]),t._v(" "),a("van-popup",{staticClass:"vantPop",attrs:{position:"right"},model:{value:t.shows,callback:function(s){t.shows=s},expression:"shows"}},[a("div",{staticClass:"loginNavFix"},[a("img",{staticClass:"return",attrs:{src:e("Du5+"),alt:""},on:{click:t.closePop}}),t._v(" "),a("p",{staticClass:"title f30 cfff text-center"},[t._v("教材资源")]),t._v(" "),a("p",{staticClass:"navBtn f24 cfff pl-30",on:{click:t.closePop}},[t._v("取消")])]),t._v(" "),a("div",{staticClass:"item-for"},t._l(t.list,function(s,i){return a("div",{key:i,staticClass:"item-list pr-30",on:{click:function(s){t.linkTo(i)}}},[a("div",{staticClass:"cc3 home-lin2"},[a("div",[s.checked?a("img",{staticClass:"checked",attrs:{src:e("6/Ch"),alt:""}}):a("img",{staticClass:"noChecked",attrs:{src:e("cd4R"),alt:""}})]),t._v(" "),a("p",{staticClass:"item-con c000 f30"},[t._v(t._s(s.title))]),t._v(" "),a("span",{staticClass:"item-time f24"},[t._v(t._s(t._f("fileTime")(s.create_time,s.create_time)))])])])})),t._v(" "),a("div",{staticClass:"deleteBo"},[a("div",{staticClass:"allBtn",on:{click:t.changeAllChecked}},[t.allChecked?a("img",{staticClass:"allCheckedCanleNo",attrs:{src:e("6/Ch"),alt:""}}):a("img",{staticClass:"allCheckedCanle ml-28 mr-30",attrs:{src:e("cd4R"),alt:""}}),t._v(" "),a("div",{staticClass:"allText f26 c000"},[t._v("全选")])]),t._v(" "),a("div",{staticClass:"deleteBtn f28 cfff",on:{click:t.deleteFn}},[t._v("删除")])])])],1)},staticRenderFns:[]};var l=e("C7Lr")(i,c,!1,function(t){e("an5D")},"data-v-55781db1",null);s.default=l.exports},an5D:function(t,s){}});
//# sourceMappingURL=38.ccdaac073f04e55f358c.js.map