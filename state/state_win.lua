State_Win = {};

function State_Win:init()
	self.image = love.graphics.newImage("asset/image/screen/Win.png");
end

function State_Win:keypressed(key, unicode)
  if(key == "space") then
    GameState.switch(State_Title);
  end
end

function State_Win:gamepadpressed(joystick, button)
  if button == JOY_START then
    GameState.switch(State_Title);
  end
end

function State_Win:draw()
	CANVAS:renderTo(function()
    love.graphics.draw(self.image);
  end);

  love.graphics.setColor(255, 255, 255);
  love.graphics.draw(CANVAS, CANVAS_OFFSET_X, CANVAS_OFFSET_Y, 0, CANVAS_SCALE, CANVAS_SCALE);
end