webpackJsonp([48],{kqLl:function(t,a,s){"use strict";Object.defineProperty(a,"__esModule",{value:!0});s("hUua");var e=s("5pFn"),i={name:"HelloWorld",data:function(){return{msg:"Welcome to Your Vue.js App",data:{}}},methods:{returns:function(){this.$router.push({path:"/class"})},getClassInfo:function(){var t=this;this.$http({url:this.$api.class.classIntro},{classesId:JSON.parse(localStorage.getItem("zhxy_user")).classesId}).then(function(a){if(console.log(a),0==a.code){for(var s in a.data.classIamge=t.$api.fileUrl+a.data.classIamge,a.data.imageUrl)a.data.imageUrl[s]=t.$api.fileUrl+a.data.imageUrl[s];for(var s in a.data.videoUrls)a.data.videoUrls[s]=t.$api.fileUrl+a.data.videoUrls[s];t.data=a.data}else t.$toast(a.msg)})},play:function(t){console.log(t),t.target.paused?t.target.play():t.target.pause()},show:function(t){Object(e.a)([t])}},created:function(){this.getClassInfo()}},l={render:function(){var t=this,a=t.$createElement,e=t._self._c||a;return e("div",[e("div",{staticClass:"loginNav"},[e("img",{staticClass:"return",attrs:{src:s("Du5+"),alt:""},on:{click:t.returns}}),t._v(" "),e("p",{staticClass:"title f30 cfff text-center"},[t._v("班级简介")]),t._v(" "),e("span",{staticClass:"f26 cfff pr-30",staticStyle:{position:"absolute",top:"0",right:"0","line-height":"0.84rem","z-index":"99"},on:{click:function(a){t.$router.push({path:"/editIntro"})}}},[t._v("编辑")])]),t._v(" "),e("div",{staticClass:"c333 f28",staticStyle:{padding:"0.84rem 0 1rem"}},[e("div",{staticClass:"nameBox"},[e("img",{attrs:{src:t.data.classIamge,alt:""}})]),t._v(" "),e("div",{staticClass:"content b_line"},[e("p",{staticClass:"subtitle"},[t._v("班级简介")]),t._v(" "),e("p",{staticClass:"c666"},[t._v(t._s(t.data.classDesc))])]),t._v(" "),e("div",{staticClass:"content"},[e("p",{staticClass:"subtitle"},[t._v("图片")]),t._v(" "),e("div",{staticClass:"picture"},t._l(t.data.imageUrl,function(a,s){return e("img",{key:s,attrs:{src:a,alt:""},on:{click:function(s){t.show(a)}}})})),t._v(" "),e("p",{staticClass:"subtitle"},[t._v("视频")]),t._v(" "),e("div",{staticClass:"picture"},t._l(t.data.videoUrls,function(a,s){return e("video",{key:s,attrs:{src:a,alt:""},on:{click:t.play}})}))])])])},staticRenderFns:[]};var c=s("C7Lr")(i,l,!1,function(t){s("qUm4")},"data-v-40066007",null);a.default=c.exports},qUm4:function(t,a){}});
//# sourceMappingURL=48.62f256f6af0fe454f8a3.js.map