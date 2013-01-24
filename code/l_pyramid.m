function Iout=l_pyramid(Iprev,Inext)
    Inext=upsamp(Inext,[size(Iprev,1) size(Iprev,2)]);
    Iout=Iprev-Inext;
end