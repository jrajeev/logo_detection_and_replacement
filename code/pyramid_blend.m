function Ifinout=pyramid_blend(Itestgr1,Itestgr2,mask)
        a=0.4;
        Gx1=[(0.25-a/2) 0.25 a 0.25 (0.25-a/2)];
        %Gx1=Gx1/sum(Gx1);
        Gx2=[1 10 45 120 210 252 210 120 45 10 1];
        Gx2=Gx2/sum(Gx2);
        Gy1=Gx1';
        G1=conv2(Gx1,Gy1);
        mask=conv2(mask,G1,'same');
        gpyr1=g_pyramid(mask,Gx1);
        gpyr2=g_pyramid(gpyr1,Gx1);
        %1st image
        
        gp11=g_pyramid(Itestgr1,Gx1);
        lpyr11=l_pyramid(Itestgr1,gp11);
        gp12=g_pyramid(lpyr11,Gx1);
        lpyr12=l_pyramid(gp11,gp12);
        gp13=g_pyramid(lpyr12,Gx1);
        %2nd image
        
        gp21=g_pyramid(Itestgr2,Gx1);
        lpyr21=l_pyramid(Itestgr2,gp21);
        gp22=g_pyramid(lpyr21,Gx1);
        lpyr22=l_pyramid(gp21,gp22);
        gp23=g_pyramid(lpyr22,Gx1);
        %blend
        
        lres1=lpyr11.*(1-mask)+lpyr21.*mask;
        lres2=lpyr12.*(1-gpyr1)+lpyr22.*gpyr1;
        gpres=gp13.*(1-gpyr2)+gp23.*gpyr2;
        If1=upsamp(gpres,size(lres2))+lres2;
        Ifinout=upsamp(If1,size(lres1))+lres1;
        %size(Ifinout)
        %size(Itestgr1)
        %size(Itestgr2)
end