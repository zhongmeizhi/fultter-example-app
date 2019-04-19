const Koa = require('koa');
const app = new Koa();

const router = require('./router.js');

app.use(ctx => {
    const _path = ctx.request.path;
    let _data = router[_path];
    if (_data) {
        console.log('获取:' + _path);
        ctx.response.body = {
            data: _data,
            status: 'success'
        };
    } else {
        ctx.response.body = {
            data: {},
            status: 'fail'
        };
    }
});

app.listen(2333, function() {
    console.log('---------------------------');
    console.log('运行');
    console.log('---------------------------');
});