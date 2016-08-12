State_Win = {};

function State_Win:init()
	self.image = love.graphics.newImage("asset/image/screen/Win.png");
end

function State_Win:keypressed(key, unicode)
  if(key == "space") then
    GameState.switch(State_Title);
  end
end

function State_Win:draw()
	love.graphics.draw(self.image);
end