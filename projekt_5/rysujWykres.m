function [  ] = rysujWykres( xVec, yVec, xLabel_, yLabel_, title_)

    stairs(xVec, yVec) ;
    
    xlabel(xLabel_) ;
    ylabel(yLabel_) ;
    title(title_) ;

end

