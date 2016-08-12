WALL_IMAGE = love.graphics.newImage("asset/image/sprite/Wall.png");

Wall = Class {
  init = function(self, nx)
    self.x = nx;
    self.y = -18;
    self.w = 18;
    self.h = 18;
    self.type = "wall";
    self.active = true;
    
    BumpWorld:add(self, self.x, self.y, self.w, self.h);
  end
}

function Wall:update(dt)
  self.y = self.y + WALL_SPEED * dt;
    
  local actualX, actualY, cols, len = BumpWorld:move(self, self.x, self.y, wallFilter);
  
  for i=1, len do
    if(cols[i].other.type == "player") then
      self.active = false;
      BumpWorld:remove(self);
      cols[i].other:hit();
    end
  end
  
  if(self.y > SCREEN_HEIGHT) then
    self.active = false;
    BumpWorld:remove(self);
  end
end

function Wall:draw()
  love.graphics.setColor(255, 255, 255);
  love.graphics.draw(WALL_IMAGE, self.x, self.y);
end