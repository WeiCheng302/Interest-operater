function InterestOperator(apu)

%there is no need to modify this function
%write your own code to the file Plessey.m

global fui
global fui1
global fui2
global fui21
global fui3
global fui31
global fui4
global fui41
global I
global J
global gx
global gy


if (nargin < 1 )
  fig1=figure(1);
  clf(fig1);
  eh=[];
  hl=[];
  [filename,pathname]=uigetfile('*.jpg','choose image');

  I =imread ([pathname filename]); 

  J = rgb2gray(I);


  subplot(2,2,1) 
  imshow(I)
  title('Original image');
  subplot(2,2,2)
  imshow(J)
  title('Grayscale version');

    %create grasient images using Sobel
  if ~(isa(J,'double') || isa(J,'single')); J = im2single(J); end
  gx = imfilter(J,fspecial('sobel')'/8,'replicate');
  gy = imfilter(J,fspecial('sobel')/8,'replicate');

  koko1=size(gx);
  %threshold, if gradient images are to be filtered
  thres=0.01;

  for i=1:koko1(1)
    for j=1:koko1(2)
       if thres>abs(gx(i,j))
          gx(i,j)=0; 
       end
       
    end
  end

  koko1=size(gy);
  
  for i=1:koko1(1)
    for j=1:koko1(2)
       if thres>abs(gy(i,j))
          gy(i,j)=0; 
       end
    end
  end

  %visualise gradient images
  subplot(2,2,3)

  Px = imadjust(abs(gx),stretchlim(abs(gx),[0 1]));
  imshow(Px)
  title('gradient image at x direction')
  subplot(2,2,4)
  
  Py = imadjust(abs(gy),stretchlim(abs(gy),[0 1]));
  imshow(Py)
  title('gradient image at y direction');

  apu=0;

  
  %create interactive parameter boxes

  %A matrix mask size
     st=['Matrix A mask size:'];
     fui=uicontrol('style','text',...
            'position',[1 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st);
     fui1=uicontrol('style','edit',...
            'position',[100 1 30 30],...
            'string',num2str(5));


% interest_threshold
     st2=['Threshold (Interestvalue p):'];
     fui2=uicontrol('style','text',...
            'position',[130 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st2);
     fui21=uicontrol('style','edit',...
            'position',[230 1 50 30],...
            'string',num2str(0.0001));


% interest_threshold
     st3=['Alpha (range 0.04-0.06):'];
     fui3=uicontrol('style','text',...
            'position',[280 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st3);
     fui31=uicontrol('style','edit',...
            'position',[370 1 40 30],...
            'string',num2str(0.05));
     %masksize to find local maxima
     st4=['Mask size to find local maxima:'];
     fui4=uicontrol('style','text',...
            'position',[420 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st4);
     fui41=uicontrol('style','edit',...
            'position',[520 1 30 30],...
            'string',num2str(6));


  
end
%-----------------------------------------------------------------
if (apu==0)


  f=uimenu('Label','Exercise Menu');
  uimenu(f,'Label','Load New Image','Callback','InterestOperator(1)');
  uimenu(f,'Label','Start Plessey-Harris','Callback','InterestOperator(2)');

elseif (apu==1)
  %load new image
  [filename,pathname]=uigetfile('*.jpg','choose image');
  I =imread ([pathname filename]);
  % convert to gray scale
  J = rgb2gray(I);
  %clear figure
  fig1=figure(1);
  clf(fig1); 
  %recreate exercise menu
  f=uimenu('Label','Exercise Menu');
  uimenu(f,'Label','Load New Image','Callback','InterestOperator(1)');
  uimenu(f,'Label','Start Plessey-Harris','Callback','InterestOperator(2)');
  
  %recreate interactive parameter boxes
  %A matrix mask size
     st=['Matrix A mask size:'];
     fui=uicontrol('style','text',...
            'position',[1 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st);
     fui1=uicontrol('style','edit',...
            'position',[100 1 30 30],...
            'string',num2str(5));
%             callback','showima(100)');

% interest_threshold
     st2=['Threshold (Interestvalue p):'];
     fui2=uicontrol('style','text',...
            'position',[130 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st2);
     fui21=uicontrol('style','edit',...
            'position',[230 1 50 30],...
            'string',num2str(0.0001));
%             callback','showima(100)');

% interest_threshold
     st3=['Alpha (range 0.04-0.06):'];
     fui3=uicontrol('style','text',...
            'position',[280 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st3);
     fui31=uicontrol('style','edit',...
            'position',[370 1 40 30],...
            'string',num2str(0.05));
     %masksize to find local maxima
     st4=['Mask size to find local maxima:'];
     fui4=uicontrol('style','text',...
            'position',[420 1 100 30],...
            'backgroundcolor',[.8 .8 .8],...
            'string',st4);
     fui41=uicontrol('style','edit',...
            'position',[520 1 30 30],...
            'string',num2str(6));
  
  
  %show image
  subplot(2,2,1)
  imshow(I)
  title('Original image');
  subplot(2,2,2)
  imshow(J)
  title('Grayscale version');
  %create grasient images using Sobel
  if ~(isa(J,'double') || isa(J,'single')); J = im2single(J); end
  gx = imfilter(J,fspecial('sobel')'/8,'replicate');
  gy = imfilter(J,fspecial('sobel')/8,'replicate');

  koko1=size(gx);
  %threshold, if gradient images are to be filtered
  thres=0.01;

  for i=1:koko1(1)
    for j=1:koko1(2)
       if thres>abs(gx(i,j))
          gx(i,j)=0; 
       end
       
    end
  end

  koko1=size(gy);
  
  for i=1:koko1(1)
    for j=1:koko1(2)
       if thres>abs(gy(i,j))
          gy(i,j)=0; 
       end
    end
  end

  %visualise gradient images
  subplot(2,2,3)

  Px = imadjust(abs(gx),stretchlim(abs(gx),[0 1]));
  imshow(Px);
  title('gradient image at x direction');

  subplot(2,2,4);
  Py = imadjust(abs(gy),stretchlim(abs(gy),[0 1]));
  imshow(Py);
  title('gradient image at y direction');
  
elseif (apu==2) %Start Plessey-Harris
  masksize=str2num(get(fui1,'string'));
  interest_threshold=str2num(get(fui21,'string'));
  alpha=str2num(get(fui31,'string'));
  

  koko1=size(J);


  result=zeros(koko1(1),koko1(2));  
  'Calculating Plessey (Your own code) - be patient'
  size(result);
  result=Plessey(gx, gy, masksize, interest_threshold, alpha);
  
  'Your code (hopefully) successfully  completed'
  size(result);
  
  %vizualize all interesting locations
  fig2=figure(2);
  clf(fig2);
  subplot(2,1,1);
  imshow(I)
  title('All interesting points');
  hold on;
  for i=1:koko1(1)
    for j=1:koko1(2)
        if result(i,j)~=0
            plot(j,i,'.');           
        end
    end
  end
  hold off
  
  %searching local maxima 
  
  n=str2num(get(fui41,'string'));

  'Searching local maxima'

  for i=n+1:koko1(1)-(n+1)
    for j=n+1:koko1(2)-(n+1)
        max=0;
        %searching local maxima within the mask
        for k=-n:n
            for l=-n:n
              if max<result(i+k,j+l) 
                max=result(i+k,j+l);
              end
            end
        end
        %removing other points than local maxima
        for k=-n:n
            for l=-n:n
              if max>result(i+k,j+l) 
                result(i+k,j+l)=0;
              end
            end
        end
    end
  end

  for i=1:koko1(1)
    for j=1:koko1(2)
        if result(i,j)~=0
            result(i,j)=255;
        end
    end
  end

  'Plotting local maxima'

  subplot(2,1,2);
  imshow(I)
  title('Final interesting points (approximate locations)')
  hold on;
  pisteet=zeros(20, 2);
  laskuri=0;
  for i=1:koko1(1)
    for j=1:koko1(2)
        if result(i,j)~=0
            plot(j,i,'.');
            laskuri=laskuri+1;
            pisteet(laskuri, 1)=i;
            pisteet(laskuri, 2)=j;
            
        end
    end
  end
  hold off;
  'Completed - End'  



end




