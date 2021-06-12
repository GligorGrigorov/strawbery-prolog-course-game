?-
	G_X := 200,
	G_Y := 700,
	G_HEIGHT := 800,
	G_WIDTH := 400,
	G_SIZE := 20,
	G_RAND := 0,
	G_CURRENT := 0,
	G_GAME_OVER := 0,
	array(speeds, 10, 0),
	array(directions,10,0),
	array(ypos, 10, 0),
	array(xpos, 10, 0),
	window(title("Space"), size(G_WIDTH, G_HEIGHT), paint_indirectly), initialize.
initialize :-
	for(I,0,9),
		ypos(I):= I * 70,
		speeds(I) := random(10) + 1,
		G_RAND := random(2),
		(G_RAND =:= 0 ->
			directions(I) := -1
		else
			directions(I) := 1
		),
	fail.
win_func(paint):-
	text_out("Score: " + G_CURRENT, pos(20, 20)),
	pen(3, rgb(255, 0, 0)),
  	ellipse(G_X - G_SIZE, G_Y - G_SIZE,G_X, G_Y),
	pen(4, rgb(0,255,0)),
	for(I,0,9),
		(abs(G_X - xpos(I) - G_SIZE) =< G_SIZE ->
			(abs(G_Y - ypos(I) - G_SIZE) =< G_SIZE ->
			G_GAME_OVER := 1)
		),
		rect(xpos(I),ypos(I) mod G_Y,xpos(I) + 20, (ypos(I) mod G_Y) + 20),
	fail.

win_func(init) :-
    _ := set_timer(_, 0.03, time_func).

win_func(key_down(38, Repetition)) :- % up
	G_CURRENT := G_CURRENT + 1,
  	for(I,0,9),
		((ypos(I) + 5) mod G_Y < ypos(I) + 5 ->
			speeds(I) := speeds(I) + 1,
			ypos(I) := ypos(I) mod G_Y
		),
		ypos(I) := (ypos(I) + 5),
	fail.

win_func(key_down(40, Repetition)) :- % down
	G_CURRENT := G_CURRENT -1,
	for(I,0,9),
		ypos(I) := (ypos(I) - 5),
	fail.

update_objects(X) :-
	for(I, 0, 9),
		xpos(I) := (xpos(I) + directions(I) * speeds(I)) mod G_WIDTH,
	fail.
update_objects(_).

time_func(end) :-
	G_GAME_OVER =:= 0,
	update_objects(1),
	update_window(_).

