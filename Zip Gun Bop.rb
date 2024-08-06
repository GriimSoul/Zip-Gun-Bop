
require 'ruby2d'

# Set window properties
set background: 'black'
set title: "Zip Gun Bop"
WINDOW_WIDTH = 640
WINDOW_HEIGHT = 480
victory_counter = 0

# Method to safely load images and catch warnings
def safe_image_load(file, options = {})
  # puts "Loading image: #{file}" #Uncomment for debbuging
  image = Image.new(file, **options)
  # puts "Loaded image: #{file}" #Uncomment for debbuging
  image
rescue StandardError => e
  # puts "Error loading image #{file}: #{e.message}" #Uncomment for debbuging
  nil
end
#Method to write multiline text
def multiline_text(x, y, text, options = {})
  lines = text.split("\n")
  line_height = options[:line_height] || 20  # Adjust line height as needed
  texts = lines.map.with_index do |line, index|
    Text.new(line, x: x, y: y + index * line_height, **options)
  end
  texts
end


# Load background image & Wife
bg = safe_image_load("assets/Classroom.jpg", width: 640, height: 480 ) #background image for title
part1 = safe_image_load("assets/part1.jpg", width: 640, height: 480, z: -200) 
part2 = safe_image_load("assets/part2.jpg", width: 640, height: 480, z: -200)
part3 = safe_image_load("assets/part3.jpg", width: 640, height: 480, z: -200)
victory = safe_image_load("assets/You win.png", width: 640, height: 480) # Image for victory screen
wife = safe_image_load("assets/Victory.png", x: 195, y: 40, width: 250, height: 400) # Image of wife
part1.remove
part2.remove
part3.remove
victory.remove
wife.remove

# Class variables that check whether or not we changed bg parts
   @part2bg = false
   @part3bg = false


# Determine girl pictures, and group them into an array. EXPANDABLE
 girls = [
  safe_image_load("assets/Girl1.png", width: 180, height: 180),
  safe_image_load("assets/Girl2.png", width: 180, height: 180),
  safe_image_load("assets/Girl3.png", width: 100, height: 150),
  safe_image_load("assets/Girl4.png", width: 120, height: 170),
  safe_image_load("assets/Girl5.png", width: 150, height: 170),
  safe_image_load("assets/Girl6.png", width: 100, height: 200),
  safe_image_load("assets/Girl7.png", width: 150, height: 450),
  safe_image_load("assets/Girl8.png", width: 100, height: 200),
  safe_image_load("assets/Girl9.png", width: 200, height: 400),
  safe_image_load("assets/Girl10.png", width: 150, height: 250)].compact
  
  girls.each { |girl| girl.remove }

#Determine trap pictures, and group them into an array. EXPANDABLE

     traps = [
	   safe_image_load("assets/Trap1.png", width: 200, height: 375),
	   safe_image_load("assets/Trap2.png", width: 100, height: 200),
	   safe_image_load("assets/Trap3.png", width: 200, height: 270),
	   safe_image_load("assets/Trap4.png", width: 230, height: 350),
	   safe_image_load("assets/Trap5.png", width: 125, height: 275),
	   safe_image_load("assets/Trap6.png", width: 160, height: 300),
	   safe_image_load("assets/Trap7.png", width: 145, height: 350),
	   safe_image_load("assets/Trap8.png", width: 275, height: 300),
	   safe_image_load("assets/Trap9.png", width: 100, height: 225),
	   safe_image_load("assets/Trap10.png", width: 375, height: 300)].compact
	   
	traps.each { |trap| trap.remove}   
  
#Determine guy pictures, and group them into an array. EXPANDABLE
  guys = [
    safe_image_load("assets/Guy1.png", width: 100, height: 400),
	safe_image_load("assets/Guy2.png", width: 100, height: 400),
	safe_image_load("assets/Guy3.png", width: 200, height: 300),
	safe_image_load("assets/Guy4.png", width: 100, height: 250),
	safe_image_load("assets/Guy5.png", width: 100, height: 310),
	safe_image_load("assets/Guy6.png", width: 100, height: 240),
	safe_image_load("assets/Guy7.png", width: 120, height: 240),
	safe_image_load("assets/Guy8.png", width: 100, height: 200),
	safe_image_load("assets/Guy9.png", width: 100, height: 400),
	safe_image_load("assets/Guy10.png", width: 100, height: 350)].compact

    guys.each { |guy| guy.remove}
	
#mix the arrays
  everyone = girls + traps + guys
  
# create mc voice arrays

  # for guys and traps. EXPANDABLE
    r_guys_and_traps = [
	  Sound.new("assets/ToGuy1.mp3"),
	  Sound.new("assets/ToGuy2.mp3"),
	  Sound.new("assets/ToGuy3.mp3"),
	  Sound.new("assets/ToGuy4.mp3"),
	  Sound.new("assets/ToGuy5.mp3"),
	  Sound.new("assets/ToGuy6.mp3"),
	  Sound.new("assets/ToGuy7.mp3"),
	  Sound.new("assets/ToGuy8.mp3"),
	  Sound.new("assets/ToGuy9.mp3"),
	  Sound.new("assets/ToGuy10.mp3")].compact
	# From guys and traps. EXPANDABLE
	 f_guys_and_traps = [
      Sound.new("assets/Gent1.mp3"),
	  Sound.new("assets/Gent2.mp3"),
	  Sound.new("assets/Gent3.mp3"),
	  Sound.new("assets/Gent4.mp3"),
	  Sound.new("assets/Gent5.mp3"),
	  Sound.new("assets/Gent6.mp3"),
	  Sound.new("assets/Gent7.mp3"),
	  Sound.new("assets/Gent8.mp3"),
	  Sound.new("assets/Gent9.mp3"),
	  Sound.new("assets/Gent10.mp3")].compact
	  
	  
   # for girls
     r_girls = [
	   Sound.new("assets/ToGirl1.mp3"),
	   Sound.new("assets/ToGirl2.mp3"),
	   Sound.new("assets/ToGirl3.mp3"),
	   Sound.new("assets/ToGirl4.mp3"),
	   Sound.new("assets/ToGirl5.mp3"),
	   Sound.new("assets/ToGirl6.mp3"),
	   Sound.new("assets/ToGirl7.mp3"),
	   Sound.new("assets/ToGirl8.mp3"),
	   Sound.new("assets/ToGirl9.mp3"),
	   Sound.new("assets/ToGirl10.mp3")].compact
	# From girls
	  f_girls = [
	   Sound.new("assets/Gals1.mp3"),
	   Sound.new("assets/Gals2.mp3"),
	   Sound.new("assets/Gals3.mp3"),
	   Sound.new("assets/Gals4.mp3"),
	   Sound.new("assets/Gals5.mp3"),
	   Sound.new("assets/Gals6.mp3"),
	   Sound.new("assets/Gals7.mp3"),
	   Sound.new("assets/Gals8.mp3"),
	   Sound.new("assets/Gals9.mp3"),
	   Sound.new("assets/Gals10.mp3")].compact

# Display texts
intro = Text.new(
  'Press Space to begin',
  font: "assets/TheLost.ttf",
  style: 'bold',
  size: 25,
  color: "red",
  y: 400,
  x: 200
)
controls_text = "Controls\nP to return to title\nRMB on guys\nLMB on girls\nWatch out for traps!"
controls = multiline_text(480, 75, controls_text, font: "assets/TheLost.ttf", style: "bold", size: 16, color: "white")

victory_text = Text.new(
 "Your virginity is safe. You can now relax with your wife",
  font: "assets/TheLost.ttf",
  style: "bold",
  size: 22,
  color: "white",
  y: 440,
  x: 20
)

lose_text = Text.new(
   "You're no longer a virgin, your wife will leave you now",
   font: "assets/TheLost.ttf",
   style: "bold",
   size: 25,
   color: "white",
   y: 227,
   x: 3
   )
   
lose_text2 = Text.new(
  "Press P to return to title, or Space to try again",
   font: "assets/TheLost.ttf",
   style: "bold",
   size: 15,
   color: "white",
   y: 450,
   x: 180)
   
score_tracker = nil
   
   #Remove them
   lose_text.remove
   lose_text2.remove
   victory_text.remove
   
   
# Initialize level_1 variables

lose_screen = false
$level_1_start = false
displayed_images = []
$JOTime = false
huh = Sound.new('assets/huh.mp3')
death = Sound.new("assets/Death.mp3")
error_sound = Sound.new("assets/Error.mp3")
marry_me = Sound.new("assets/plap.mp3")
iloveu = Sound.new("assets/do her.mp3")
my_dear = Sound.new("assets/my type.mp3")
imhome = Sound.new("assets/Imhome.mp3")
@handling_event_press = false
displayed_images = nil
missclicks = 0
@youdidit = false

#Music

  # Load and play the initial music
    virgin = Music.new('assets/Virgin.mp3')
    virgin.loop = true
    virgin.play
    @virgin_playing = true  # Track the state

  #Load victory music
    peter = Music.new('assets/this song.mp3')
    peter.loop = true
    #peter.play
    @peter_playing = false

  # Load the level 1 music
    lvl1 = Music.new('assets/Unleashed.mp3')
    lvl1.loop = true
    @lvl1_playing = false  # Track the state
	
  #Death Music
    game_over = Music.new("assets/Game over.mp3")
	game_over.loop = true
	@game_over_mus = false

# Event handler - Game start or end

on :key_down do |event|
    begin
	 #if you're in the game over screen
	  if $lose_screen 
	    if event.key == "space"
            # puts "Space pressed"  # Debugging: state check
            $lose_screen = false
            @virgin_playing = false
            # puts "Starting lvl1 "  # Debugging: action timing
            lose_text.remove
			lose_text2.remove
            game_over.fadeout(1000)
            @game_over_mus = false
            lvl1.play
            @lvl1_playing = true
            displayed_images = []
			@part2bg = false
			@part3bg = false
            part1.add
            $level_1_start = true
            @next_image_time = Time.now + 1 + rand(5)
			missclicks = 0
          elsif event.key == "p"
            $lose_screen = false
            # puts "P pressed"  # Debugging: state check
            game_over.fadeout(1000)
            @game_over_mus = false
			@part2bg = false
			@part3bg = false
            victory_counter = 0
            displayed_images = []
            # puts "Starting virgin"  # Debugging: action timing
            virgin.play
            @virgin_playing = true
            lose_text.remove
			lose_text2.remove
            bg.add
            intro.add
			controls.each do |text| text.add end
            part1.remove
            $level_1_start = false
			missclicks = 0
          end
		
		
	#else	
   else
      # puts "Key pressed: #{event.key}"  # Debugging: print the key pressed
      if event.key == "space" && @virgin_playing
        # puts "Space pressed and virgin is playing"  # Debugging: state check
        intro.remove
		controls.each do |text| text.remove end
        virgin.fadeout(1000)
        @virgin_playing = false
        # puts "Starting lvl1 after virgin fadeout"  # Debugging: action timing
        lvl1.play
        @lvl1_playing = true
        bg.remove
        part1.add
		@part2bg = false
		@part3bg = false
        $level_1_start = true
        @next_image_time = Time.now + 1 + rand(5)
		displayed_images = [].compact
		missclicks = 0
      elsif event.key == "p" && @lvl1_playing
        # puts "P pressed and lvl1 is playing"  # Debugging: state check
        lvl1.fadeout(1000)
        @lvl1_playing = false
        victory_counter = 0
        # puts "Starting virgin after lvl1 fadeout"  # Debugging: action timing
        everyone.each(&:remove)
        virgin.play
        @virgin_playing = true
        bg.add
        intro.add
		controls.each do |text| text.add end
		@part2bg = false
		@part3bg = false
        part1.remove
		missclicks = 0
		displayed_images = [].compact
        $level_1_start = false
      end
    end
  end
end

# Mouse machinations

on :mouse_down do |event|
   if $JOTime
    if event.button == :left
	  iloveu.play
	elsif event.button == :middle
	  my_dear.play
	elsif event.button == :right
	  marry_me.play
    end	  
	
   elsif $level_1_start
  clicked_on_image = false
  displayed_images.each do |image|
    if image.contains? event.x, event.y
      if event.button == :left
        if girls.include?(image)
         # puts "Removing a girl image with left click" #Uncomment for debbuging
		  r_girls.sample.play
          image.remove
		  f_girls.sample.play
          displayed_images.delete(image)
          victory_counter += 1
       #   puts "You've clicked #{victory_counter} pics, only #{70 - victory_counter} to go" #Uncomment for debbuging
        else
        #  puts "You should right click guys!" #Uncomment for debbuging
		  error_sound.play
		  missclicks +=1
        end
      elsif event.button == :right
        if guys.include?(image) || traps.include?(image)
         # puts "Removing a guy/trap image with right click" #Uncomment for debbuging
		  r_guys_and_traps.sample.play
          image.remove
		  f_guys_and_traps.sample.play
          displayed_images.delete(image)
          victory_counter += 1
          # puts "You've clicked #{victory_counter} pics, only #{70 - victory_counter} to go" #Uncomment for debbuging
        else
        #  puts "You should left click girls!" #Uncomment for debbuging
		  missclicks +=1
		  error_sound.play
        end
      end
      clicked_on_image = true
      break
    end
  end
  # puts "You're clicking absolutely nothing" unless clicked_on_image || !$level_1_start #Uncomment for debbuging
  huh.play unless clicked_on_image || !$level_1_start
end
end

# Level 1 machinations

update do
  if $level_1_start
    if score_tracker
      score_tracker.remove
    end

    score_tracker = Text.new(
      "Turned away #{victory_counter} people!",
      font: "assets/Sealed.ttf",
      size: 20,
      color: "orange",
      y: 460,
      x: 500
    )

    if victory_counter < 60 # Number that equals the maximum amount of enemies that need to be clicked to win.
	   if victory_counter == 20 && !@part2bg
	      part1.remove
		  part2.add
		  @part2bg = true
	   end
	   if victory_counter == 40 && !@part3bg
	     part2.remove
		 part3.add
		 @part2bg = false
		 @part3bg = true
	   end
      if Time.now >= @next_image_time
        selected_image = everyone.sample
		# puts "the image selected is #{selected_image}" #Uncomment for debbuging
        if selected_image && !displayed_images.include?(selected_image)
		 # puts "the image should be different" #Uncomment for debbuging
          # Randomize the image location
          random_x = rand(0..(WINDOW_WIDTH - selected_image.width))
          random_y = rand(0..(WINDOW_HEIGHT - selected_image.height))

          selected_image.x = random_x
          selected_image.y = random_y

          # puts "Showing image: #{selected_image.path}"  # Debugging: log the image path
          selected_image.add
          displayed_images << selected_image
		   if displayed_images.count > 3 || missclicks == 3 # Game over conditions - first one checks how many images are on screen and the second how many missclicks you've done
		     victory_counter = 0
			 part1.remove
			 part2.remove
			 part3.remove
			 @part2bg = false
		     @part3bg = false
			 score_tracker.remove
			 $lose_screen = true
			 lvl1.stop
			 @lvl1_playing = false
			 displayed_images.each do |image|
			    image.remove
				end
			 displayed_images = []
			 death.play
			 sleep(8)
			 @game_over_mus = true
		     $level_1_start = false
			 end
        else
         # puts "No image to show"  # Debugging: in case the sample returns nil
		  @next_image_time = 0
        end
        @next_image_time = Time.now + 1 + rand(3)  # Set the time for the next image
      end
    else
	  part1.remove
	  part2.remove
	  part3.remove
      $JOTime = true
      @peter_playing = true
      $level_1_start = false
      score_tracker.remove
    end
  end

  if $JOTime
#    part3.remove
    if @lvl1_playing
      lvl1.stop
      @lvl1_playing = false
    end
	if !@youdidit
	   imhome.play
	   sleep(6)
	   @youdidit = true
	end
    if @peter_playing
     # puts "Starting peter music" #Uncomment for debbuging
      peter.play
      @peter_playing = false
    end
    victory.add
    wife.add
	victory_text.add
  end
  
  if $lose_screen
    displayed_images = [].compact
    lose_text.add
	lose_text2.add
	    if @lvl1_playing
      lvl1.stop
      @lvl1_playing = false
    end
    if @game_over_mus
      puts "Starting game over music"
      game_over.play
      @game_over_mus = false
    end
	end
	end
	  
	  # To exit the game over screen


# Show the window
show
