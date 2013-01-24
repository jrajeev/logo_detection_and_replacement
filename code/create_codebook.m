function [codebook codebook_hist codebook_histidx codebook_angidx]=create_codebook(Iref)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % [xvote yvote valvote voteang]=logo_detect(Itest,codebook,codebook_hist,
    % codebook_histidx, codebook_angidx,minscale,maxscale,stepscale)
    % Inputs:
    % Iref - The reference image of the logo for codebook creation
    % Outputs:
    % codebook - The stored codebook of feature descriptors
    % codebook_hist - The histograms for the features in the
    %                    codebook
    % codebook_histidx - The idx of the histograms for the features in the
    %                    codebook
    % codebook_angidx - The idx of the orientations for the features in the
    %                   codebook
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    j=1;
    codebook_hist=[];
    codebook_histidx=[];
    codebook_angidx=[];
    t=CTimeleft(12);
    for i=0:30:330
        t.timeleft();
        I=imrotate(Iref,-i);
        Igray=rgb2gray(I);
        Igray(Igray==0)=255;
        [Igr thetar]=imgrad(Igray);
        [xref yref]=gen_grad_samp_pts(Igr,5,5);
        imshow(uint8(Igr));
        hold all
        plot(xref,yref,'ob','MarkerSize',3,'MarkerFaceColor','r');
        hold off
        hist=gen_feat_desc(Igr,thetar,xref,yref);
        centerx=round(size(I,2)/2); centery=round(size(I,1)/2);
        codebook(j)=struct('hist',hist,'dx',centerx-xref,'dy',centery-yref,'angle',i,'centerx',centerx,'centery',centery);
        codebook_hist=[codebook_hist; codebook(j).hist];
        codebook_histidx=[codebook_histidx;[1:size(codebook(j).hist,1)]'];
        codebook_angidx=[codebook_angidx;j*ones(size(codebook(j).hist,1),1)];
        j=j+1;
    end
end