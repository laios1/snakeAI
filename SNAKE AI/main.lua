io.stdout:setvbuf('no')
require('FuGrEtTa')
math.randomseed(os.time())
colonne = 25
ligne = 25
love.window.setMode(600,600)
mode = "d"
w = 600 / ligne
h = 600 / colonne
taille = 4
tailleI = taille
t = 0
food = {} 
movet = {}
lesMurs = {}
  food.x = math.random(1,ligne)
  food.y = math.random(1,colonne)
  function food.show()
    love.graphics.setColor(1,0,0,1)
    love.graphics.rectangle("fill",(food.x-1)*w,(food.y-1)*h,w,h)
  end
  
RunGame = true


function snake(list)
  list.corps = {}
  list.corps[#list.corps+1] = {1,1}
  list.gotou = {}
  list.last = {}
  list.last2 = {}
  function list.update()
    if #list.corps > taille then
      list.last2 = assingTable(list.last)
      list.last = list.corps[1]
      table.remove(list.corps,1)
    end
  end
  


  function list.show() 
    for i = 1,#list.corps do
      
      love.graphics.setColor(i/(#list.corps*2)+0.5,0,i/(#list.corps*2)+0.5,1)
      --love.graphics.setColor(hsl_to_rgb(i/#list.corps*360,100,50))
      
      love.graphics.rectangle("fill",(list.corps[i][1]-1)*w,(list.corps[i][2]-1)*h,w,h)
      
      
      --love.graphics.setColor(1,1,1,1)
      --love.graphics.rectangle("line",(list.corps[i][1]-1)*w,(list.corps[i][2]-1)*h,w,h)
    end
--    love.graphics.setColor(0,1,0)
--    for i = 2,#list.corps-1 do
--      print(i, -0.5*(list.corps[i][1]-list.corps[i-1][1]-1)*(list.corps[i][1]-list.corps[i-1][1])^2, (list.corps[i][2]-list.corps[i-1][2])^2)
--      print(i, -0.5*(list.corps[i][2]-list.corps[i-1][2]-1)*(list.corps[i][2]-list.corps[i-1][2])^2, (list.corps[i][1]-list.corps[i-1][1])^2)
--      love.graphics.line(-0.5*(list.corps[i][1]-list.corps[i-1][1]-1)*(list.corps[i][1]-list.corps[i-1][1])^2*w + (list.corps[i][1]-1)*w,
--                         -0.5*(list.corps[i][2]-list.corps[i-1][2]-1)*(list.corps[i][2]-list.corps[i-1][2])^2*h + (list.corps[i][2]-1)*h, 

--                        -0.5*(list.corps[i][1]-list.corps[i-1][1]-1)*(list.corps[i][1]-list.corps[i-1][1])^2*w + 
--                                                                                (list.corps[i][2]-list.corps[i-1][2])^2*w + (list.corps[i][1]-1)*w,
--                        -0.5*(list.corps[i][2]-list.corps[i-1][2]-1)*(list.corps[i][2]-list.corps[i-1][2])^2*h + 
--                                                                                (list.corps[i][1]-list.corps[i-1][1])^2*h + (list.corps[i][2]-1)*h)
--    end
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle("fill",(list.corps[#list.corps][1]-1)*w,(list.corps[#list.corps][2]-1)*h,w,h)
  end
  
  function list.food()
    if list.corps[#list.corps][1] == food.x and list.corps[#list.corps][2] == food.y then
      taille = taille+1
      local testFood = true
      while testFood do
        testFood = false
        food.x = math.random(1,ligne)
        food.y = math.random(1,colonne)
        for i = 1,#list.corps do
          if list.corps[i][1] == food.x and list.corps[i][2] == food.y then
            testFood = true
          end
        end
      end
      
    end
  end
  
  
  function list.loose()
    if list.corps[#list.corps][1] > ligne then 
      RunGame = false
    elseif list.corps[#list.corps][1] <= 0 then 
      RunGame = false
    end
    if list.corps[#list.corps][2] > colonne then 
      RunGame = false
    elseif list.corps[#list.corps][2] <= 0 then 
      RunGame = false
    end
    for i = 1,#list.corps-1 do
      if list.corps[#list.corps][1] == list.corps[i][1] and list.corps[#list.corps][2] == list.corps[i][2]  then
        RunGame = false
      end
    end
  end
end


  

serpent = {}
snake(serpent)

function love.draw()
  
  
  food.show()
  serpent.show()
  
end


function love.update(dt)
  if RunGame then
    t = t + dt
    if t > 0.01  then
      serpent.food()
      move()
      serpent.update()
      t = 0
      serpent.loose()
    end
  end
end

function move()
--  if mode == "d" then
--    serpent.gotou[#serpent.gotou+1] = {serpent.corps[#serpent.corps][1]+1,serpent.corps[#serpent.corps][2]}
--  end
--  if mode == "g" then
--    serpent.gotou[#serpent.gotou+1] = {serpent.corps[#serpent.corps][1]-1,serpent.corps[#serpent.corps][2]}
--  end
--  if mode == "h" then
--    serpent.gotou[#serpent.gotou+1] = {serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]-1}
--  end
--  if mode == "b" then
--    serpent.gotou[#serpent.gotou+1] = {serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]+1}
--  end
  if #serpent.gotou == 0 then
    
--    for i = 1,#serpent.corps do
--      lesMurs[#lesMurs+1] = {}
--      lesMurs[#lesMurs][1] = serpent.corps[i][1]
--      lesMurs[#lesMurs][2] = serpent.corps[i][2]
--    end
    --lesMurs = serpent.corps
    lesMurs = assingTable(serpent.corps)
--    movet = {}
--    print(tprint(serpent.corps))
--    print("--------------------------------------------------------------------------------------")
    --lesMurs = CaseVoisine(serpent.corps,ligne,colonne)
    --removeVoTeEtQu(lesMurs,serpent.corps[#serpent.corps],serpent.corps[1])
--    for i = 1,#serpent.corps do
--      lesMurs[#lesMurs+1] = serpent.corps[i]
--    end
    
    --table.remove(lesMurs,1)
    --table.foreach(lesMurs,print)
    if #serpent.corps >= tailleI+1 and math.abs(serpent.last[1] - food.x ) + math.abs(serpent.last[2] - food.y) <= 1   then
      movet = LongAstarGrid({serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]},{food.x,food.y},lesMurs,ligne,colonne)
    else
      movet = AstarGrid({serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]},{food.x,food.y},lesMurs,ligne,colonne)
    end
    
    if #movet ~= 0 and #serpent.corps >= tailleI+1 then
--      print(2)
      
      table.remove(lesMurs,1)
      for i = 1,#movet do
        lesMurs[#lesMurs+1] = {movet[#movet-i + 1].x,movet[#movet-i + 1].y}
      end
--      print(serpent.corps[1][1])
--      print(serpent.corps[1][2])
--      print("les murs = ".. tbprint(lesMurs))

--      print("---------------------------------------------------------------------")
      PathFruitTail = AstarGrid({food.x,food.y},{serpent.corps[1][1],serpent.corps[1][2]},lesMurs,ligne,colonne)
--      print("---------------------------------------------------------------------")
--      print(serpent.corps[1][1].."  "..serpent.corps[1][2])
--      print(food.x.."   ".. food.y)
--      print(tprint(PathFruitTail))
--      for i = 1,#PathFruitTail do
--        love.graphics.setColor(1,1,0)
--        love.graphics.rectangle("fill",PathFruitTail[i].x*w,PathFruitTail[i].y*h,w,h)
--      end
--      table.foreach(PathFruitTail,print)
      
      if #PathFruitTail == 0 then
        movet = {}
      end
    end
    lesMurs = assingTable(serpent.corps)

    
    
    
    
    
    local lej = 1
    --table.foreach(movet,print)
    if #movet == 0 then
      print(3)
      if serpent.last[1] == serpent.corps[#serpent.corps][1] and serpent.last[2] == serpent.corps[#serpent.corps][2] then
        table.remove(lesMurs,1)
        table.remove(lesMurs,2)
        movet = LongAstarGrid({serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]},{serpent.corps[2][2],serpent.corps[2][2]},lesMurs,ligne,colonne)
        print("l")
      else
        if #serpent.corps < math.ceil((ligne*colonne)/4) then 
          movet = AstarGrid({serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]},{serpent.last--[[2]][1],serpent.last--[[2]][2]},lesMurs,ligne,colonne)
        else
          movet = LongAstarGrid({serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]},{serpent.last--[[2]][1],serpent.last--[[2]][2]},lesMurs,ligne,colonne)
        end
        print('c')
      end
    end
    local wrun = true 
    
--    if #serpent.corps >= math.ceil(ligne*colonne*0.5) then 
--      lesMurs = assingTable(serpent.corps)
--      movet = LongAstarGrid({serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]},{serpent.last--[[2]][1],serpent.last--[[2]][2]},lesMurs,ligne,colonne)
--    end
    
    
    
    
    
    lesMurs = assingTable(serpent.corps)
    while #movet == 0 and wrun do 
      --print("lej : "..lej)
      movet = AstarGrid({serpent.corps[#serpent.corps][1],serpent.corps[#serpent.corps][2]},{serpent.corps[lej][1],serpent.corps[lej][2]},lesMurs,ligne,colonne)
      if lej < #serpent.corps then
      lej = lej + 1
      else 
      wrun = false
      end
    end 
    
    movet = reversTable(movet)
    for i = 2,#movet do
      serpent.gotou[#serpent.gotou+1] = {movet[i].x,movet[i].y}
    end
    for i = 1,#serpent.gotou do
--    print("x : ".. serpent.gotou[i][1])
--    print("y : "..serpent.gotou[i][2])
    end
  end
  serpent.corps[#serpent.corps+1] = serpent.gotou[1]
--  table.foreach(serpent.corps,print)
  table.remove(serpent.gotou,1)
  print(#serpent.corps)
  

end

function love.keypressed(key)
  if key == "d" and mode ~= "g" then 
    mode = "d"
  end
  if key == "q" and mode ~= "d" then 
    mode = "g"
  end
  if key == "z" and mode ~= "b" then 
    mode = "h"
  end
  if key == "s" and mode ~= "h"  then 
    mode = "b"
  end
  if key == "r" then
    RunGame = true
    food.x = math.random(1,ligne)
    food.y = math.random(1,colonne)
    serpent.gotou = {}
    taille = 4 
    serpent.corps = {}
    serpent.corps[#serpent.corps+1] = {1,1}
    mode = "d"
  end
end

