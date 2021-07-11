// ==UserScript==
// @name         夜景模式
// @namespace    http://via-app.cn
// @version      1.0.0
// @description  js脚本实现夜间模式，支持与系统深色模式联动
// @author       EricKwok，谷花泰
// @include      *
// @icon         https://www.google.com/s2/favicons?domain=via-app.cn
// @grant        none
// ==/UserScript==

function main() {
    const w = window;
    const key = encodeURIComponent('Safari_Yejing:执行判断');
    if (w[key]) {
        return;
    };
    w[key] = true;
    try {
        const script = document.createElement('script');
        script.src = 'https://cdn.jsdelivr.net/gh/the-eric-kwok/Safari_Yejing/野径云俱黑，江船火独明.js';
        script.defer = true;
        document.body.append(script);
        console.log('Safari_Yejing injected');
    } catch (err) {
        console.log('Safari_Yejing：', err);
    };
}
window.onload = main();