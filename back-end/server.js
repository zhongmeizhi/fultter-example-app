const Koa = require('koa');
const app = new Koa();

app.use(ctx => {
    ctx.response.body = {
        x: 'xxx'
    };
});

app.listen(2333, function() {
    console.log('开始')
});