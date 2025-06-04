function S = generateEllipsoidMatrixFromDiagonal(S_diagonal)
%GENERATEELLIPSOIDMATRIXFROMDIAGONAL 
% Generate the matrix S from the ellipsoid semi-axis length terms contained in
% the column vector S_diagonal

size_S = length(S_diagonal);

S = zeros(size_S,size_S);

for i=1:1:size_S
  S(i,i) = 1 / S_diagonal(i)^2;
end

end

