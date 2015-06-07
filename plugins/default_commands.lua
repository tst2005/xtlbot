local print = print
local pairs = pairs

local commands = require("src.commands")
local core = require("src.core")
local users = require("src.users")

local plugin = {}

local function cmd_help(user, args)
    for name,command in pairs(commands.list()) do
        if users.has_role(user, command.role) then
            core.send("!" .. name .. " - " .. command.help)
        end
    end
end

local function cmd_ping(user, args)
    core.send_to_user(user.name, "pong!")
end

local function cmd_whoami(user, args)
    core.send_to_user(user.name, "You are a " .. user.role)
end

local function cmd_role(user, args)
    if #args ~= 2 then core.send_to_user(user.name, "!role <user> <role>") end

    local target = users.get(args[1])
    target.role = args[2]
    users.persist(target)
    core.send_to_user(user.name, "Set " .. target.name .. "'s role to " .. target.role)
    print(user.name .. " set " .. target.name .. "'s role to " .. target.role)
end

local function cmd_setmod(user, args)
    if #args ~= 1 then core.send_to_user(user.name, "!setmod <user>") end
    local target = args[1]
    core.send(".mod " .. target)
    core.send_to_user(user.name, "Set " .. target .. " as a twitch mod")
    print(user.name .. " set " .. target .. " as a twitch mod")
end

function plugin.init()
    commands.register("help", "displays the list of commands", cmd_help, "user")
    commands.register("ping", "pong", cmd_ping, "user")
    commands.register("whoami", "display your role", cmd_whoami, "user")
    commands.register("role", "set a user's role", cmd_role, "superadmin")
    commands.register("setmod", "set a user as a twitch mod", cmd_setmod, "superadmin")
end

return plugin