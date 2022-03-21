
------------------------------------------------VARIABLES---------------------------------------------------

local players = game:GetService("Players")
local player = players.LocalPlayer
local sg = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local UserInputService = game:GetService("UserInputService")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local button = Instance.new("TextButton")
local uc = Instance.new("UICorner")
local uc2 = Instance.new("UICorner")
local uc3 = Instance.new("UICorner")
local chests = workspace:WaitForChild("Chests")
local chestNames = {"Normal_Chest"};
local count = 0;
local gui = frame
local dragging
local dragInput
local dragStart
local startPos

------------------------------------------------PROPERTIES--------------------------------------------------

frame.Name = "Chest ESP"
frame.Parent = sg
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderColor3 = Color3.fromRGB(30, 30, 30)
frame.BorderSizePixel = 3
frame.Position = UDim2.new(0, 0, 0.600000024, 0)
frame.Size = UDim2.new(0.05, 0, 0.1, 0)
title.Name = "Title"
title.Parent = frame
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.BorderColor3 = Color3.fromRGB(27, 42, 53)
title.BorderSizePixel = 0
title.Size = UDim2.new(1, 0, 0.300000012, 0)
title.Font = Enum.Font.SourceSansBold
title.Text = "CHEST ESP"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextSize = 14.000
title.TextStrokeColor3 = Color3.fromRGB(30, 30, 30)
title.TextStrokeTransparency = 0.750
title.TextWrapped = true

button.Name = "Button"
button.Parent = frame
button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
button.BorderColor3 = Color3.fromRGB(30, 30, 30)
button.Position = UDim2.new(0.0500000007, 0, 0.370000005, 0)
button.Size = UDim2.new(0.899999976, 0, 0.569999933, 0)
button.Font = Enum.Font.SourceSansBold
button.Text = "OFF"
button.TextColor3 = Color3.fromRGB(255, 67, 67)
button.TextScaled = true
button.TextSize = 14.000
button.TextWrapped = true

uc.Parent = title
uc2.Parent = button
uc3.Parent = frame

sg.ResetOnSpawn = false

------------------------------------------------LOOPS & FUNCTIONS-------------------------------------------

for _, chest in pairs(chests:GetChildren()) do
    count = count + 1;
end
print("There are currently ".. count .. " chests in the server.");

local function gui(prnt)
    local part = Instance.new("Part", prnt);
    part.Size = prnt.Size - Vector3.new(0.5, 0.5, 0.5);
    part.Anchored = true;
    part.CanCollide = false;
    part.Transparency = 1;
    part.CFrame = prnt.CFrame;
    
    local bg = Instance.new("BillboardGui", part);
    
    bg.AlwaysOnTop = true;
    bg.Size = UDim2.new(0, 50, 0, 50);
    bg.StudsOffset = Vector3.new(0, 1, 0);
    
    local tl = Instance.new("TextLabel", bg);
    
    tl.BackgroundColor3 = Color3.new(0, 0, 0);
    tl.BackgroundTransparency = 1;
    tl.Size = UDim2.new(1, 0, 1, 0);
    tl.Text = "CHEST";
    tl.Font = "SourceSansBold";
    tl.TextColor3 = Color3.fromRGB(255, 238, 108);
    tl.TextScaled = true;
    tl.LineHeight = 3;
    tl.TextStrokeTransparency = 0.75;
    tl.TextStrokeColor3 = Color3.fromRGB(30, 30, 30); 

    for i = 1,6 do
        local sg = Instance.new("SurfaceGui", part);
        local fr = Instance.new("Frame", sg);
        
        sg.AlwaysOnTop = true;
        
        fr.BackgroundColor3 = Color3.fromRGB(255, 0, 0);
        fr.Size = UDim2.new(1, 0, 1, 0);
        
        if i == 1 then
            sg.Face = "Front";
        elseif i == 2 then
            sg.Face = "Back";
        elseif i == 3 then
            sg.Face = "Top";
        elseif i == 4 then
            sg.Face = "Bottom";
        elseif i == 5 then
            sg.Face = "Right";
        elseif i == 6 then
            sg.Face = "Left";
        end
    end
end

local on = false
button.MouseButton1Down:Connect(function()
    if on == false then
        on = true
        button.Text = "ON"
        button.TextColor3 = Color3.fromRGB(141, 255, 92)
        for _, chest in pairs(chests:GetChildren()) do
            gui(chest.Hitbox);
        end

    elseif on == true then
        on = false
        button.Text = "OFF"
        button.TextColor3 = Color3.fromRGB(255, 67, 67)
        for _, chest in pairs(chests:GetChildren()) do
            chest.Hitbox:ClearAllChildren()
        end
    end
end)

chests.ChildAdded:Connect(function(chest)
    if table.find(chestNames, chest.Name) and on == true then
        print("A chest has spawned!");
        task.wait();
        gui(chest.Hitbox);
    end

    local count = 0;
    for _, chest in pairs(chests:GetChildren()) do
        count = count + 1;
    end

    print("There are currently ".. count .. " chests in the server.");
end)

chests.ChildRemoved:Connect(function(chest)
    if table.find(chestNames, chest.Name) then
        print("A chest has been opened!");
    end
    
    local count = 0;
    for _, chest in pairs(chests:GetChildren()) do
        count = count + 1;
    end
    print("There are currently ".. count .. " chests in the server.");
end)
