function [x_grad y_grad]=gen_grad_samp_pts(Igrad,sample_factor,thresh)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % [x_grad y_grad]=gen_grad_samp_pts(Igrad,sample_factor,thresh)
    % Inputs:
    % Igrad - the image gradient
    % sample_factor - determines the # points sampled
    % thresh - the threshold gradient magnitude above which points are
    %          considered for sampling
    % Outputs:
    % x_grad - the col idx of the sample points
    % y_grad - the row idx of the sample points
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Igrad(Igrad<thresh)=0;
    [x y]=meshgrid(1:size(Igrad,2),1:size(Igrad,1));
    x=x(10:sample_factor:size(x,1)-9,10:sample_factor:size(x,2)-9);
    y=y(10:sample_factor:size(y,1)-9,10:sample_factor:size(y,2)-9);
    x_samp=reshape(x,numel(x),1);
    y_samp=reshape(y,numel(y),1);
    gradmap=zeros(size(Igrad));
    gradmap(y_samp,x_samp)=1;
    gradmap=(gradmap & Igrad);
    linidx=find (gradmap);
    [y_grad x_grad]=ind2sub(size(Igrad),linidx);
    condn=y_grad>=10 & x_grad>=10 & y_grad<=(size(Igrad,1)-9) & x_grad<=(size(Igrad,2)-9);
    y_grad=y_grad(condn);
    x_grad=x_grad(condn);
end