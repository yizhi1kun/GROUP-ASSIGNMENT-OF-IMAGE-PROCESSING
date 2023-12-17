function Y=normalization(X,lower,upper,MAX,MIN)

    [~,n]=size(X);

    for i=1:n
     Y(:,i)=(X(:,i)-MIN)/(MAX-MIN)*(upper-lower)+lower;
    end
end
