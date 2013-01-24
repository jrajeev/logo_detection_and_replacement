function z=wrapper_tps1(im_source1,im_source2,base_pts,new_pts,warp_frac,dissolve_frac)
%function for overall morphing of two images using tps
     mean_pts=(1-warp_frac)*base_pts+(warp_frac)*new_pts;
     z1=wrapper_tps(im_source1,base_pts,mean_pts);
     figure,imshow(uint8(z1));
     z2=wrapper_tps(im_source2,new_pts,mean_pts);
     figure,imshow(uint8(z2));
     z=(1-dissolve_frac)*z1+(dissolve_frac)*z2;
     %figure,imshow(z);
end