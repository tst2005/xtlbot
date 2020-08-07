return function(str)
    local caps = 0
    for i = 1,#str do
        if str:sub(i,i):match("%u") then
            caps = caps + 1
        end
    end

    return caps / #str
end
