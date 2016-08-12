GameState = require "lib/hump/gamestate";
Class = require "lib/hump/class";
Bump = require "lib/bump";

require "state/state_title";
require "state/state_game";
require "state/state_game_over";
require "state/state_win";

BumpWorld = {};

SCREEN_WIDTH = 400;
SCREEN_HEIGHT = 600;

-- Debug variables
PLAY_MUSIC = true;
HIT_ENABLED = true;

function love.load()
	GameState.registerEvents();
	GameState.switch(State_Title);
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