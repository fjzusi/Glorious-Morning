SUN_START = 350;
SUN_END = 100;
SUNBURST_TIMER = 2;

CLOUD_SPEED = 2;

Background = Class {
  init = function(self)
    self.imageSun = love.graphics.newImage("asset/image/sprite/Sun.png");
    self.imageSunburst = love.graphics.newImage("asset/image/sprite/SunBurst.png");
    self.imageHill = love.graphics.newImage("asset/image/screen/Play.png");
    
    self.darknessAlpha = 0;
    self.sunPosition = SUN_START;
    
    self.sunBurstTimer = 0;
    self.sunBurstActive = false;
    
    self.clouds = {};
  end
};

function Background:reset()
  self.darknessAlpha = 0;
  self.sunPosition = SUN_START;
  
  self.sunBurstTimer = 0;
  self.sunBurstActive = false;
  
  self.clouds = {};
  table.insert(self.clouds, {x = 300, y = 50, radiusx = 40, radiusy = 20});
  table.insert(self.clouds, {x = 150, y = 90, radiusx = 40, radiusy = 20});
  table.insert(self.clouds, {x = 20, y = 60, radiusx = 40, radiusy = 20});
  table.insert(self.clouds, {x = -150, y = 40, radiusx = 40, radiusy = 20});
end

function Background:fireSunBurst()
  self.sunBurstActive = true;
  self.sunBurstTimer = 0;
end

function Background:update(dt, sunTimer)
  self:updateSun(sunTimer);
  self:updateClouds(dt);
  
  if(self.sunBurstActive) then
    self:updateSunBurst(dt);
  end
end

function Background:updateSun(sunTimer)
  local sunPercent = sunTimer / SUN_TIMER;
  local sunPercentReverse = 1 - sunPercent;
  
  self.darknessAlpha = (sunPercent * 200);
  self.sunPosition = SUN_START - (sunPercentReverse * (SUN_START - SUN_END));
end

function Background:updateClouds(dt)
  for k,cloud in pairs(self.clouds) do
    cloud.x = cloud.x + CLOUD_SPEED * dt;
  end
end

function Background:updateSunBurst(dt)
  self.sunBurstTimer = self.sunBurstTimer + dt;
  
  if(self.sunBurstTimer > SUNBURST_TIMER) then
    self.sunBurstActive = false;
    self.sunBurstTimer = 0;
    return;
  end
end

function Background:drawBelow()
  -- draw sky
  love.graphics.setColor(0, 255, 255);
  love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  
  -- draw sun
  love.graphics.setColor(255, 255, 255);
  love.graphics.draw(self.imageSun, 200 - 60, self.sunPosition - 60);
  
  love.graphics.setColor(255, 255, 255);
  for k,cloud in pairs(self.clouds) do
    love.graphics.ellipse("fill", cloud.x, cloud.y, cloud.radiusx, cloud.radiusy);
  end
  
  -- draw hill
  love.graphics.draw(self.imageHill, 0, 0);
end

function Background:drawAbove()
  love.graphics.setColor(0, 0, 0, self.darknessAlpha);
  love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
  
  if(self.sunBurstActive) then
    local bAlpha = 255 - (255 * self.sunBurstTimer / SUNBURST_TIMER);
    love.graphics.setColor(255, 255, 255, bAlpha);
    
    local bx = 200 - (self.imageSunburst:getWidth() * self.sunBurstTimer) / 2;
    local by = 250 - (self.imageSunburst:getHeight() * self.sunBurstTimer) / 2;
    love.graphics.draw(self.imageSunburst, bx, by, 0, self.sunBurstTimer, self.sunBurstTimer);
  end
end