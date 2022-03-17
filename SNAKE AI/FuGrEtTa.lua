function AstarGrid(start,goal,murs,ligne,colonne)
    function spot(tablee,i,j)
        tablee.x = i
        tablee.y = j
        tablee.f = 0
        tablee.g = 0
        tablee.h = 0
        tablee.voisin = {}
        tablee.CameFrom = {}
        
        function tablee.PlusDeVoisin(grid)
          local i2 = tablee.x
          local j2 = tablee.y
          if i2 > 1 then 
            tablee.voisin[#tablee.voisin+1] = grid[i-1][j]
          end
          if i2 < ligne then 
                  tablee.voisin[#tablee.voisin+1] = grid[i+1][j]
          end
          if j2 > 1 then
                  tablee.voisin[#tablee.voisin+1] = grid[i][j-1]
          end
          if j2 < colonne then
                  tablee.voisin[#tablee.voisin+1] = grid[i][j+1]
          end
        end
      end


    


    local grille = {} 
    for i = 1,colonne do
    grille[i] = {}
        for j = 1,ligne do 
            grille[i][j] = {}
            spot(grille[i][j],i,j)
        end 
    end 
    for i = 1,colonne do
        for j = 1,ligne do 
          grille[i][j].PlusDeVoisin(grille)
        end 
    end       
    
    local theWay = {}
    local openset = {}
    local closeset = {}
    for i  = 1,#murs do
        table.insert(closeset,grille[murs[i][1]][murs[i][2]])
    end
    

    local debut = grille[start[1]][start[2]]
    local fin = grille[goal[1]][goal[2]]

    openset[#openset+1] =  debut
    

    while #openset > 0 do
        theWay = {}
        winner = 1
        for i = 1,#openset do
            if openset[i].f < openset[winner].f then
            winner = i
            end
        end 
        current = openset[winner]
        table.remove(openset,winner)
        table.insert(closeset,current)

        for i = 1,#current.voisin do
            levoisin = current.voisin[i]
            
            if VinO(closeset,levoisin) then
                tempG = current.g + 1
                
                levoisin.g = tempG
                levoisin.h = heuristic(levoisin,fin)
                levoisin.f = levoisin.g + levoisin.h
                levoisin.CameFrom = current
                if VinO(openset,levoisin) then
                table.insert(openset,levoisin)
                end
            end
        end
        if current == fin then
            run = false
            test = true 
            while test do
                if type(current.CameFrom) == "nil" then
                    test = false
                else
                    theWay[#theWay+1] = current
                    current = current.CameFrom
                end
            end
            return theWay
        end
    end 
    return {}
end



function heuristic(a,b)
    local varHeu =((b.x - a.x)^2 + (b.y - a.y)^2)^0.5
    --  local varHeu = b.x - a.x + b.y - a.y
    --  local varHeu =-((b.x - a.x)^2 + (b.y - a.y)^2)^0.5
    return varHeu
end


function VinO(O,V)
    for i = 1,#O do
      if O[i].x == V.x and O[i].y == V.y then
      return false
      end
    end
    return true
end

function reversTable(tabl)
  local rtabl = {}
  for i = 1,#tabl do
    table.insert(rtabl,tabl[#tabl])
    table.remove(tabl, #tabl)
  end
  return rtabl 
end


function LongAstarGrid(start,goal,murs,ligne,colonne)
    function spot(tablee,i,j)
        tablee.x = i
        tablee.y = j
        tablee.f = 0
        tablee.g = 0
        tablee.h = 0
        tablee.voisin = {}
        tablee.CameFrom = {}
        
        function tablee.PlusDeVoisin(grid)
          local i2 = tablee.x
          local j2 = tablee.y
          if i2 > 1 then 
            tablee.voisin[#tablee.voisin+1] = grid[i-1][j]
          end
          if i2 < ligne then 
                  tablee.voisin[#tablee.voisin+1] = grid[i+1][j]
          end
          if j2 > 1 then
                  tablee.voisin[#tablee.voisin+1] = grid[i][j-1]
          end
          if j2 < colonne then
                  tablee.voisin[#tablee.voisin+1] = grid[i][j+1]
          end
        end
      end


    


    local grille = {} 
    for i = 1,colonne do
    grille[i] = {}
        for j = 1,ligne do 
            grille[i][j] = {}
            spot(grille[i][j],i,j)
        end 
    end 
    for i = 1,colonne do
        for j = 1,ligne do 
          grille[i][j].PlusDeVoisin(grille)
        end 
    end       
    
    local theWay = {}
    local openset = {}
    local closeset = {}
    for i  = 1,#murs do
        table.insert(closeset,grille[murs[i][1]][murs[i][2]])
    end
    

    local debut = grille[start[1]][start[2]]
    local fin = grille[goal[1]][goal[2]]

    openset[#openset+1] =  debut
    

    while #openset > 0 do
        theWay = {}
        winner = 1
        for i = 1,#openset do
            if openset[i].f > openset[winner].f then
            winner = i
            end
        end 
        current = openset[winner]
        table.remove(openset,winner)
        table.insert(closeset,current)

        for i = 1,#current.voisin do
            levoisin = current.voisin[i]
            
            if VinO(closeset,levoisin) then
                tempG = current.g + 1
                
                levoisin.g = tempG
                levoisin.h = heuristic(levoisin,fin)
                levoisin.f = levoisin.g + levoisin.h
                levoisin.CameFrom = current
                if VinO(openset,levoisin) then
                table.insert(openset,levoisin)
                end
            end
        end
        if current == fin then
            run = false
            test = true 
            while test do
                if type(current.CameFrom) == "nil" then
                    test = false
                else
                    theWay[#theWay+1] = current
                    current = current.CameFrom
                end
            end
            return theWay
        end
    end 
    return {}
end


function add2Table(a,b) 
  for i = 1,#b do
    a[#a+1] = b[i]
  end
  return a
end


function assingTable(AT)
  local NT = {}
  for i = 1,#AT do
    NT[#NT+1] = AT[i]
  end
  return NT 
end


function printTable(t)
  local taille = #t
  local i = 1
  local currentT = assingTable(t)
  table.foreach(currentT[1],print)
  local deepT = 0
  local str = "{"
  while i <=  taille do
    if type(currentT[i]) == "table" then
      taille = (taille + #currentT[i])-1
      currentT = currentT[i]
      deepT = deepT + 1
      str = str .. "{"
    else
      for j = 1,#currentT do 
        str = str .. tostring(currentT[j]) .. " "
      end
      
      for j = 1,deepT do
        currentT = currentT[i]
      end
      deepT = deepT - 1 
      i = i+1
      str = str .. "}"
    end
  end
  str = str .. "}"
  print(str)
end


function TinT2Cmarchepas(E,T,p)
  local G = false
  local Path = p or {}
  if type(E) == "table" then
    EinT(E[1],v)
  else 
    for k,v in pairs(T) do
      if type(v) == "table" then
        G = EinT(E,v)
      end
      if E == v or G then
        return true
      end
    end
  end
end


function EinT(E,T)
  local G = false
  local emplacement = {}
  for k,v in pairs(T) do
    if type(v) == "table" then
      G , emplacement[#emplacement+1] = EinT(E,v)
    end
    if E == v or G then
      emplacement[#emplacement+1] = k
      return true, emplacement
    end
  end
  return false, {}
end



function tprint (tbl, indent)
  if not indent then indent = 0 end
  local toprint = string.rep(" ", indent) .. "{\r\n"
  indent = indent + 2 
  for k, v in pairs(tbl) do
    toprint = toprint .. string.rep(" ", indent)
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "   
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ",\r\n"
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\",\r\n"
    elseif (type(v) == "table") then
      toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
    end
  end
  toprint = toprint .. string.rep(" ", indent-2) .. "}"
  return toprint
end


function tbprint(tbl)
  local toprint = "{ "
  for k, v in pairs(tbl) do
    if (type(k) == "number") then
      toprint = toprint .. "[" .. k .. "] = "
    elseif (type(k) == "string") then
      toprint = toprint  .. k ..  "= "   
    end
    if (type(v) == "number") then
      toprint = toprint .. v .. ", "
    elseif (type(v) == "string") then
      toprint = toprint .. "\"" .. v .. "\", "
    elseif (type(v) == "table") then
      toprint = toprint .. tbprint(v) .. ", "
    else
      toprint = toprint .. "\"" .. tostring(v) .. "\", "
    end
  end
  toprint = toprint  .. " }"
  return toprint
end


--function CaseVoisine(tabl,lignes,colonnes)
--  local TableVoisin = {}
--  for i = 1,#tabl do
--    if tabl[i][2] > 1 then
--      TableVoisin[#TableVoisin+1] = {tabl[i][1],tabl[i][2]-1}
--    end
--    if tabl[i][2] < colonnes then
--      TableVoisin[#TableVoisin+1] = {tabl[i][1],tabl[i][2]+1}
--    end
--    if tabl[i][1] > 1 then
--      TableVoisin[#TableVoisin+1] = {tabl[i][1]-1,tabl[i][2]}
--    end
--    if tabl[i][1] < lignes then
--      TableVoisin[#TableVoisin+1] = {tabl[i][1]+1,tabl[i][2]}
--    end
--  end
--  for i = 1,#TableVoisin do
--    print(TableVoisin[i][1])
--    print(TableVoisin[i][2])
--    print("----------------------------")
--  end
--  return TableVoisin
--end

----function removeVoTeEtQu(TaVo,tete,queue)
----  for i = 1,#TaVo do
----    if #TaVo > 0 then
----    if TaVo[i][1] == tete[1]+1 and TaVo[i][2] == tete[2] then
----      table.remove(TaVo,i)
----    end
----    end
----    if #TaVo > 0 then
----    if TaVo[i][1] == tete[1]-1 and TaVo[i][2] == tete[2] then
----      table.remove(TaVo,i)
----    end
----    end
----    if #TaVo > 0 then
----    if TaVo[i][1] == tete[1] and TaVo[i][2] == tete[2]+1 then
----      table.remove(TaVo,i)
----    end
----    end
----    if #TaVo > 0 then
----    if TaVo[i][1] == tete[1] and TaVo[i][2] == tete[2]-1 then
----      table.remove(TaVo,i)
----    end
----    end
    
----    if #TaVo > 0 then
----    if TaVo[i][1] == queue[1]+1 and TaVo[i][2] == queue[2] then
----      table.remove(TaVo,i)
----    end
----    end
----    if #TaVo > 0 then
----    if TaVo[i][1] == queue[1]-1 and TaVo[i][2] == queue[2] then
----      table.remove(TaVo,i)
----    end
----    end
----    if #TaVo > 0 then
----    if TaVo[i][1] == queue[1] and TaVo[i][2] == queue[2]+1 then
----      table.remove(TaVo,i)
----    end
----    end
----    if #TaVo > 0 then
----    if TaVo[i][1] == queue[1] and TaVo[i][2] == queue[2]-1 then
----      table.remove(TaVo,i)
----    end
----    end
----  end
  
----endù



function hsl_to_rgb(H,S,L)
  local H = H%360
  local S = S/100
  local L = L/100
  local C = (1-math.abs(2*L-1)) * S 
  local X = C * (1 - math.abs((H/60) % 2-1 ))
  local M = L-C/2 
  
  if H < 60 then
    return C+M,X+M,0+M
  elseif H < 120 then
    return X+M,C+M,0+M
  elseif H < 180 then
    return 0+M,C+M,X+M
  elseif H < 240 then
    return 0+M,X+M,C+M
  elseif H < 300 then
    return X+M,0+M,C+M
  elseif H < 360 then
    return C+M,0+M,X+M
  end
end 
