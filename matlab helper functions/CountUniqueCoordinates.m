function uniqe_xy_counts = CountUniqueCoordinates(x,y)
%x and y should be col vectors
%x=A;y=B;    
xy_mat = [x,y];
if size(x,2)>1 || size(y,2)>1
    msgID = 'CountUniqueCoordinates:rong (x,y) dims';
    msg = 'x and y should be column vectors';
    baseException = MException(msgID,msg);
    throw(baseException);
end
    
    [uniqueVals,unique_Is,xy_matIs] = unique(xy_mat,'rows');
    
    %add occurance column to uniqueVals
    uniqueVals = [uniqueVals zeros(length(uniqueVals),1)];
    
    counter = 1;
    for val = unique_Is'
        occurance = sum(xy_matIs==xy_matIs(val));
        
        uniqueVals(counter,3) = occurance;    
        counter = counter + 1;
    end
    
    uniqe_xy_counts = uniqueVals;
    
    
end