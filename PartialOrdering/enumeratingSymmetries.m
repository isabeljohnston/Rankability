function y = enumeratingSymmetries(D)

  %Collect information on input matrix D
  dim = size(D, 1);

  %Symmetry array
  symmetryMatrix = zeros(dim, dim);

  %loop through all entries
  for i = 1:dim
    for j = 1:dim
      if D(i,j) == D(j,i)
        symmetryMatrix(i,j) = 1;
      end
    end
  end

  find(~symmetryMatrix)
