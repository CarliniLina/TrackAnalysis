% script to compute angles between successive steps and displacements from multiple
% trajectories, requires a matlab cell with all tracks. Tracks
% assumed to be pre-filtered.

clearvars -except tracks;
close all;

%% inputs
%tracks is a cell, containing all trajectories. Each cell contains a track
%with column 1: time, column 2: x coordinate, col 3: y coordinate

%% output of interest
% thetaCat, where each cell contains all the angles for given time delay (see note in text file for details)
% VHx, Vhy are cells containing displacements in x and y directions for each time lag


%% compute displacements
 msdVH=tracks;
    for i=1:length(msdVH)
%         
       mxTL(i)=size(msdVH{i},1);
       MaxTL=max(mxTL);
       
      for  tl = 1: MaxTL
%        tl
       if tl <= size(msdVH{i},1)
       
       ShiftTempX = circshift(msdVH{i}(:,2), tl); 
       ShiftTempX(1:tl) = NaN;
       
       ShiftTempY = circshift(msdVH{i}(:,3), tl); 
       ShiftTempY(1:tl) = NaN;
       
       LagX{tl, i}= [msdVH{i}(:,2)- ShiftTempX]; %i is track and tl is timelag
       LagY{tl, i}= [msdVH{i}(:,3)- ShiftTempY];
       
       clear ShiftTempY ShiftTempX ShiftTempY  ShiftTempX
       
       else
       end
       end
    end

       for tl=1:MaxTL
%            tl
           VHx{tl}=[];
               VHy{tl}=[];
           for i= 1:length(msdVH)
%                i
               
           VHx{tl}=[VHx{tl}(:);LagX{tl,i}(:)]; %displacements in x as a function of time delay, tl
           VHy{tl}= [VHy{tl}(:);LagY{tl,i}(:)]; %displacements in y as a function of time delay, tl
           
           end
       end


clear tl;
%get angle distributions
for i=1:size(LagX,2)%sweep through tracks
    for tl=1:size(LagX,1)    %sweep through time lags
    V{tl,i}=[LagX{tl,i}, LagY{tl,i}];
    end
end

clear tl;
clear count;

    for tr=1:size(V,2) %track sweep
        for tl=1:size(V,1) % time lag sweep
            counter=0;
            for k=1:tl:size(V{tl,tr},1)-tl
                counter=counter+1;
              
                %implement dot product
            num=dot(V{tl,tr}(k,:),V{tl,tr}(k+tl,:));
            den=norm(V{tl,tr}(k,:))*norm(V{tl,tr}(k+tl,:));
            theta{tl,tr}(counter)=(acosd(num/den)); %note innacuracy for very small angles
            clear num den
            end
            clear count
        end
    end
       
    clear tl;
    for tl=1:size(theta,1) %time lags
        thetaCatm=[];
       for r=1:size(theta,2)% tracks
           
    thetaCatm=[thetaCatm theta{tl,r}];
       end
       
    [~,colN]=find(isfinite(thetaCatm));
    thetaCat{tl}=thetaCatm(colN); %angles as a function of time delay. Note that only shortest time delay contains all data
    clear thetaCatm colN
    end
  
     
     