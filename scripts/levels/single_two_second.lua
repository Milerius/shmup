-- single enemy every two seconds

if not __state__ or __state__ ~= "running" then
    return
end

if SCORE > 5 then return end

createEnemy(corners[math.random(#corners)])
