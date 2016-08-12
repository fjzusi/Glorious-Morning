require "asset/config/game_timeline"

Timeline = Class {
  init = function(self, wallManager, background)
    self.timePassed = 0;
    self.timelineIndex = 1;
    self.lastTime = 0;
    
    self.wallManager = wallManager;
    self.background = background;
  end
}

function Timeline:reset()
  self.timePassed = 0;
  self.timelineIndex = 1;
end

function Timeline:update(dt)
  self.timePassed = self.timePassed + dt;
  
  if(GAME_TIMELINE[self.timelineIndex]) then
    if(self.lastTime + self.timePassed > self.lastTime + GAME_TIMELINE[self.timelineIndex].time) then
      local event = GAME_TIMELINE[self.timelineIndex].event;
      local count = GAME_TIMELINE[self.timelineIndex].count;
      
      -- do event
      if(event == "wall") then
        self.wallManager:addWall(count);
      elseif(event == "sunburst") then
        self.background:fireSunBurst();
      end
      
      self.timelineIndex = self.timelineIndex + 1;
      self.lastTime = self.lastTime + GAME_TIMELINE[self.timelineIndex].time;
      self.timePassed = 0;
    end
  end
end

function Timeline:draw()
  
end