function [  ] = rysujWykres( xVec, yVec, zVec, xLabel_, yLabel_, zLabel_, title_)

    if zVec == -1
        stairs(xVec, yVec) ;
    else
        mesh(xVec, yVec, zVec);
        zlabel(zLabel_) ;
    end
    
    xlabel(xLabel_) ;
    ylabel(yLabel_) ;
    title(title_) ;

end

