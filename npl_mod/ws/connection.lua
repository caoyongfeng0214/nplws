NPL.load('common');
local connection = {};

connection._cnns = {};

function connection:new(o)
    o = o or {};
    local a = setmetatable(o, { __index = self });
    connection._cnns[o.nid or o.tid] = a;
    return a;
end;


function connection:on(evtName, fn)
    self['on' .. evtName] = fn;
end


function connection:recvMsg(msg)
    if(self.onmessage) then
        self:onmessage(msg[1]);
    end
end


connection.onRecvEventMsg = function(msg)
    local nid = msg.nid or msg.tid;
    if(nid) then
        local cn = connection._cnns[nid];
        if(cn) then
            if(msg.code == NPLReturnCode.NPL_ConnectionDisconnected) then
                if(cn.onclose) then
                    cn:onclose();
                end
            end
        end
    end
end;


local function activate()
    local nid = msg.nid or msg.tid;
    if(nid) then
        local cn = connection._cnns[nid];
        if(cn) then
            cn:recvMsg(msg);
        end
    end
end


NPL.this(activate);


return connection;