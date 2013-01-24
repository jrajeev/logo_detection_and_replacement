function drawbox(codebook,Itest,minscale,maxscale,stepscale,xvote, yvote, valvote, voteang,threshval)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % drawbox(codebook,Itest,minscale,maxscale,stepscale,xvote, yvote,
    % valvote, voteang,threshval)
    % Inputs:
    % codebook - The stored codebook of feature descriptors
    % Itest - Image in which logo has to be detected
    % minscale - minimum scale size to detect
    % maxscale - maximum scale size to detect
    % stepscale - step-size to increment scales
    % xvote - stores the column idx of the position of first 100 highest
    %         voted pixels
    % yvote - stores the row idx of the position of first 100 highest
    %         voted pixels
    % valvote - stores the number of votes of the position of first 100 
    %           highest voted pixels
    % voteang - stores the orientation of first 100 highest voted pixels
    % threshval - the threshold vote value to use to draw boxes
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    scale_id=1;
    imshow(uint8(Itest));
    value=max(max(valvote));
    cnter=0;
    prevx=[];
    prevy=[];
    for scale=minscale:stepscale:maxscale
        for i=1:20
            if (yvote(i,scale_id)==0 || valvote(i,scale_id)<threshval*value) %
                break;
            end

            cury=yvote(i,scale_id)/scale;
            curx=xvote(i,scale_id)/scale;
            flag=0;
            if (cnter>=1)
                for k=1:cnter
                    distt=(cury-prevy(k))^2 + (curx-prevx(k))^2 ;
                    if (sqrt(distt)<10/scale)
                        flag=1;
                        break;
                    end
                end
                if (flag==1)
                    break;
                end
            end
            cnter=cnter+1;
            prevx(cnter)=xvote(i,scale_id)/scale;
            prevy(cnter)=yvote(i,scale_id)/scale;
            
            % Converts to xvote and yvote values to desired coordinates and
            % plots a box with the scaled size
            hold all
            drawrect(xvote(i,scale_id)/scale,yvote(i,scale_id)/scale,128/scale,49/scale,codebook(voteang(i,scale_id)).angle);
            hold all
            plot(xvote(i,scale_id)/scale,yvote(i,scale_id)/scale,'or','MarkerSize',5,'MarkerFaceColor','r');
        end
        scale_id=scale_id+1;
    end
    hold off;
end