function Treisman_exp( n, sort, target )
%% Treisman_exp function creates a figure with n objects, with or without a target for a disjunctive or conjunctive visual search
    % INPUT:
      % n = number of objects (target + distractors)
      % sort = 'c' of 'dcol' of 'dsym'
      % target = 0 or 1 (target is absent or present)   
      
    %% Input checks
    validateattributes(n,{'numeric'},{'nonempty','positive', 'integer', 'scalar'},mfilename,'Set Size',1)
    validateattributes(sort,{'char'},{'nonempty'},mfilename,'Type of Search',2)
    validateattributes(target,{'numeric'},{'nonempty', 'binary', 'scalar'},mfilename,'Target Present/Absent',3)
    
    %% Set up grids for plotting (Prevent Overlapping)
    locgrid(:,1) = repelem(linspace(.1,.9,30),1,15)';
    locgrid(:,2) = repmat(linspace(.1, .9,15),1,30)';
    
    %% Target Symbol and Color Randomiser
    % Assign colours
    if randi([0 1]) == 0
        cTarget = 'r'; cAlt = 'b';        
    else
        cTarget = 'b'; cAlt = 'r';
    end
    
    % Assign symbols
    if randi([0 1]) == 0
        sTarget = 'X'; sAlt = 'O';     
    else
        sTarget = 'O'; sAlt = 'X';
    end
 
    %% Make figures and add symbols
    % First adding the target (if target is present) at a random location
    % then adding the distractors at random locations
    for isymbol = 1:n
        h_locgrid = size(locgrid,1);
        chosen_loc = randi(h_locgrid);
        loc = locgrid(chosen_loc,:);
       
        %% Plot symbols according to the type of search      
        % Plot symbols for disjunctive symbol pop-out
        if strcmp(sort, 'dsym') == 1
           
            if isymbol == 1 && target == 1
               put_symbol_inFigure(loc, sTarget, cTarget);
            elseif isymbol == 1 && target == 0
               put_symbol_inFigure(loc, sAlt, cTarget);
            elseif isymbol >= 2  && isymbol <= n/2
               put_symbol_inFigure(loc, sAlt, cTarget);
            elseif isymbol >= n/2+1 && isymbol <= n
               put_symbol_inFigure(loc, sAlt, cAlt);
            end            
    
        % Plot symbols for disjunctive colour pop-out
        elseif strcmp(sort, 'dcol') == 1
        
            if isymbol == 1 && target == 1
               put_symbol_inFigure(loc, sTarget, cTarget);
            elseif isymbol == 1 && target == 0
               put_symbol_inFigure(loc, sTarget, cAlt);
            elseif isymbol >= 2 && isymbol <= n/2
               put_symbol_inFigure(loc, sTarget, cAlt);
            elseif isymbol >= n/2+1 && isymbol <= n
               put_symbol_inFigure(loc, sAlt, cAlt);
            end

        % Plot symbols for conjunctive search
        elseif strcmp(sort, 'c') == 1    
        
            if  isymbol == 1 && target == 1
                put_symbol_inFigure(loc, sTarget, cTarget);
            elseif isymbol == 1 && target == 0
                put_symbol_inFigure(loc, sTarget, cAlt);        
            elseif isymbol >= 2 && isymbol <= n/2
                put_symbol_inFigure(loc, sTarget, cAlt);
            elseif isymbol >= n/2 + 1 && isymbol <= 3*n/4
                put_symbol_inFigure(loc, sAlt, cAlt);
            elseif isymbol >= 3*n/4 + 1 && isymbol <= n
                put_symbol_inFigure(loc, sAlt, cTarget);
            end
        end        
        % remove the chosen coordinates from the combinations
        locgrid(chosen_loc,:) = [];
    end     
end
