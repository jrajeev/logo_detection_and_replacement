function Ifinout=logo_replace(codebook,Irep,Itest,minscale,maxscale,stepscale,xvote, yvote, valvote, voteang, threshval)
    scale_id=1;
    %imshow(uint8(Itest));
    %size(Itest)
    cnter=0;
    prevx=[];
    prevy=[];
    Irepg=rgb2gray(Irep);
    value=max(max(valvote));
    Itestfin=Itest;
    t3=CTimeleft(round((maxscale-minscale)/stepscale)+1);
    for scale=minscale:stepscale:maxscale
        for i=1:20
            if (yvote(i,scale_id)==0 || valvote(i,scale_id)<threshval*value)
                break;
            end
            hold all        

            cury=yvote(i,scale_id)/scale;
            curx=xvote(i,scale_id)/scale;
            flag=0;
            if (cnter>=1)
                for k=1:cnter
                    distt=(cury-prevy(k))^2 + (curx-prevx(k))^2 ;
                    if (sqrt(distt)<70/scale)
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
            
            Itestfin2=Itestfin;
            
            Irepn=imresize(Irep,size(Irepg)/scale);
            Irepn=imrotate(Irepn,-codebook(voteang(i,scale_id)).angle);
            Irepgn=rgb2gray(Irepn);
            gidx=find(Irepgn);
            [gy gx]=ind2sub(size(Irepgn),gidx);
            meanref=0;
            Irepnhsv=rgb2hsv(Irepn);

            for j=1:numel(gy)
                meanref=meanref+Irepnhsv(gy(j),gx(j),3);
            end
            meanref=meanref/numel(gy);
            cy=round((yvote(i,scale_id)/scale)-(size(Irepn,1)/2));
            cx=round((xvote(i,scale_id)/scale)-(size(Irepn,2)/2));
            cy=cy+gy;
            cx=cx+gx;
            cond=(cx>=1 & cy>=1 & cx<=size(Itest,2) & cy<=size(Itest,1));
            cy=cy(cond); cx=cx(cond); gy=gy(cond); gx=gx(cond);


            meandetect=0;
            Itesthsv=rgb2hsv(Itestfin2);
            for j=1:numel(gy)
                meandetect=meandetect+Itesthsv(cy(j),cx(j),3);
            end
            meandetect=meandetect/numel(gy);
            meandiff=meanref-meandetect;

            Irepnhsv=rgb2hsv(double(Irepn));
            Irepnhsv(:,:,3)=Irepnhsv(:,:,3)-meandiff*1.4;
            Irepn=hsv2rgb(Irepnhsv);
            Irepn=uint8(Irepn);
            for j=1:numel(gy)
                %[numel(gy) j ;cy(j) cx(j) ;size(Itest,1) size(Itest,2);gy(j) gx(j);size(Irepn,1) size(Irepn,2)]
                Itestfin(cy(j),cx(j),:)=Irepn(gy(j),gx(j),:);
            end

            Itestgr1=double(rgb2gray(Itestfin2));
            Itestgr2=double(rgb2gray(Itestfin));
            mask=zeros(size(Itestfin,1),size(Itestfin,2));
            cidx=sub2ind(size(mask),cy,cx);
            mask(cidx)=0.93;
            Itestfin=double(Itestfin);
            Itestfin2=double(Itestfin2);
            Ifinout=Itestfin2;
            %Itestsz=size(Itest)
            %Itestfinsz=size(Itestfin)
            Ifinout(:,:,1)=pyramid_blend(Itestfin2(:,:,1),Itestfin(:,:,1),mask);
            Ifinout(:,:,2)=pyramid_blend(Itestfin2(:,:,2),Itestfin(:,:,2),mask);
            Ifinout(:,:,3)=pyramid_blend(Itestfin2(:,:,3),Itestfin(:,:,3),mask);
            a=0.4;
            Gx1=[(0.25-a/2) 0.25 a 0.25 (0.25-a/2)];
            Gy1=Gx1';
            G1=conv2(Gx1,Gy1);
            Ifinout(:,:,1)=conv2(Ifinout(:,:,1),G1,'same');
            Ifinout(:,:,2)=conv2(Ifinout(:,:,2),G1,'same');
            Ifinout(:,:,3)=conv2(Ifinout(:,:,3),G1,'same');
            %imshow(uint8(Ifinout));
            %imshow(uint8(Ifinout));
            %drawrect(xvote(i,scale_id)/scale,yvote(i,scale_id)/scale,128/scale,49/scale,codebook(voteang(i,scale_id)).angle);
            %hold all
            %plot(xvote(i,scale_id)/scale,yvote(i,scale_id)/scale,'or','MarkerSize',5,'MarkerFaceColor','r');
        end
        scale_id=scale_id+1;
        t3.timeleft();
    end