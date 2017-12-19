State_Title = {};

function State_Title:init()
	self.image = love.graphics.newImage("asset/image/screen/Title.png");
end

function State_Title:keypressed(key, unicode)
	GameState.switch(State_Game);
end

function State_Title:gamepadpressed(joystick, button)
	print(button);
  if button == JOY_START then
    GameState.switch(State_Game);
  end
end

function State_Title:draw()
	CANVAS:renderTo(function()
    love.graphics.draw(self.image);
  end);

  love.graphics.setColor(255, 255, 255);
  love.graphics.draw(CANVAS, CANVAS_OFFSET_X, CANVAS_OFFSET_Y, 0, CANVAS_SCALE, CANVAS_SCALE);
end