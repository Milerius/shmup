-- single enemy every two seconds

if not __state__ or __state__ ~= "running" then
    return
end

if SCORE <= 5 then return end

for _, corner in ipairs(corners) do
    createEnemy(corner)
end
