function [Ig theta]=imgrad(I)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % [Ig theta]=imgrad(I)
    % Inputs:
    % I - Input image
    % Outputs:
    % Ig - the image gradient
    % theta - the gradient direction
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Ig=double(I);
    Dx=[-1 0 1];
    Dy=Dx';
    Ix=conv2(Ig,Dx,'same');
    Iy=conv2(Ig,Dy,'same');
    Ig=sqrt(Ix.*Ix + Iy.*Iy);
    theta=atan2(Iy,Ix);
    %imshow(uint8(Ig));
end