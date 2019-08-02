function result=Plessey(gx1, gy1, masksize, interest_threshold, alpha)

size1=size(gx1);
result=zeros(size1(1),size1(2));

A=zeros(2,2);

for j = masksize+1 :(size1(1)-masksize)
    for k = masksize+1 :(size1(2)-masksize)
        A(1,1)=sum(sum(gx1(j-masksize:j+masksize,k-masksize:k+masksize).^2));
        A(1,2)=sum(sum(gx1(j-masksize:j+masksize,k-masksize:k+masksize).*gy1(j-masksize:j+masksize,k-masksize:k+masksize)));
        A(2,1)=A(1,2);
        A(2,2)=sum(sum(gy1(j-masksize:j+masksize,k-masksize:k+masksize).^2));  
        
        p=det(A)-alpha*trace(A)^2;
        
        if p > interest_threshold          
          result(j,k)=p;
        end
    end
end
end

%gx1 = gradient image (x direction)
%gy1 = gradient image (y direction)
%masksize = distance from the center pixel of the mask to the border pixel
%interest_threshold = threshold value, discard all points that have an
%                     interest value smaller than this threshold
%alpha = see equation 9 from the appendix 1
%result = store interest values in this matrix to the correct locations (if
%         the interest value is larger than threshold 
% size1=size(gx1); %size of matrices xg1,gy1 and result 
% result=zeros(size1(1),size1(2)); % initializing result matrix with zeros

%write your code here 
%tasks to do:   create matrix A
%               calculate interest values
%               check if interest value is larger than threshold
%               store the interest value to "result" matrix, if larger
%               than threshold
%		    NOTE! When you calculate the elements to the matrix A, don't use temporary variables but 
%		    make your calculations directly to the individual element of your matrix. Otherwise your code
%		    will become REALLY slow




