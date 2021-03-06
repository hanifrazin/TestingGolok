function perimeter = computePerimeterFromBoundary(B)
delta = diff(B).^2;
if(size(delta,1) > 1)
    isCorner  = any(diff([delta;delta(1,:)],1),2); % Count corners.
    isEven    = any(~delta,2);
    perimeter = sum(isEven,1)*0.980 + sum(~isEven,1)*1.406 - sum(isCorner,1)*0.091;
else
    perimeter = 0; % if the number of pixels is 1 or less.
end