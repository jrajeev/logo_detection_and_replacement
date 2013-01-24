function hist=gen_feat_desc(Ig,theta,x_samp,y_samp)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % hist=gen_feat_desc(Ig,theta,x_samp,y_samp)
    % Inputs:
    % Ig - the image gradient
    % theta - the gradient direction
    % xsamp - the col idx of the sample points
    % ysamp - the row idx of the sample points
    % Outputs:
    % hist - the HOG feature descriptor
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    e=1e-3;
    hist=zeros(numel(x_samp),162);
    xoff=reshape(repmat([0 6 12],[3 1]),1,9);
    yoff=reshape(repmat([0 6 12]',[1 3]),1,9);
    for i=1:numel(x_samp)
        sx=x_samp(i)-9; sy=y_samp(i)-9;
        bin=zeros(9,18);
        for j=1:9
            sty=sy+yoff(j);
            eny=sy+yoff(j)+5;
            stx=sx+xoff(j);
            enx=sx+xoff(j)+5;
            bin(j,:)=orient_bin(Ig(sty:eny,stx:enx),theta(sty:eny,stx:enx));
        end
        bin=bsxfun(@rdivide,bin,sqrt(sum(bin.*bin)+e*e));
        hist(i,:)=reshape(bin',1,162);
    end
end