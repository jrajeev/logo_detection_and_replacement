function [fx fy]= morph_tps(x,y, a1_x, ax_x, ay_x, w_x, a1_y, ax_y, ay_y, w_y, ctrx,ctry)
    Xarr=x';
    Yarr=y';
    Xarr=repmat(Xarr,numel(ctrx),1);
    Yarr=repmat(Yarr,numel(ctry),1);
    carrX=repmat(ctrx,1,numel(x));
    carrY=repmat(ctry,1,numel(y));
    diffX=carrX-Xarr;
    diffY=carrY-Yarr;
    U=((diffX.*diffX)+(diffY.*diffY));
    tmp=(U~=0);
    U=-1*U.*log(U);
    U(tmp==0)=0;
    if (size(w_x,2)==1) 
        w_x=transpose(w_x);
    end
    if (size(w_y,2)==1)
        w_y=transpose(w_y);
    end        
    %morphw=size(w_x)
    %morphu=size(U)
    %Xsz=size(x')
    %Ysz=size(y')
    %Xarrsz=size(Xarr)
    %Yarrsz=size(Yarr)
    fx=a1_x + ax_x*x' + ay_x*y'+ w_x*U; 
    fy=a1_y + ax_y*x' + ay_y*y' + w_y*U;    
    fx=fx';
    fy=fy';
end
