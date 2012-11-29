passengerSpeach = {
	"To trAIn or not to trAIn, that is the question.",
	"I really like Gokarts 2 - ah, wait, wrong game.",
	"What idiot programmed these trAIns? They're slow as hell...",
	"Those trAIn rides make me sick...",
	"Dentist appointment, so, uhm... take your time. No rush. Really.",
	"Bazinga!",
	"Just a another boring day of work...",
	"Why walk now, if I can trAIn all day long instead?",
}
vipSpeach = {
	"Have you seen those clouds? It's gonna rain soon!",
	"I desperately need to use the loo!",
	"I'm late for school!",
	"I left the oven on.",
	"Need to get home. Big Bang Theory starts any minute now...",
	"My wife will kill me if I'm not home by nine!",
	"I HAVE to get to this party before she gets there.",
	"Late for a date...",
	"My kids are home alone.",
	"My dog needs food!",
	"...",
}

local pSpeach = {}

function pSpeach.init()

	if not pSpeachBubbleThread and not pSpeachBubble then		-- only start thread once!
		ok, pSpeachBubble = pcall(love.graphics.newImage, "pSpeachBubble.png")
		if not ok or not versionCheck.getMatch() then
			pSpeachBubble = nil
			loadingScreen.addSection("Rendering Speach Bubble Box")
			pSpeachBubbleThread = love.thread.newThread("pSpeachBubbleThread", "Scripts/createImageBox.lua")
			pSpeachBubbleThread:start()
	
			pSpeachBubbleThread:set("width", BUBBLE_WIDTH )
			pSpeachBubbleThread:set("height", BUBBLE_HEIGHT )
			pSpeachBubbleThread:set("shadow", true )
			pSpeachBubbleThread:set("shadowOffsetX", 10 )
			pSpeachBubbleThread:set("shadowOffsetY", 0 )
			pSpeachBubbleThread:set("colR", BUBBLE_R )
			pSpeachBubbleThread:set("colG", BUBBLE_G )
			pSpeachBubbleThread:set("colB", BUBBLE_B )
		end
	else
		if not pSpeachBubble then	-- if there's no button yet, that means the thread is still running...
		
			percent = pSpeachBubbleThread:get("percentage")
			if percent then
				loadingScreen.percentage("Rendering Speach Bubble Box", percent)
			end
			err = pSpeachBubbleThread:get("error")
			if err then
				print("Error in thread:", err)
			end
		
			status = pSpeachBubbleThread:get("status")
			if status == "done" then
				pSpeachBubble = pSpeachBubbleThread:get("imageData")		-- get the generated image data from the thread
				pSpeachBubble:encode("pSpeachBubble.png")
				pSpeachBubble = love.graphics.newImage(pSpeachBubble)
				pSpeachBubbleThread = nil
			end
		end
	end
	--pSpeachBubble = createBoxImage(HELP_WIDTH,HELP_HEIGHT,true, 10, 0,64,160,100)
end

function pSpeach.initialised()
	if pSpeachBubble then
		return true
	end
end

return pSpeach
