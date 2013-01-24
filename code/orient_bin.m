function bin=orient_bin(Ig,theta)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % bin=orient_bin(Ig,theta)
    % Inputs:
    % Ig - the image gradient
    % theta - the gradient direction
    % Outputs:
    % bin - The orientations classified into 18 bins
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    bin=zeros(1,18);
    step=0.34906585;
    theta(theta<0)=2*pi+theta(theta<0);
    for i=0:17
        bin(i+1)=sum(sum(Ig.*(theta>=i*step & theta<(i+1)*step)));
    end
    bin(18)=bin(18)+sum(sum(Ig.*(theta==2*pi)));
end