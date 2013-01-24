function Iout=g_pyramid(Iin,Gx)
    Gy=Gx';
    G=conv2(Gx,Gy);
    Iout=conv2(Iin,G,'same');
    Iout=Iout(1:2:size(Iout,1),1:2:size(Iout,2));
end