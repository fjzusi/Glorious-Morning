PLAYER_INITIAL_DIMENSIONS = {
  x = 200-28,
  y = 600-96,
  w = 56,
  h = 32
};

PLAYER_MOVE_SPEED = 500;
PLAYER_DAMAGE = 0.15;
PLAYER_REGEN_RATE = 0.2;
PLAYER_BLINK_TIMER = 0.4;

Player = Class {
  init = function(self)
    self.box = {
      x = PLAYER_INITIAL_DIMENSIONS.x,
      y = PLAYER_INITIAL_DIMENSIONS.y,
      w = PLAYER_INITIAL_DIMENSIONS.w,
      h = PLAYER_INITIAL_DIMENSIONS.h
    };
  
    BumpWorld:add(self, self.box.x, self.box.y, self.box.w, self.box.h);
    
    self.leftPressed = false;
    self.rightPressed = false;
    self.upPressed = false;
    self.downPressed = false;
    
    self.life = 1;
    self.blinkTimer = 0;
    self.eyeSize = 0;
    self.active = true;
    self.type = "player";
  end
};

playerFilter = function(item, other)
    if(not other.active) then
      return nil;
    end
    
    if(other.type == "wall" and HIT_ENABLED) then
      return "cross";
    end
    
    return nil;
end

function Player:reset()
  self.box = {
    x = PLAYER_INITIAL_DIMENSIONS.x,
    y = PLAYER_INITIAL_DIMENSIONS.y,
    w = PLAYER_INITIAL_DIMENSIONS.w,
    h = PLAYER_INITIAL_DIMENSIONS.h
  };
  BumpWorld:update(self, self.box.x, self.box.y);
  
  self.life = 1;
  
  self.leftPressed = false;
  self.rightPressed = false;
  self.upPressed = false;
  self.downPressed = false;
  
  self.active = true;
end

function Player:hit()
  self.life = self.life - PLAYER_DAMAGE;
  self.blinkTimer = PLAYER_BLINK_TIMER;
end

function Player:update(dt, sunTimer)
  if(self.blinkTimer > 0) then
    self.blinkTimer = self.blinkTimer - dt;
  end
  
  self:move(dt);
  self:updateLife(dt);
  self:updateEyes(sunTimer);
end

function Player:move(dt)
  local dx = self.box.x;
  local dy = self.box.y;
  
  if(self.leftPressed) then
    dx = dx - PLAYER_MOVE_SPEED * dt;
  end
  
  if(self.rightPressed) then
    dx = dx + PLAYER_MOVE_SPEED * dt;
  end
  
  if(self.upPressed) then
    dy = dy - PLAYER_MOVE_SPEED * dt;
  end
  
  if(self.downPressed) then
    dy = dy + PLAYER_MOVE_SPEED * dt;
  end
  
  dx = math.clamp(0, dx, SCREEN_WIDTH - self.box.w);
  dy = math.clamp(0, dy, PLAYER_INITIAL_DIMENSIONS.y);
  
  local actualX, actualY, cols, len = BumpWorld:move(self, dx, dy, playerFilter);
  
  self.box.x = actualX;
  self.box.y = actualY;
end

function Player:updateLife(dt)
  if(self.life < 0) then
    GameState.switch(State_Game_Over);
  end
  
  self.life = self.life + PLAYER_REGEN_RATE * dt;
  
  if(self.life > 1) then
    self.life = 1;
  end
end

function Player:updateEyes(sunTimer)
  self.eyeSize = 1 + (5 * (1 - sunTimer / SUN_TIMER));
end

function Player:drawBelow()
  love.graphics.setColor(0, 0, 255);
  love.graphics.rectangle("fill", self.box.x, self.box.y, self.box.w, self.box.h);
  
  if(self.blinkTimer <= 0) then
    local offsetx = 15;
    love.graphics.setColor(255, 255, 255);
    love.graphics.ellipse("fill", self.box.x + offsetx, self.box.y + 16, 6, self.eyeSize);
    love.graphics.ellipse("fill", self.box.x + self.box.w - offsetx, self.box.y + 16, 6, self.eyeSize);
    
    love.graphics.setColor(0, 0, 0);
    local offsety = 16 - self.eyeSize + self.eyeSize / 2;
    love.graphics.circle("fill", self.box.x + offsetx, self.box.y + offsety, self.eyeSize / 2, 100);
    love.graphics.circle("fill", self.box.x + self.box.w - offsetx, self.box.y + offsety, self.eyeSize / 2, 100);
  end
end

function Player:drawAbove()
  love.graphics.setColor(0, 255, 0);
  love.graphics.rectangle("fill", 20, 560, 360 * self.life, 20);
end