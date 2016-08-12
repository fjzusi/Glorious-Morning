State_Game_Over = {};

function State_Game_Over:init()
	self.image = love.graphics.newImage("asset/image/screen/GameOver.png");
end

function State_Game_Over:keypressed(key, unicode)
  if(key == "space") then
    GameState.switch(State_Title);
  end
end

function State_Game_Over:draw()
	love.graphics.draw(self.image);
end