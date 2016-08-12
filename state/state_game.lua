require "player";
require "wall_manager";
require "background";
require "timeline";

SUN_RATE = 1;
SUN_TIMER = 112;

State_Game = {};

function State_Game:init()
	BumpWorld = Bump.newWorld(32);
  
  self.player = Player();
  self.wallManager = WallManager();
  self.background = Background();
  self.timeline = Timeline(self.wallManager, self.background);
  
  self.time = 0;
  self.sunTimer = SUN_TIMER;
  
  self.backgroundMusic = love.audio.newSource("asset/music/gloriousmorning.mp3", "stream");
end

function State_Game:enter()
  self.player:reset();
  self.wallManager:reset();
  self.background:reset();
  self.timeline:reset();
  
  self.time = 0;
  self.sunTimer = SUN_TIMER;
  
	love.audio.rewind(self.backgroundMusic);
  
  if(PLAY_MUSIC) then
    love.audio.play(self.backgroundMusic);
  end
end

function State_Game:leave()
	love.audio.stop(self.backgroundMusic);
end

function State_Game:focus(f)
	if not f then
		self.paused = true;
	else
		self.paused = false;
	end
end

function State_Game:keypressed(key, unicode)
	if(key == "left") then
    self.player.leftPressed = true;
  end
  
  if(key == "right") then
    self.player.rightPressed = true;
  end
  
  if(key == "up") then
    self.player.upPressed = true;
  end
  
  if(key == "down") then
    self.player.downPressed = true;
  end
end

function State_Game:keyreleased(key, unicode)
	if(key == "left") then
    self.player.leftPressed = false;
  end
  
  if(key == "right") then
    self.player.rightPressed = false;
  end
  
  if(key == "up") then
    self.player.upPressed = false;
  end
  
  if(key == "down") then
    self.player.downPressed = false;
  end
end

function State_Game:update(dt)
	if(not self.paused) then
    self.time = self.time + dt;
    self.sunTimer = self.sunTimer - dt * SUN_RATE;
    
    self.timeline:update(dt);
		self.player:update(dt, self.sunTimer);
    self.wallManager:update(dt);
    self.background:update(dt, self.sunTimer);
    
    if(self.sunTimer < 0) then
      GameState.switch(State_Win);
    end
	end
end

function State_Game:draw()
	self.background:drawBelow();
  self.player:drawBelow();
  self.background:drawAbove();
  self.player:drawAbove();
  self.wallManager:draw();
  
  self.timeline:draw();
end