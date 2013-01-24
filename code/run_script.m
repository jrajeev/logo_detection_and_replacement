%% Logo Detection
% Author: Rajeev Kumar Jeevagan
% Date: 12/21/2011
% Description:
% > HOG feature descriptor
% > Scale and Rotation invariance implemented
% > Detection using voting
% > Google Logo is detected

%% Create reference logo
I= imread('./pics/ref.jpg');
I=imresize(I,[size(I,1)/4 size(I,2)/4]);
imwrite(I,'./pics/ref2.jpg');
Iref=imread('./pics/ref2.jpg');

%% Create Codebook
[codebook codebook_hist codebook_histidx codebook_angidx]=create_codebook(Iref);

%% Logo Detection
minscale= [0.2 0.2 0.2 0.5 0.2 0.2 0.2 1.0 0.2 1.7 1.7 0.2 1.2 0.2 0.2 0.9 0.2];                                
maxscale= [0.5 0.6 0.6 0.9 0.6 0.6 0.6 1.2 1.0 1.8 1.8 0.7 1.4 0.6 0.6 1.1 0.6];
threshval=[0.9 0.55 0.9 0.92 0.93 0.9 0.98 0.2 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.9 0.68];
stepscale=0.1;
for i=1:17
    fprintf('Logo Detection for Image # %d\n',i);
    imnum=num2str(i,'%d');
    fname=['./pics/' imnum '.jpg'];
    Itest=imread(fname);
    % Logo Detection
    [xvote yvote valvote voteang]=logo_detect(Itest,codebook,codebook_hist, codebook_histidx, codebook_angidx,minscale(i),maxscale(i),stepscale);
    % Drawing Bounding box around logo
    drawbox(codebook,Itest,minscale(i),maxscale(i),stepscale,xvote, yvote, valvote, voteang,threshval(i));
    fprintf('Press Key to continue\n');
    pause;
end

%% Comments
% The input images are stored in pics folder and output images also saved
% there named as out1.jpg, out2.jpg, and so on
% The replacement logo is named as yahoo.jpg and located in the pics folder
% The code is scale invariant
% The imagescale is set so that the running time is less.
% The code runs for common imagescale ranges
