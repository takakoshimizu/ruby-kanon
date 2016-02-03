# KANON INTRO VIDEO PROJECT
# I WILL REMAKE THE KANON INTRO IN MY SHITTY ENGINE
# THIS WILL OBVIOUSLY MEAN IT'S AWESOME

setup:
  background "white"
  
  # create images for the first segment of the op (tree roll)
  image _kanon_ "kanon/001" 0 0 hidden
  image tree "kanon/002" 0 -885 hidden
  image presented_by "kanon/003" 0 0 hidden
  image key "kanon/004" 0 0 hidden
  image logo "kanon/005" 0 0 hidden
  
  # create images for nayuki's segment
  image nayukibw "kanon/006" 0 0 hidden
  image nayukicolor "kanon/007" 0 0 hidden
  image nayukiquote "kanon/008" 0 0 hidden
  image nayukiname "kanon/009" 0 0 hidden
  
  # create images for Shiori's segment
  image shioribw "kanon/010" 0 0 hidden
  image shioricolor "kanon/011" 0 0 hidden
  image shioriquote "kanon/012" 0 0 hidden
  image shioriname "kanon/013" 0 0 hidden
  
  # create images for Makoto's segment
  image makotobw "kanon/014" 0 0 hidden
  image makotocolor "kanon/015" 0 0 hidden
  image makotoquote "kanon/016" 0 0 hidden
  image makotoname "kanon/017" 0 0 hidden
  
  # create images for Mai's segment
  image maibw "kanon/018" 0 0 hidden
  image maicolor "kanon/019" 0 0 hidden
  image maiquote "kanon/020" 0 0 hidden
  image mainame "kanon/021" 0 0 hidden
  
  # create images for the poor characters
  # who weren't fortunate enough to have
  # their own section
  image kaori "kanon/022" 0 0 hidden
  image sayuri "kanon/023" 0 0 hidden
  image mishio "kanon/024" 0 0 hidden
  image akiko "kanon/025" 0 0 hidden
    
  # finally, what's the Kanon op without Last Regrets?
  music last_regrets "last_regrets"
  
  # for the record, none of these images are loaded until
  # they are used

scene:
  # turn off the text frame and set the window title
  toggle frame
  caption "Kanon in Ruby"

  # and get those beautiful sounds rolling
  play last_regrets
  wait 1.0
    
  # display the simple "Kanon" title
  display _kanon_ 0.2
  wait 3.0
  undisplay _kanon_ 0.8
  wait 0.8
  
  # show the tree and begin to pan up--
  # stop, and wait for the key
  display tree 0.5
  wait 2.0
  pan tree 0 -500 14
  wait 13.5
  undisplay tree 0.5
  
  # presented by...
  display presented_by 0.3
  wait 1.5
  undisplay presented_by 0.3
  wait 0.5
  
  # key~
  display key 0.3
  wait 1.5
  undisplay key 0.3
  wait 0.5
  
  # continue the tree pan
  display tree 0.5
  pan tree 0 0 15.5
  wait 16.0
  
  # and now replace the top with the title screen
  display logo 0.0
  undisplay tree 1.0
  wait 1.0
  
  undisplay logo 0.3
  wait 0.3
  
  # BEGIN SEXY GIRLS HERE
  display nayukibw 1.0
  wait 1.0
  
  display nayukicolor 1.0
  wait 1.0
  undisplay nayukibw 1.0
  wait 0.5
  undisplay nayukicolor 0.5
  
  wait 0.5
  
  display nayukiquote 1.0
  wait 1.5
  undisplay nayukiquote 0.5
  wait 0.5
  
  
  display nayukiname 1.5
  wait 4.0
  undisplay nayukiname 1.0
  wait 1.0

  # BEGIN CUTE GIRLS HERE
  display shioribw 1.0
  wait 1.0
  
  display shioricolor 1.0
  wait 1.0
  undisplay shioribw 1.0
  wait 0.5
  undisplay shioricolor 0.5
  
  wait 0.5
  
  display shioriquote 1.0
  wait 1.5
  undisplay shioriquote 0.5
  wait 0.5
  
  display shioriname 1.5
  wait 4.0
  undisplay shioriname 1.0
  wait 1.0
  
  # BEGIN STUPID GIRLS HERE
  display makotobw 1.0
  wait 1.0
  
  display makotocolor 1.0
  wait 1.0
  undisplay makotobw 1.0
  wait 0.5
  undisplay makotocolor 0.5
  
  wait 0.5
  
  display makotoquote 1.0
  wait 1.5
  undisplay makotoquote 0.5
  wait 0.5
  
  display makotoname 1.5
  wait 4.0
  undisplay makotoname 1.0
  wait 1.0
  
  # BEGIN QUIET GIRLS HERE
  display maibw 1.0
  wait 1.0

  display maicolor 1.0
  undisplay maibw 0.5
  wait 1.0
  wait 0.5
  undisplay maicolor 0.5

  wait 0.5

  display maiquote 1.0
  wait 1.5
  undisplay maiquote 0.5
  wait 0.5

  display mainame 1.5
  wait 4.0
  undisplay mainame 0.5
  wait 0.5
  
  display kaori 0.5
  wait 0.5
  undisplay kaori 0.5
  display sayuri 0.5
  wait 0.5
  undisplay sayuri 0.5
  display mishio 0.5
  wait 0.5
  undisplay mishio 0.5
  display akiko 0.5
  wait 0.5
  undisplay akiko 0.5
  
  
  wait 5
  exit