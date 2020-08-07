
return function(str)
    local symbols = 0
    for i = 1,#str do
        if not str:sub(i,i):match("[%s%w]") then
            symbols = symbols + 1
        end
    end

    return symbols / #str
end
