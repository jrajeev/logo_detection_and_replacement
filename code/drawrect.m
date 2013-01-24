function drawrect(x,y,xlen,ylen,angle)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % drawrect(x,y,xlen,ylen,angle)
    % Inputs:
    % x - column idx of the center of the rectangle
    % y - row idx of the center of the rectangle
    % xlen - length of the rectangle
    % ylen - width of the rectangle
    % angle - orientation of the rectangle wrt x-axis
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    angle=angle*pi/180;
    rotmat=[cos(angle) -sin(angle); sin(angle) cos(angle)];
    xcoor=[-xlen/2 xlen/2 xlen/2 -xlen/2];
    ycoor=[-ylen/2 -ylen/2 ylen/2 ylen/2];
    coor=[xcoor;ycoor];
    rotcoor=rotmat*coor;
    rotx=rotcoor(1,:);
    roty=rotcoor(2,:);
    rotx = ceil(rotx+x);
    roty =ceil(roty+y);
    rotx =[rotx rotx(1)];
    roty =[roty roty(1)];
    plot(rotx,roty,'LineWidth',2);
end