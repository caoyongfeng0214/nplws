# nplws
websocket for npl

示例：

```
local express = NPL.load('express');
local ws = NPL.load('ws');

local app = express:new();
local server = app:listen(3000);

local WS = ws.Server:new({server = server});
WS:on('connection', function(w)
    w:on('message', function(w, msg)
        print('recevied a message: ', msg);
    end);
    w:on('close', function(w)
        print('websocked closed');
    end);
end);
```
