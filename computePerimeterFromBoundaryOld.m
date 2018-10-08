function perimeter = computePerimeterFromBoundaryOld(B)

delta = diff(B).^2;
perimeter = sum(sqrt(sum(delta,2)));

% for k = 1:length(B) 
%     % obtain (X,Y) boundary coordinates corresponding to label 'k' 
%     boundary = B{k}; 
% 
%     %get the perimeter by calculating the each pixel to pixel distance in boundary and add the discret distand together 
%     delta_sq = diff(boundary).^2; 
%     perimeter= sum(sqrt(sum(delta_sq,2))); 
% end 


