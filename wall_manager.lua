require "wall";

WALL_SPEED = 620;

WallManager = Class {
  init = function(self)
    self.walls = {};
    
    local img = love.graphics.newImage("asset/image/particle/Explosion.png");
    local expPart = love.graphics.newParticleSystem(img, 256);
    
    expPart:setParticleLifetime(0.1, 0.5);
    expPart:setSpeed(100, 300);
    expPart:setLinearAcceleration(0, 600, 0, 800);
    expPart:setSpread(math.pi);
    expPart:setDirection(math.pi * 3/2);
    expPart:setColors(0, 255, 255, 255, 0, 255, 255, 0);
    
    self.explosionPart = expPart;
  end
};

wallFilter = function(item, other)
    if(not other.active) then
      return nil;
    end
    
    if(other.type == "player" and HIT_ENABLED) then
      return "cross";
    end
    
    return nil;
end

function WallManager:reset()
  for k,v in pairs(self.walls) do
    BumpWorld:remove(v);
  end
  
  self.walls = {};
end

function WallManager:addWall(num)
  for i=1, num do
    local nx = love.math.random(0, SCREEN_WIDTH - 18);
  
    local newWall = Wall(nx);
    table.insert(self.walls, newWall);
  end
end

function WallManager:update(dt)
  self.explosionPart:update(dt);
  
  self:updateWalls(dt);
  self:removeWalls();
end

function WallManager:updateWalls(dt)
  for k,wall in pairs(self.walls) do
    wall:update(dt);
  end
end

function WallManager:removeWalls()
  local aliveWalls = {};
  
  for k,wall in pairs(self.walls) do
    if(wall.active) then
      table.insert(aliveWalls, wall);
    else
      self.explosionPart:setPosition(wall.x + wall.w / 2, wall.y + wall.h / 2);
      self.explosionPart:emit(64);
    end
  end
  
  self.walls = aliveWalls;
end

function WallManager:draw()
  for k,wall in pairs(self.walls) do
    wall:draw();
  end
  
  love.graphics.setColor(255, 255, 255);
  love.graphics.draw(self.explosionPart);
end