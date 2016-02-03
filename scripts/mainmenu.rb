setup:
  background "nayuki_scene/snow"
  character Narrator {}
  character Yuuichi {}
  character Girl {}
  character Nayuki {}
  
  image nayuki "nayuki_scene/nayuki" 0 0 hidden
  image nayuki_smile "nayuki_scene/nayuki_smile" 0 0 hidden
  
  music opening "opening"

scene:
  caption "Kanon"
  play opening
  
  Narrator "It's snowing."
  Narrator "Pure white snow is swirling down from the overcast sky."
  Narrator "A damp wooden bench. Cold, clear air."
  Yuuichi "......"
  Narrator "I rouse my body, slumped on the bench, and correct my posture yet again."
  Narrator "The stream of people leaving the snow-covered station has slowed to a trickle."
  Narrator "Sighing white vapor, I glance at the town clock in the station plaza. It's three o'clock."
  Narrator "It's still daylight, but I can only guess at the position of the sun beyond the thick clouds."
  Yuuichi "...late."
  Narrator "I slump back into my seat and cast the single word into the sky."
  Narrator "I'm briefly blinded by its white mist, before the north wind sends it streaming away."
  Narrator "A winter wind, piercing my skin..."
  Narrator "The ever-present snow, falling without end..."
  Narrator "The screen of white flakes which hides the sky seems to be thickening out of spite."
  Narrator "Once again, the sky I stare into is disturbed by a sigh."
  Narrator "Something gradually moves between us."
  
  display nayuki 0.5
  wait 1.0
  
  Girl "......"
  Narrator "A girl is peering at my face, blocking my view as though to hide the snowy clouds from me."
  Girl "You've got snow on your head."
  Narrator "I breathe out sharply through tight lips, expelling another cloud of vapor."
  Yuuichi "That might be because I've been waiting for two hours..."
  Narrator "It's the nature of snow to pile up."
  Girl "...huh?"
  Narrator "The girl tilts her head curiously at my words."
  Girl "What time is it?"
  Yuuichi "Three o'clock."
  Girl "Really? Already?"
  Narrator "Despite her words, she doesn't look at all surprised."
  Narrator "Her voice is slow, feminine, and sleepy."
  Girl "I thought it was still about two."
  Narrator "Which would only have been one hour late."
  Girl "Can I ask you something?"
  Yuuichi "...'kay."
  Girl "Aren't you cold?"
  Yuuichi "Too right."
  Narrator "The snow was a novelty at first, but now it's just depressing me."
  Girl "Here."
  Narrator "She hands me a can of coffee."
  Girl "To make up for me being late."
  Girl "And..."
  Girl "...to celebrate our meeting again."
  Yuuichi "Is a reunion after seven years only worth one can of coffee?"
  Narrator "I look again into the girl's face as I take the coffee."
  Narrator "The can is still too hot to hold with bare hands."
  Narrator "My numb fingertips appreciate the warmth."
  Girl "Seven years... has it been that long?"
  Yuuichi "Yeah."
  Narrator "Rolling the warm can between my hands..."
  Narrator "Superimposing the snowy landscapes of my childhood, which I thought I had forgotten..."
  Girl "Do you remember my name?"
  Yuuichi "Come to that, do you remember mine?"
  Girl "Of course!"
  Narrator "In the snow..."
  Narrator "In the snow-painted street..."
  Narrator "That time seven years ago... it seems only to be a breath away."
  Girl "Yuuichi."
  Yuuichi "Hanako."
  Girl "No--!"
  Yuuichi "Jirou?"
  Girl "I'm a girl..."
  Narrator "She adopts a worried frown."
  Narrator "Each word, like the snow which covers the ground, is filling the blank spaces of my memory."
  Narrator "The snow falling past the girl's shoulders is getting even heavier."
  Yuuichi "Okay, maybe we've wasted enough time chatting."
  Girl "But... my name..."
  Yuuichi "Shall we make a move?"
  Girl "My name..."
  Narrator "The town of seven years ago..."
  Narrator "Surrounded by the snow of seven years ago..."
  Yuuichi "Let's go, Nayuki."
  Narrator "My new life, caught in the winter wind, spreads out before me."
  Nayuki "Eh...?"
  
  undisplay nayuki 0.5
  display nayuki_smile 0.5
  wait 1.0
  
  Nayuki "Sure!"
  
  wait 1.5
    
  scene intro