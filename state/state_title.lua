State_Title = {};

function State_Title:init()
	self.image = love.graphics.newImage("asset/image/screen/Title.png");
end

function State_Title:keypressed(key, unicode)
	GameState.switch(State_Game);
end

function State_Title:draw()
	love.graphics.draw(self.image);
end