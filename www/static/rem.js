/*(function (doc, win) {
    var docEl = doc.documentElement,size=750,
        resizeEvt = 'orientationchange' in window ? 'orientationchange' : 'resize',
        recalc = function () {
            var clientWidth = docEl.clientWidth;
            if (!clientWidth) return;
             docEl.style.fontSize = 90 * (clientWidth / size) + 'px';
//          if(clientWidth>=750){
//              docEl.style.fontSize = '100px';
//          }else{
//              docEl.style.fontSize = 100 * (clientWidth / size) + 'px';
//          }
       };
    if (!doc.addEventListener) return;
    win.addEventListener(resizeEvt, recalc, false);
    doc.addEventListener('DOMContentLoaded', recalc, false);
})(document, window);*/