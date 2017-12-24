Class = require "lib/hump/class";
GameState = require "lib/hump/gamestate";
Timer = require "lib/hump/timer";
Bump = require "lib/bump";

require "state/state_splash_hive";
require "state/state_splash_love";
require "state/state_title";
require "state/state_game";
require "state/state_game_over";
require "state/state_win";

BumpWorld = {};

FULLSCREEN = true;
SCREEN_WIDTH = 400;
SCREEN_HEIGHT = 600;

JOY_LEFT = "dpleft";
JOY_RIGHT = "dpright";
JOY_UP = "dpup";
JOY_DOWN = "dpdown";
JOY_START = "start";
JOY_QUIT = "back";

-- Debug variables
PLAY_MUSIC = true;
HIT_ENABLED = true;

function love.load()
	love.window.setFullscreen(FULLSCREEN);

  CANVAS = love.graphics.newCanvas(SCREEN_WIDTH, SCREEN_HEIGHT);
  CANVAS:setFilter("nearest");

  local w = love.graphics.getWidth();
  local h = love.graphics.getHeight();

  local scaleX = 1;
  local scaleY = 1;

  if FULLSCREEN then
    scaleX = w / SCREEN_WIDTH;
    scaleY = h / SCREEN_HEIGHT;
  end

  CANVAS_SCALE = math.min(scaleX, scaleY);

  CANVAS_OFFSET_X = w / 2 - (SCREEN_WIDTH * CANVAS_SCALE) / 2;
  CANVAS_OFFSET_Y = h / 2 - (SCREEN_HEIGHT * CANVAS_SCALE) / 2;

	GameState.registerEvents();
	GameState.switch(State_Splash_Hive);
end

function love.mousepressed(x, y, button)
	-- Mouse button pressed
end

function love.mousereleased(x, y, button)
	-- Mouse button released
end

function love.keypressed(key, unicode)
	if(key == "escape") then
		love.event.quit();
	end
end

function love.gamepadpressed(joystick, button)
  if button == JOY_QUIT then
    love.event.quit();
  end
end

function love.keyreleased(key, unicode)
	-- Key released
end

function love.update(dt)
	-- Update Game
	-- dt = Delta Time. Time elapsed since last update in seconds
end

function love.draw()
	-- Draw game
end

function love.focus(f)
	if(not f) then
		print("LOST FOCUS");
	else
		print("GAINED FOCUS");
	end
end

function love.quit()
	-- Called when game is quit
end

function math.clamp(low, n, high) return math.min(math.max(low, n), high) end