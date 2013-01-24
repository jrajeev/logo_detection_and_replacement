function [fa1_x,fax_x,fay_x,fw_x,fa1_y,fax_y,fay_y,fw_y,inliers_idx]=ransac_tps(targetx,targety,x,y,lamda,thresh,run)
    %minx=min(x);
    %miny=min(y);
    %mintx=min(targetx);
    %minty=min(targety);
    %x=x-minx;
    %y=y-miny;
    %targetx=targetx-mintx;
    %targety=targety-minty;
    cnt=0;
    for i=1:run
        idx=randperm(numel(x));
        idx=idx(1:5);
        %ransac_ctr_pts=size(x(idx))
        [a1_x,ax_x,ay_x,w_x]=est_tps([x(idx) y(idx)],targetx(idx),lamda);
        [a1_y,ax_y,ay_y,w_y]=est_tps([x(idx) y(idx)],targety(idx),lamda);
        [fx fy]= morph_tps(x,y, a1_x, ax_x, ay_x, w_x, a1_y, ax_y, ay_y, w_y, x(idx),y(idx));
        dist=(fx-targetx).^2 + (fy-targety).^2;
        pts=find(dist<thresh);
        if (numel(pts)>cnt)
            cnt=pts;
            fa1_x=a1_x; fax_x=ax_x; fay_x=ay_x; fw_x=w_x;
            fa1_y=a1_y; fax_y=ax_y; fay_y=ay_y; fw_y=w_y;
            inliers_idx=idx;
        end
    end
end