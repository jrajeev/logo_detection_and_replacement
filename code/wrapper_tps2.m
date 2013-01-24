function z=wrapper_tps2(im_source1,im_source2,base_pts,new_pts,warp_frac,dissolve_frac)
     mean_pts=(1-warp_frac)*base_pts+(warp_frac)*new_pts;
     [a1_x,ax_x,ay_x,w_x]=est_tps(mean_pts,base_pts(:,1));
     [a1_y,ax_y,ay_y,w_y]=est_tps(mean_pts,base_pts(:,2));
     ctr_pts=[ones(size(mean_pts,1)) mean_pts];
     z1=morph_tps(im_source1, a1_x, ax_x, ay_x, w_x, a1_y, ax_y, ay_y, w_y, ctr_pts,[size(im_source1,1) size(im_source1,2)]);
     z1=wrapper_tps(im_source1,base_pts,mean_pts);
     figure,imshow(z1);
     [a1_x,ax_x,ay_x,w_x]=est_tps(mean_pts,new_pts(:,1));
     [a1_y,ax_y,ay_y,w_y]=est_tps(mean_pts,new_pts(:,2));
     z2=morph_tps(im_source2, a1_x, ax_x, ay_x, w_x, a1_y, ax_y, ay_y, w_y, ctr_pts,[size(im_source2,1) size(im_source2,2)]);
     figure,imshow(z2);
     z=(1-dissolve_frac)*z1+(dissolve_frac)*z2;
     figure,imshow(z);
end