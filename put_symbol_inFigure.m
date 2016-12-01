function  put_symbol_inFigure(loc, s, k)
	% This function places a letter (symbol) s, with colour k
	% at location loc in a figure
	% loc = array of 1 x 2, with numbers between 0 and 1 (relative in figure),
	% first is x-coordinate, second is y-coordinate
	% s = string, e.g. 'X' or 'O'
	% k = string that gives the colour, e.g. 'g' or 'r'
    
	g=text(loc(1), loc(2), s);
	set(g, 'color', k);
    set(g, 'FontSize', 35);
end