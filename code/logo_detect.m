function [xvote yvote valvote voteang]=logo_detect(Itest,codebook,codebook_hist, codebook_histidx, codebook_angidx,minscale,maxscale,stepscale)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % [xvote yvote valvote voteang]=logo_detect(Itest,codebook,codebook_hist,
    % codebook_histidx, codebook_angidx,minscale,maxscale,stepscale)
    % Inputs:
    % Itest - Image in which logo has to be detected
    % codebook - The stored codebook of feature descriptors
    % codebook_histidx - The idx of the histograms for the features in the
    %                    codebook
    % codebook_angidx - The idx of the orientations for the features in the
    %                   codebook
    % minscale - minimum scale size to detect
    % maxscale - maximum scale size to detect
    % stepscale - step-size to increment scales
    % Outputs:
    % xvote - stores the column idx of the position of first 100 highest
    %         voted pixels
    % yvote - stores the row idx of the position of first 100 highest
    %         voted pixels
    % valvote - stores the number of votes of the position of first 100 
    %           highest voted pixels
    % voteang - stores the orientation of first 100 highest voted pixels
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    Itestgray=rgb2gray(Itest);
    % Initialize parameters
    K=8;            % 8 best matches contribute votes
    scalelen=30;    % # scales considered
    scale_id=1;     % index for scales
    numdetect=100;  % # images voting returns
    
    xvote=zeros(numdetect,scalelen);
    yvote=zeros(numdetect,scalelen);
    valvote=zeros(numdetect,scalelen);
    voteang=zeros(numdetect,scalelen);
    t=CTimeleft(round((maxscale-minscale)/stepscale)+1); % routine to compute loop iteration time
    
    for scale=minscale:stepscale:maxscale
        Itestg=imresize(Itestgray,size(Itestgray)*scale); % resize image to desired scale
        [Itestgrad thetatest]=imgrad(Itestg);             % find image gradient
        [xtest ytest]=gen_grad_samp_pts(Itestgrad,5,5);   % sample points based on gradient
        test_hist=gen_feat_desc(Itestgrad,thetatest,xtest,ytest); % generate HOG feature descriptor
        
        vote=zeros(numel(Itestgrad),1);                   
        angvote=zeros(numel(Itestgrad),numel(codebook));
        for i=1:size(test_hist,1)
            
            % Computing Chi-squared distance between histograms
            nr=bsxfun(@minus,test_hist(i,:),codebook_hist(:,:));
            nr=sum(nr.*nr,2);
            dr=2*sum(bsxfun(@plus,test_hist(i,:),codebook_hist(:,:)),2);
            chi=nr./dr;
            [chival chiidx]=sort(chi);
            chival=chival(1:K);
            chiidx=chiidx(1:K);
            codeidx=codebook_histidx(chiidx);
            codeangidx=codebook_angidx(chiidx);
            
            % Consider K best Chi-squared matches and vote for images in
            % codebook
            for j=1:K
                ty=ytest(i)+codebook(codeangidx(j)).dy(codeidx(j))+1;
                tx=xtest(i)+codebook(codeangidx(j)).dx(codeidx(j))+1;
                if (tx>=1 && ty>=1 && tx<=size(Itestgrad,2) && ty<=size(Itestgrad,1))
                    idx=sub2ind(size(Itestgrad),ty,tx);
                    vote(idx)=vote(idx)+ 1/chival(j);
                    angvote(idx,codeangidx(j))=angvote(idx,codeangidx(j))+1;
                end
            end
        end
        
        % Pick locations of max vote and store position, scale & rotation
        [maxangvote maxangvoteidx]=max(angvote,[],2);
        votemat=reshape(vote,[size(Itestgrad)]);
        [voteval voteidx]=sort(vote,'descend');
        [y x]=ind2sub(size(votemat),voteidx(1:numdetect));
        ind=sub2ind(size(votemat),y,x);
        yvote(1:numel(y),scale_id)=y;
        xvote(1:numel(y),scale_id)=x;
        valvote(1:numel(y),scale_id)=votemat(ind);
        voteang(1:numel(y),scale_id)=maxangvoteidx(ind);
        scale_id=scale_id+1;
        t.timeleft();
    end
end