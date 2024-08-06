# Zip-Gun-Bop

## Prerequisites
  You need to have Ruby 3.x installed in your computer to run this game, aside from that, you need to have the gem "ruby2d" installed as well.
  (for a no prerequisite, standalone version of the game visit: https://griimsoul.itch.io/stupidgame1)

## Plot
  You're ```[Insert Main Character Name]```, the bell just rang and you're free to go home from school.
  However, for some reason you can't explain, everyone seems to have a piece of you, and wont stop until you
  fall for them.
  You're already engaged to someone, and she'll probably leave you if you get caught by any of them.

  Now you have to use all of you weirdness and bravado to creep girls out, and flip off guys! (also some traps that are mixed in.)

## Controls

* ```SPACE``` is used to start the game
* ```P``` is used to return to the title
* ```RMB``` is used to click on guys (and traps!)
* ```LMB``` is used to click on girls
* (also try out the ```middle mouse button``` when you win!)

## Victory conditions

You have to make through 60 people (by default) to get home safely, there's someone waiting for you!


# Customizing

## Enemy images
  You can expand and modify all of arrays that store the images of the enemies you encounter.
  * ```girls``` (line 51)
  * ```guys```  (line 67)
  * ```traps```  (line 82)
Simply add the image to the assets folder and add it to the array. For example:

    ```[safe_image_load("assets/Guy1.png", width: 100, height: 400), ... safe_image_load("assets/Guy9.png", width: 100, height: 400) , safe_image_load("assets/nameOfImage.png", width: 100, height: 350)].compact```

Do note that you'll have to experiment with the width and height values for each picture, else they might either be too big, or too small on the screen.

## Voice Lines
  You can expand and modify all of the arrays that store the lines spoken by the main character and enemies.
  To do so simply drop a .mp3 file into the assets folder and add it to the array that you want it in.
  ### array list
  * ```r_guys_and_traps``` - Contains MC lines for males
  * ```f_guys_and_traps``` - Contains lines from male enemies
  * ```r_girls``` - Contains MC lines for girls
  * ```f_girls``` - Contains lines from female enemies

 ### Example
   [Sound.new("assets/ToGuy1.mp3"), ... Sound.new("assets/ToGuy10.mp3"), Sound.new("assets/yourFile.mp3")].compact

## Victory & Defeat Conditions
  ### Victory Conditions
  In line 405 there's a numeric value (by default 60) that you can modify to set the maximum amount of enemies you need     
   to click in order to win.
  ### Defeat Conditions
  In line 432 there's two conditions that you can modify to change the Game Over conditions.
  The first condition (```displayed_images.count > 3```) checks if the amount of images displayed exceeds 3, you can change this number to your liking. 
  The second condition (```missclicks == 3```) checks if you've incorrectly clicked an enemy 3 times, you can increase this number to allow for a more forgiving game.

# Usage
Use and modify this code as you please! My only request is that if you're gonna utilize it in a non-private / non-personal enviroment, that you credit me as the author of the code.
  
