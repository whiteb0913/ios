webpackJsonp([57],{cLqO:function(t,e,i){"use strict";Object.defineProperty(e,"__esModule",{value:!0});var a={name:"HelloWorld",data:function(){return{msg:"Welcome to Your Vue.js App",active1:!0,active:0,activeDown:0,show:!1,show1:!1,allChecked:!1,list:[1,1,1,1,1,1,1,1,1,11,1,1,1,1,1,1,1,1,1,11],list1:[],list2:[],list3:[],list4:[],list5:[],btnHtml:""}},methods:{returns:function(){this.$router.go(-1)},yes:function(){this.active1=!0,this.allChecked=!1,this.getBannerByTypeAndState()},no:function(){this.active1=!1,this.allChecked=!1,this.getBannerByTypeAndState()},returnClose:function(){this.show1=!1},lookDetail:function(t){var e=this.list;e[t].isSee=!0,this.list=e,this.$router.push({path:"/leaveDetail",query:{active:this.active2}})},more:function(){this.show=!this.show},onClick:function(){this.allChecked=!1,this.getBannerByTypeAndState()},getBannerByTypeAndState:function(){var t=this;this.$toast.loading({mask:!0,duration:0});var e={classesId:JSON.parse(localStorage.getItem("zhxy_user")).classesId};this.active1&&0==this.active?(e.type=1,e.state=3):this.active1&&1==this.active?(e.type=1,e.state=2):this.active1&&2==this.active?(e.type=1,e.state=1):this.active1||0!=this.active?this.active1||1!=this.active?this.active1&&2==this.active&&(e.type=2,e.state=1):(e.type=2,e.state=2):(e.type=2,e.state=3),this.$http({url:this.$api.class.getBannerByTypeAndState},e).then(function(e){if(console.log(e),0==e.code){for(var i in e.data)e.data[i].checked=!1;t.active1&&0==t.active?t.list=e.data:t.active1&&1==t.active?t.list1=e.data:t.active1&&2==t.active?t.list2=e.data:t.active1||0!=t.active?t.active1||1!=t.active?t.active1&&2==t.active&&(t.list5=e.data):t.list4=e.data:t.list3=e.data,t.$toast.clear()}else t.$toast(e.msg)},function(e){t.$toast("出错了")})},changeAllChecked:function(){},deleteFn:function(){}},created:function(){1==this.$route.query.type?(this.active1=!1,this.btnHtml="发布"):2==this.$route.query.type?this.btnHtml="下架":this.btnHtml="删除",this.getBannerByTypeAndState(1,3)}},s={render:function(){var t=this,e=t.$createElement,a=t._self._c||e;return a("div",[a("div",{staticClass:"loginNav"},[a("img",{staticClass:"return",attrs:{src:i("Du5+"),alt:""},on:{click:t.returns}}),t._v(" "),a("p",{staticClass:"title f30 cfff text-center"},[t._v("班牌首页轮播图设置")])]),t._v(" "),a("div",{staticClass:"f28 c333",staticStyle:{padding:"0.84rem 0 1.7rem"}},[3==t.$route.query.type?a("div",{staticClass:"tap f28"},[a("button",{class:t.active1?"bg_6b7":"b7f",on:{click:t.yes}},[t._v("已上架")]),t._v(" "),a("button",{class:t.active1?"b7f":"bg_6b7",on:{click:t.no}},[t._v("未上架")])]):t._e(),t._v(" "),t.active1?a("div",{staticClass:"pl-30 pr-30"},[a("van-tabs",{attrs:{color:"#6B77FF"},on:{click:t.onClick},model:{value:t.active,callback:function(e){t.active=e},expression:"active"}},[a("van-tab",{attrs:{title:"班级风采"}},[a("ul",{staticClass:"content"},t._l(t.list,function(e,s){return a("li",{key:s,staticClass:"b_line pr-30",on:{click:function(t){e.checked=!e.checked}}},[e.checked?a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("JG3o"),alt:""}}):a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("iLaJ"),alt:""}}),t._v(" "),a("img",{attrs:{src:t.$api.fileUrl+e.image}}),t._v(" "),a("span",[t._v(t._s(e.title))])])}))]),t._v(" "),a("van-tab",{attrs:{title:"班级荣誉"}},[a("ul",{staticClass:"content"},t._l(t.list1,function(e,s){return a("li",{key:s,staticClass:"b_line pr-30",on:{click:function(t){e.checked=!e.checked}}},[e.checked?a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("JG3o"),alt:""}}):a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("iLaJ"),alt:""}}),t._v(" "),a("img",{attrs:{src:t.$api.fileUrl+e.image}}),t._v(" "),a("span",[t._v(t._s(e.title))])])}))]),t._v(" "),a("van-tab",{attrs:{title:"班级简介"}},[a("ul",{staticClass:"content"},t._l(t.list2,function(e,s){return a("li",{key:s,staticClass:"b_line pr-30",on:{click:function(t){e.checked=!e.checked}}},[e.checked?a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("JG3o"),alt:""}}):a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("iLaJ"),alt:""}}),t._v(" "),a("img",{attrs:{src:t.$api.fileUrl+e.image}}),t._v(" "),a("span",[t._v(t._s(e.title))])])}))])],1)],1):a("div",{staticClass:"pl-30 pr-30"},[a("van-tabs",{attrs:{color:"#6B77FF"},on:{click:t.onClick},model:{value:t.activeDown,callback:function(e){t.activeDown=e},expression:"activeDown"}},[a("van-tab",{attrs:{title:"班级风采"}},[a("ul",{staticClass:"content"},t._l(t.list3,function(e,s){return a("li",{key:s,staticClass:"b_line pr-30",on:{click:function(t){e.checked=!e.checked}}},[e.checked?a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("JG3o"),alt:""}}):a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("iLaJ"),alt:""}}),t._v(" "),a("img",{attrs:{src:t.$api.fileUrl+e.image}}),t._v(" "),a("span",[t._v(t._s(e.title))])])}))]),t._v(" "),a("van-tab",{attrs:{title:"班级荣誉"}},[a("ul",{staticClass:"content"},t._l(t.list4,function(e,s){return a("li",{key:s,staticClass:"b_line pr-30",on:{click:function(t){e.checked=!e.checked}}},[e.checked?a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("JG3o"),alt:""}}):a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("iLaJ"),alt:""}}),t._v(" "),a("img",{attrs:{src:t.$api.fileUrl+e.image}}),t._v(" "),a("span",[t._v(t._s(e.title))])])}))]),t._v(" "),a("van-tab",{attrs:{title:"班级简介"}},[a("ul",{staticClass:"content"},t._l(t.list5,function(e,s){return a("li",{key:s,staticClass:"b_line pr-30",on:{click:function(t){e.checked=!e.checked}}},[e.checked?a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("JG3o"),alt:""}}):a("img",{staticStyle:{width:"0.4rem",height:"0.4rem",display:"inline-block"},attrs:{src:i("iLaJ"),alt:""}}),t._v(" "),a("img",{attrs:{src:t.$api.fileUrl+e.image}}),t._v(" "),a("span",[t._v(t._s(e.title))])])}))])],1)],1),t._v(" "),a("div",{staticClass:"deleteBo"},[a("div",{staticClass:"allBtn",on:{click:t.changeAllChecked}},[t.allChecked?a("img",{staticClass:"allCheckedCanleNo",attrs:{src:i("6/Ch"),alt:""}}):a("img",{staticClass:"allCheckedCanle ml-28 mr-30",attrs:{src:i("cd4R"),alt:""}}),t._v(" "),a("div",{staticClass:"allText f26 c000"},[t._v("全选")])]),t._v(" "),a("div",{staticClass:"deleteBtn f28 cfff",on:{click:t.deleteFn}},[t._v(t._s(t.btnHtml))])]),t._v(" "),a("van-popup",{staticClass:"bannerSet",attrs:{position:"bottom",overlay:!0},model:{value:t.show,callback:function(e){t.show=e},expression:"show"}},[a("div",[a("p",{staticClass:"b_line"},[t._v("发 布")]),t._v(" "),a("p",{staticClass:"b_line"},[t._v("下 架")]),t._v(" "),a("p",[t._v("删 除")])]),t._v(" "),a("p",{on:{click:function(e){t.show=!1}}},[t._v("取 消")])])],1)])},staticRenderFns:[]};var c=i("C7Lr")(a,s,!1,function(t){i("zFn2")},"data-v-2bae8a5e",null);e.default=c.exports},zFn2:function(t,e){}});
//# sourceMappingURL=57.5240d5a5825d8d743f57.js.map