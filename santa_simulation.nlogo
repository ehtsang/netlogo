breed [snowflakes snowflake]
breed [reindeers reindeer]
breed [houses house]
breed [trees tree]
breed [santas santa]
breed [presents present]
breed [meanies meanie]

globals [presents-stolen]

to set-up
  ca
  reset-ticks
  cro numb-turtles [set heading 0 set xcor random-xcor set ycor 0 - abs random-ycor]
end 
  
to wiggle
  fd 0.1 
  rt 3
  lt 3
end


to tree-basic [n]
  pd
   ifelse n = 1
   [fd branchLength
      ;hatch 1 [pu set color pink set shape "leaf" set heading 180]
       bk branchLength]

   [fd branchLength lt angle tree-basic ( n - 1 ) 
     rt ( 2 * angle ) tree-basic ( n - 1)
    ; hatch 1 Fix this such that it hatches the turtles at the edges
     lt angle 
     bk branchLength]
end
  
to make-basic-tree
 ; set-up
  ask turtles [tree-basic depth]
end

;The max angle should be less than 40.

;WAVING TREE IN THE WIND

to waving-tree 
  ask turtles [
  trial-dos-tree depth angle branchSize branchLength
]
  cd
 ask turtles [
  rt random 3 lt random 3 trial-dos-tree depth angle branchSize branchLength

  ] 
 wait 1 / 30
 tick
end

to better-tree [n a branch]
  pd
  set pen-size branch
  ;rt random 3 lt random 3
  if-else n = 1
  [fd branch  
    bk branch]
  [fd branch lt a
    better-tree n - 1 (a - (random a / 4) + (random a / 4) ) ( branch * 0.75 )
    rt ( 2 * a) 
    better-tree n - 1 (a - (random a / 4) + (random a / 4) ) ( branch * 0.75 )
    lt a
    bk branch ]
end
    ;Not random enough!!!!
    
;LOOK UP TICKS

;Here, I tried using hatch because I thought it would not work otherwise.
to trial-tree [n a branch]
  pd
  set pen-size branch
  ;rt random 3 lt random 3
  if-else n = 1
  [fd branch  
    bk branch]
  [fd branch 
    lt a
    hatch 1 [ rt 2 * a trial-tree n - 1 (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) ) ( branch * random-float 1 + .7 ) die]   ; I made everything random. Now this is the opposite of the problem we had before. Now its too random.
    trial-tree n - 1 (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) ) ( branch * random-float 1 + .7 )                           ;Edward ples
    rt a
    bk branch ]
end

;In reality however, it does work without hatch. I also used the wrong variables for my code.
to trial-dos-tree [n a branchw branchl]
  set hidden? true
  set color brown
  pd
  set pen-size branchw
  if-else n = 1
  [fd branchl
    ;hatch 1 [pu set color green set shape "leaf" set heading 180 stamp die] I originally thought I needed hatch for leaves, but after experimenting and collaborating a bit, I figured out we didn't need it.
    
    ifelse season = "Winter"
    [set shape "sheep"
      set color white]
    [
      set shape "leaf"
      if season = "Spring"
      [set color 10 * (random 2 + 12) + (random 5 + 5)]
      if season = "Summer"
      [set color 10 * (random 2 + 5) + (random 3 + 4)]
      if season = "Fall"
      [set color 10 * (random 3 + 1) + (random 4 + 3)]
    ]      ;Zicheng Zhen helped me fix my original randomized color with this. 
           ;Richard Lin helped improve on the idea by adding seasons.
           ;It takes advantage of the multiples of the "basic" colors.
    stamp
    ;set color green set shape "leaf" stamp 
    set color brown set shape "default"
    bk branchl]
  [fd branchl lt a
    trial-dos-tree 
    n - 1 
    (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) )
    ( branchw * random-float 1 + .7 ) 
    (branchl * random-float 1 + .4)
  rt ( 2 * a)
  trial-dos-tree
  n - 1 
  (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) ) 
  ( branchw * random-float 1 + .7 ) 
  (branchl * random-float 1 + .4)
  lt a
  bk branchl ]
end


;Sheep=Snow now.

to trial-tres
  ca
  reset-ticks
  cro 4 [set heading 0 set xcor random-xcor set ycor 0 - abs random-ycor]
  winter depth angle branchSize branchLength 
  spring depth angle branchSize branchLength
  summer depth angle branchSize branchLength
  fall depth angle branchSize branchLength
end
;IT TOOK FOUR PEOPLE, BUT FOUR SEASONS. 

to winter  [n a branchw branchl]
  ask turtle 0 [set hidden? true
    set color brown
    pd
    set pen-size branchw
    if-else n = 1
    [fd branchl
      set shape "sheep"
      set color white
      stamp
      set color brown set shape "default"
      bk branchl]
    [fd branchl lt a
      winter
      n - 1 
      (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) )
      ( branchw * random-float 1 + .7 ) 
      (branchl * random-float 1 + .4)
    rt ( 2 * a)
    winter
    n - 1 
    (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) ) 
    ( branchw * random-float 1 + .7 ) 
    (branchl * random-float 1 + .4)
    lt a
    bk branchl ]
  ]
end
  
to spring [n a branchw branchl]
  ask turtle 1 [set hidden? true
    set color brown
    pd
    set pen-size branchw
    if-else n = 1
    [fd branchl
      set shape "leaf"
      set color 10 * (random 2 + 12) + (random 5 + 5)
      stamp
      set color brown set shape "default"
      bk branchl]
    [fd branchl lt a
      spring
      n - 1 
      (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) )
      ( branchw * random-float 1 + .7 ) 
      (branchl * random-float 1 + .4)
    rt ( 2 * a)
    spring
    n - 1 
    (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) ) 
    ( branchw * random-float 1 + .7 ) 
    (branchl * random-float 1 + .4)
    lt a
    bk branchl ]
  ]
end
  
to summer [n a branchw branchl]
  ask turtle 2 [set hidden? true
    set color brown
    pd
    set pen-size branchw
    if-else n = 1
    [fd branchl
      set shape "leaf"
      set color 10 * (random 2 + 5) + (random 3 + 4)
      stamp
      set color brown set shape "default"
      bk branchl]
    [fd branchl lt a
      summer 
      n - 1 
      (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) )
      ( branchw * random-float 1 + .7 ) 
      (branchl * random-float 1 + .4)
    rt ( 2 * a)
    summer
    n - 1 
    (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) ) 
    ( branchw * random-float 1 + .7 ) 
    (branchl * random-float 1 + .4)
    lt a
    bk branchl ]
  ]
end
  
to fall [n a branchw branchl]
  ask turtle 3 [set hidden? true
    set color brown
    pd
    set pen-size branchw
    if-else n = 1
    [fd branchl
      set shape "leaf"
      set color 10 * (random 3 + 1) + (random 4 + 3)
      stamp
      set color brown set shape "default"
      bk branchl]
    [fd branchl lt a
      fall 
      n - 1 
      (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) )
      ( branchw * random-float 1 + .7 ) 
      (branchl * random-float 1 + .4)
    rt ( 2 * a)
    fall
    n - 1 
    (a - (random a / (random 5 + 1)) + (random a / (random 5 + 1)) ) 
    ( branchw * random-float 1 + .7 ) 
    (branchl * random-float 1 + .4)
    lt a
    bk branchl ]
  ]
end


;WHY ARE THESE DIFFERENT?
;ifelse (random 3) = 2 [
;  set color yellow 
;  set shape "leaf"
;  stamp
;]
;  [set color (random 2) * 10 + 15
;set shape "leaf"
;stamp]

;if (random 3) = 0
;           [set color red set shape "leaf" stamp]
;    if (random 3) = 1
;           [set color yellow set shape "leaf" stamp]
;    if (random 3) = 2
;           [set color orange set shape "leaf" stamp]


;if-else vs ifelse?

;Parts of this code could not have been created without the help and emotional support of:
;Mr. Konstantinovich for introducing me to ticks.
;Zicheng Zhen of Mr. Brown Mykolyk Period 10 for discussing with me different ways to make the code "better".
;Richard Lin of Mr. Konstantinovich Period 1 for looking over my code and exchanging ideas with me.
;Grace Wu of Mr. Konstantinovich Period 2 for exchanging ideas with me.



;THE SANTA SIMULATOR 2k14

to setup-game
  ca
  background
  create-snow
  create-city
  create-forest
  create-santas 1 [
    set heading 90
    set color grey
    set shape "sleigh 1"
    set size 10
    setxy -15 15
  ]
  summon-the-deer
  ask reindeers [pu
    create-link-with santa 109 [
      set color black
    ]
  ]
  cro 30 [
    set shape "person" 
    ifelse random 2 = 0
      [set heading 90]
      [set heading 270]
    set color random count turtles 
    setxy random-xcor -14]
  reset-ticks
  if Grinch? = true 
  [summon-grinch]
end

to summon-the-deer
  ask turtles with [shape = "sleigh 1"] 
  [hatch-reindeers 1 [set size 5 set pen-size 2 set shape "deer" set heading 90 fd 2 set color black fd 8 set color black 
    hatch-reindeers 1 [set color black fd 5 set color black 
      hatch-reindeers 1 [set color black fd 5 set color black 
        hatch-reindeers 1 [set color black fd 5 set color black 
          hatch-reindeers 1 [set color black fd 5 set color red]
        ]
      ]
    ]
  ]
  ]
end

to background
  ask patches with [pycor <= -18] [set pcolor brown - 4]
  ask patches with [pycor > -18] [set pcolor blue - 3]
  ask patches with [pycor = -15 or pycor = -16 or pycor = -17] [set pcolor white]
end

to create-snow
  create-snowflakes 100 [
    set heading 180 + speed
    set shape "circle" 
    set size 0.5 
    set color white
    setxy random-xcor random-ycor
    if ycor <= -15 
    [set hidden? true]
  ]
end

to create-city
  create-houses 1 [set xcor -24]
  create-houses 1  [set xcor -12]
  create-houses 1  [set xcor 0]
  create-houses 1  [set xcor 12]
  create-houses 1  [set xcor 24]
  ask houses [set heading 270 set ycor -15 set shape "house 1"set size 5]
end

to create-forest
  create-trees 1  [set xcor -18]
  create-trees 1  [set xcor -6]
  create-trees 1  [set xcor 6]
  create-trees 1  [set xcor 18]
  ask trees [set heading 0 set ycor -15 trial-dos-tree depth angle branchSize branchLength ]
end

to wiggle-game
  fd random-float .03 + .005 
  set heading random 180 + 90
end

to snow-drop
  ask snowflakes [
    pu
    wiggle-game
    if ycor >= -15 
    [set hidden? false]
    if ycor < -15
    [set hidden? true]
  ]
end

to santa-move
  ask santas [fd speed / 160]
  ask reindeers [fd speed / 160]
end

to civilians-move
  ask turtles with [shape = "person"]
  [fd speed / 640]
end

to santa-suprise 
  ask santas
    [ ifelse random 2 = 0 
      [hatch-presents 1 [set label " " set shape "present 1" set heading 180 set size 2]]
      [hatch-presents 1 [set label " " set shape "present 2" set heading 180 set size 2]]
    ifelse random 2 = 0 
    [set label "Ho ho ho!"]
    [set label "Merry Christmas!"]
    ]
  ask meanies [
    ifelse random 2 = 0
    [set label "Curse you evil presents of happiness!"]
    [set label "Darn you Santa!"]
  ]
end

to surprise-move
  ask presents [
    if ycor > -14
    [fd 0.2]
  ]
end

to bye-presents
  every 6 [ask presents with [ycor <= -14] [die]]
  every 3 [ask santas [set label " "]]
  every 3 [ask meanies [set label " "]]
end 

to summon-grinch
  create-meanies 1 [set shape "grinch" setxy 15 5 set size 5 lt 90]
end

to grinch-ruins-christmas
  ask meanies [
    ask other presents in-radius (size / 2) 
    [set presents-stolen presents-stolen + 1
      die
    ]
  ]
end

to grinch-fd
  ask meanies [set heading 0 fd player-speed]
end

to grinch-bk
  ask meanies [set heading 180 fd player-speed]
end

to grinch-left
  ask meanies [set heading 270 fd player-speed]
end

to grinch-right
  ask meanies [set heading 90 fd player-speed]
end

to no-hand
  ask meanies [set heading 270 fd player-speed]
end 
  

to go
 snow-drop
 every 10 [cd ask trees [set heading 0 set ycor -15 trial-dos-tree depth angle branchSize branchLength ]]
 ask houses [fd speed / 160]
 every 2 [ask reindeers [set shape "deer 2"]]
 every 1 [ask reindeers [set shape "deer"]]
 santa-move 
 every 2 [santa-suprise]
 bye-presents
 surprise-move
 civilians-move
 grinch-ruins-christmas
 if No-hands? = true
 [no-hand]
 tick
 wait 1 / 30
end
@#$#@#$#@
GRAPHICS-WINDOW
210
10
1065
678
32
24
13.0
1
10
1
1
1
0
1
1
1
-32
32
-24
24
1
1
1
ticks
30.0

SLIDER
22
348
194
381
branchLength
branchLength
0
10
1.7
0.1
1
NIL
HORIZONTAL

SLIDER
23
387
195
420
angle
angle
0
90
25
1
1
NIL
HORIZONTAL

BUTTON
90
32
196
65
Basic Tree
make-basic-tree\n\n
NIL
1
T
OBSERVER
NIL
N
NIL
NIL
1

SLIDER
22
311
194
344
depth
depth
0
20
8
1
1
NIL
HORIZONTAL

SLIDER
24
275
196
308
numb-turtles
numb-turtles
0
20
1
1
1
NIL
HORIZONTAL

BUTTON
14
79
116
112
Waving Tree
waving-tree
T
1
T
OBSERVER
NIL
D
NIL
NIL
1

BUTTON
14
30
78
63
Setup
set-up
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
15
118
115
151
Leafs Falling
ask turtles [\nif ycor >= 0\n[ ask turtle random count turtles [wiggle]\n]\n]\nwait 1 / 60 
T
1
T
OBSERVER
NIL
F
NIL
NIL
1

BUTTON
7
160
120
193
Better Tree
better-tree depth angle branchSize\n
NIL
1
T
TURTLE
NIL
B
NIL
NIL
1

SLIDER
23
423
195
456
branchSize
branchSize
0
10
5
0.1
1
NIL
HORIZONTAL

BUTTON
4
198
143
231
Trial Tree ples work
trial-tree depth angle branchSize
NIL
1
T
TURTLE
NIL
T
NIL
NIL
1

BUTTON
7
235
141
268
Trial Dos ples work
trial-dos-tree depth angle branchSize branchLength\n
NIL
1
T
TURTLE
NIL
M
NIL
NIL
1

CHOOSER
20
519
158
564
season
season
"Spring" "Summer" "Fall" "Winter"
3

BUTTON
25
471
106
504
PRETTTY
trial-tres
NIL
1
T
OBSERVER
NIL
P
NIL
NIL
1

BUTTON
1230
50
1338
83
Setup Game
setup-game
NIL
1
T
OBSERVER
NIL
F
NIL
NIL
1

BUTTON
1207
99
1302
132
Go
go
T
1
T
OBSERVER
NIL
G
NIL
NIL
1

SLIDER
1637
147
1809
180
speed
speed
1
90
90
1
1
NIL
HORIZONTAL

SLIDER
1633
216
1805
249
player-speed
player-speed
0
5
5
0.1
1
NIL
HORIZONTAL

BUTTON
1237
292
1315
325
Forward
grinch-fd
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

BUTTON
1245
337
1308
370
Back
grinch-bk\n
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
1165
338
1228
371
Left
grinch-left
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

BUTTON
1328
338
1391
371
Right
grinch-right
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

MONITOR
1156
167
1331
212
Number of Presents Stolen :'(
presents-stolen
17
1
11

SWITCH
1365
52
1468
85
Grinch?
Grinch?
0
1
-1000

TEXTBOX
1378
187
1528
229
The Grinch has modernized with his rocket-powered sled! Take that Santa!
11
0.0
1

TEXTBOX
1085
28
1208
80
Santa has been hitting the gym!
11
0.0
1

SWITCH
1359
102
1473
135
No-hands?
No-hands?
1
1
-1000

TEXTBOX
1493
103
1643
131
\"No-hands?\" is for automated Grinch movement.
11
0.0
1

TEXTBOX
22
584
172
612
\"season\" should be set to Winter for this simulation.
11
0.0
1

@#$#@#$#@
##PICTURES <3

Pretty Single Trees...
![Netlogo](http://i.imgur.com/j0IhzsP.jpg?1)
![Netlogo](http://i.imgur.com/AdUj5cY.png?1)

Found this to look nice...
![Netlogo](http://i.imgur.com/CXT3NLc.png?1)

For some odd reason the trees like the line y=-x...
![Netlogo](http://i.imgur.com/g2TtCpN.png?1)
![Netlogo](http://i.imgur.com/tB34MuI.png?1)

This one is quite interesting...
![Netlogo](http://i.imgur.com/tpI3Mxg.png?1)


##Game resources:

Deer:
![Netlogo](http://i.ebayimg.com/00/s/MTI1OFgxNjAw/z/L3UAAMXQfFJRWck5/$T2eC16JHJGsFFMtLsrjuBRWck4fL,!~~60_35.JPG)

Sleigh:
![Netlogo](http://cdn.vectorstock.com/i/composite/70,98/christmas-santa-sleigh-01-vector-1007098.jpg)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

bunny running
false
0
Polygon -7500403 true true 68 229 67 207 36 208 41 243 47 250 24 271 28 289 73 264 116 233 147 233 171 230 194 240 226 263 263 260 228 239 211 228 241 213 241 183 241 168 226 153 256 153 271 138 271 123 256 108 235 82 237 87 231 88 221 88 210 102 192 116 181 123 166 138 151 138 130 162 91 172 66 194 68 220
Polygon -7500403 true true 236 89 236 74 206 0 206 29 208 73 177 29 144 13 162 56 184 90 191 119
Rectangle -2064490 true false 255 120 270 135
Circle -16777216 true false 213 93 22

bunny trial
false
0
Polygon -7500403 true true 61 245 50 224 46 245 23 231 58 266 69 270 91 275 151 275 136 260 151 260 166 245 181 260 211 275 241 275 211 245 211 230 241 215 241 185 241 170 226 155 256 155 271 140 271 125 256 110 235 84 237 89 231 90 221 90 210 104 192 118 181 125 166 140 151 140 130 164 91 174 66 196 61 245
Polygon -7500403 true true 236 89 236 74 206 0 206 29 208 73 177 29 144 13 162 56 184 90 191 119
Rectangle -2064490 true false 255 120 270 135
Circle -16777216 true false 213 93 22

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

deer
false
0
Polygon -6459832 true false 60 269 45 254 45 209 75 194 75 209 105 269 120 269 90 209 120 194 180 194 195 224 180 239 195 239 210 269 225 269 210 224 225 209 210 179 240 134 270 134 285 119 285 104 270 89 240 89 225 74 270 59 225 59 255 29 240 29 210 59 210 44 195 29 195 14 165 14 195 44 195 59 165 59 150 44 165 29 135 14 135 29 120 44 135 59 165 74 180 89 210 89 225 104 210 119 165 119 53 147 3 202 24 199 30 254 30 269 60 269
Rectangle -7500403 true true 285 105 300 120
Rectangle -16777216 true false 255 105 270 120
Circle -1 true false 53 160 15
Circle -1 true false 94 139 13
Circle -1 true false 113 157 17
Circle -1 true false 82 160 17
Circle -1 true false 133 133 17
Circle -1 true false 149 165 17
Circle -1 true false 175 132 17
Circle -1 true false 182 161 17
Circle -1 true false 200 141 17

deer 2
false
0
Polygon -6459832 true false 13 281 28 251 43 220 73 205 73 220 43 266 58 266 88 220 118 205 178 205 193 235 193 251 193 250 208 280 223 280 208 235 208 221 208 190 238 145 266 166 279 163 283 141 271 112 238 100 223 85 269 100 244 75 282 78 279 60 225 67 240 54 224 37 224 20 200 22 206 37 214 62 184 61 161 52 186 34 179 6 165 32 141 32 150 66 163 85 187 87 208 100 223 115 208 130 163 130 51 158 1 213 22 210 13 251 -2 281 28 281
Circle -1 true false 53 160 15
Circle -1 true false 94 139 13
Circle -1 true false 113 157 17
Circle -1 true false 82 160 17
Circle -1 true false 133 133 17
Circle -1 true false 149 165 17
Circle -1 true false 175 132 17
Circle -1 true false 182 161 17
Circle -1 true false 200 141 17
Polygon -6459832 true false 199 193 244 253 259 238 229 193 199 178
Polygon -6459832 true false 268 131 256 143
Polygon -16777216 true false 264 128 253 140 264 149 274 140 263 126
Polygon -7500403 true true 281 155 270 167 279 175 289 165 280 155

dot
false
0
Circle -7500403 true true 90 90 120

egg
false
0
Circle -7500403 true true 96 76 108
Circle -7500403 true true 72 104 156
Polygon -7500403 true true 221 149 195 101 106 99 80 148

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

grinch
false
0
Line -7500403 true 165 210 60 210
Rectangle -7500403 true true 255 105 270 105
Polygon -7500403 true true 135 45 135 60
Polygon -7500403 true true 285 105 210 105 180 150 165 210 60 210 45 195 30 135 15 120 30 195 60 240 225 240 255 135 285 105
Polygon -6459832 true false 285 105 255 135 210 150 165 210 180 150 210 105 285 105
Polygon -13840069 true false 255 135 225 240 60 240 30 195 15 120 30 135 45 195 60 210 165 210 210 150 255 135
Rectangle -2674135 true false 120 105 120 165
Circle -13840069 true false 84 99 42
Polygon -1 true false 105 135 120 150 90 150 105 135
Polygon -2674135 true false 120 150 135 180 120 180 120 165 105 150 90 165 90 180 75 180 90 150
Polygon -2674135 true false 105 165 120 150 105 150 105 165 90 150 105 150
Polygon -7500403 true true 120 165 105 165 120 150 105 165 90 165 105 165
Polygon -1 true false 120 165 105 165 90 165 105 150 120 165
Polygon -2674135 true false 105 165 120 195 105 195 90 195 105 165
Polygon -1 true false 120 195 135 210 120 210 105 195 90 210 75 210 90 195
Polygon -7500403 true true 75 105 135 105
Polygon -1 true false 135 90 135 105 75 105 75 90 135 90
Polygon -2674135 true false 120 90 105 45 90 90
Circle -1 true false 90 30 30
Polygon -6459832 true false 210 240 225 255 240 270
Polygon -6459832 true false 195 240 210 255 240 270 210 270 195 255 180 240 195 240
Polygon -6459832 true false 105 240 90 240 75 255 45 270 75 270 105 240
Polygon -6459832 true false 270 255 255 270 45 270 30 255 15 225 0 165 15 255 30 270 45 285 240 285 255 285 285 240 270 255
Polygon -2674135 true false 115 166 114 184 97 182 95 165
Polygon -1184463 true false 240 180 225 210 255 210 255 180 240 180
Polygon -2674135 true false 254 184 279 175 272 192 287 186 281 199 289 209 275 202 275 216 257 208
Polygon -2674135 true false 255 195 256 207 256 201 258 210 257 201
Polygon -2674135 true false 259 209 256 209 255 174
Polygon -955883 true false 258 193 268 187 273 200 258 203 255 194

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

house 1
false
0
Rectangle -2674135 true false 45 150 240 285
Polygon -7500403 true true 30 150 270 150 135 45 15 150 30 150
Rectangle -1 false false 75 195 105 225
Rectangle -1 false false 165 195 195 225
Rectangle -6459832 true false 120 240 150 285
Line -1 false 75 210 105 210
Line -1 false 90 195 90 225
Line -1 false 165 210 195 210
Line -1 false 180 195 180 225
Rectangle -1 false false 105 105 165 135
Line -1 false 105 120 165 120
Line -1 false 135 105 135 135
Rectangle -6459832 false false 75 60 75 90
Polygon -6459832 true false 75 60 75 90 75 105 90 90 90 60 75 60
Polygon -1 true false 60 60 75 60 85 52 86 43 75 28 59 27 45 32 41 39 47 49 60 63

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

leaf 2
false
0
Rectangle -7500403 true true 144 218 156 298
Polygon -7500403 true true 150 263 133 276 102 276 58 242 35 176 33 139 43 114 54 123 62 87 75 53 94 30 104 39 120 9 155 31 180 68 191 56 216 85 235 125 240 173 250 165 248 205 225 247 200 271 176 275

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

present 1
false
0
Rectangle -13840069 true false 45 45 255 255
Polygon -2674135 true false 151 46 112 16 81 4 44 18 46 34 76 38 149 46
Polygon -2674135 true false 151 45 190 15 221 3 258 17 256 33 226 37 153 45
Rectangle -2674135 true false 45 135 255 165
Rectangle -2674135 true false 135 45 165 255

present 2
false
0
Rectangle -2674135 true false 45 45 255 255
Polygon -13840069 true false 151 46 112 16 81 4 44 18 46 34 76 38 149 46
Polygon -13840069 true false 151 45 190 15 221 3 258 17 256 33 226 37 153 45
Rectangle -13840069 true false 45 135 255 165
Rectangle -13840069 true false 135 45 165 255

rabbit
false
0
Polygon -7500403 true true 61 150 76 180 91 195 103 214 91 240 76 255 61 270 76 270 106 255 132 209 151 210 181 210 211 240 196 255 181 255 166 247 151 255 166 270 211 270 241 255 240 210 270 225 285 165 256 135 226 105 166 90 91 105
Polygon -7500403 true true 75 164 94 104 70 82 45 89 19 104 4 149 19 164 37 162 59 153
Polygon -7500403 true true 64 98 96 87 138 26 130 15 97 36 54 86
Polygon -7500403 true true 49 89 57 47 78 4 89 20 70 88
Circle -16777216 true false 37 103 16
Line -16777216 false 44 150 104 150
Line -16777216 false 39 158 84 175
Line -16777216 false 29 159 57 195
Polygon -5825686 true false 0 150 15 165 15 150
Polygon -5825686 true false 76 90 97 47 130 32
Line -16777216 false 180 210 165 180
Line -16777216 false 165 180 180 165
Line -16777216 false 180 165 225 165
Line -16777216 false 180 210 210 240

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

sleigh 1
false
0
Line -7500403 true 135 210 240 210
Rectangle -7500403 true true 30 105 45 105
Polygon -7500403 true true 165 45 165 60
Polygon -7500403 true true 15 105 90 105 120 150 135 210 240 210 255 195 270 135 285 120 270 195 240 240 75 240 45 135 15 105
Polygon -1184463 true false 15 105 45 135 90 150 135 210 120 150 90 105 15 105
Polygon -2674135 true false 45 135 75 240 240 240 270 195 285 120 270 135 255 195 240 210 135 210 90 150 45 135
Rectangle -2674135 true false 180 105 180 165
Circle -7500403 true true 174 99 42
Polygon -1 true false 195 135 180 150 210 150 195 135
Polygon -2674135 true false 180 150 165 180 180 180 180 165 195 150 210 165 210 180 225 180 210 150
Polygon -2674135 true false 195 165 180 150 195 150 195 165 210 150 195 150
Polygon -7500403 true true 180 165 195 165 180 150 195 165 210 165 195 165
Polygon -1 true false 180 165 195 165 210 165 195 150 180 165
Polygon -2674135 true false 195 165 180 195 195 195 210 195 195 165
Polygon -1 true false 180 195 165 210 180 210 195 195 210 210 225 210 210 195
Polygon -7500403 true true 225 105 165 105
Polygon -1 true false 165 90 165 105 225 105 225 90 165 90
Polygon -2674135 true false 180 90 195 45 210 90
Circle -1 true false 180 30 30
Polygon -6459832 true false 90 240 75 255 60 270
Polygon -6459832 true false 105 240 90 255 60 270 90 270 105 255 120 240 105 240
Polygon -6459832 true false 195 240 210 240 225 255 255 270 225 270 195 240
Polygon -6459832 true false 30 255 45 270 255 270 270 255 285 225 300 165 285 255 270 270 255 285 60 285 45 285 15 240 30 255
Rectangle -13840069 true false 15 75 45 105
Line -2674135 false 15 90 45 90
Line -2674135 false 30 75 30 105
Line -2674135 false 30 75 15 60
Line -2674135 false 30 75 45 60
Rectangle -2674135 true false 60 75 90 105
Line -13840069 false 60 90 90 90
Line -13840069 false 75 75 75 105
Line -13840069 false 60 60 75 75
Line -13840069 false 75 75 90 60
Polygon -2674135 true false 185 166 186 184 203 182 205 165

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wind swirl 2
true
0
Rectangle -7500403 true true 30 195 255 210
Rectangle -7500403 true true 255 105 270 195
Rectangle -7500403 true true 180 90 255 105
Rectangle -7500403 true true 165 105 180 165
Rectangle -7500403 true true 180 165 225 180
Rectangle -7500403 true true 225 135 240 165
Rectangle -7500403 true true 195 120 225 135
Polygon -7500403 true true 180 90 165 105 180 105 180 90 165 105 180 105 180 90 180 105
Polygon -7500403 true true 180 90 165 105 180 105 180 90
Polygon -7500403 true true 165 165 180 180 180 165
Polygon -7500403 true true 255 90 255 105 270 105
Polygon -7500403 true true 225 120 240 135 225 135
Polygon -7500403 true true 225 165 225 180 240 165
Polygon -7500403 true true 255 195 255 210 270 195

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270

@#$#@#$#@
NetLogo 5.0.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180

@#$#@#$#@
0
@#$#@#$#@
