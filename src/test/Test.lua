package.path = package.path .. ";../?.lua"

local apiDummy = require("ApiDummy")

---@type lnxLib
local lnxLib = require("lnxLib.Main")
print("Testing lnxLib version: " .. lnxLib.GetVersion())

local function BeginSection(name)
    print(string.format("== %s ==", name))
end

local function PrintResult(name, success)
    if success then
        print(string.format("[+] %s", name))
    else
        print(string.format("[-] %s", name))
    end
end

local function Test(name, func)
    local success, err = pcall(func)
    PrintResult(name, success)

    if not success then
        print(err)
    end
end

--[[ Math Tests ]]
BeginSection("Math Tests")
local math = lnxLib.Utils.Math

-- Test NormalizeAngle
Test("NormalizeAngle does not change 180", function()
    local angle = math.NormalizeAngle(180)
    assert(angle == 180)
end)

-- Test RemapValClamped
Test("RemapValClamped maps 0 to 0", function()
    local remap = math.RemapValClamped(0, 0, 1, 0, 1)
    assert(remap == 0)
end)

-- Test PositionAngles
Test("PositionAngles between two 0 vectors is 0", function()
    local angles = math.PositionAngles(Vector3(0, 0, 0), Vector3(0, 0, 0))
    assert(angles == EulerAngles(0, 0, 0), string.format("Expected: %s, Got: %s", EulerAngles(0, 0, 0), angles))
end)

-- Test AngleFov
Test("AngleFov between the same vectors is 0", function()
    local fov = math.AngleFov(EulerAngles(0, 0, 0), EulerAngles(0, 0, 0))
    assert(fov == 0)
end)