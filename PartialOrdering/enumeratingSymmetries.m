function y = enumeratingSymmetries(D)

  %Collect information on input matrix D
  dim = size(D, 1);

  %Symmetry array
  symmetryMatrix = zeros(dim, dim);
  numOfSymmetricElements = 0;
  %loop through all entries
  for i = 1:dim
    for j = 1:dim
      if D(i,j) == D(j,i) && D(i,j) == 1
        symmetryMatrix(i,j) = 1;
        numOfSymmetricElements = numOfSymmetricElements + 1;
      end
    end
  end

  numOfSymmetricPairs = numOfSymmetricElements/2;

  %symmetryMatrix is a binary matrix where a 1 reprensents the presence of
  %a symmetric element.
  [rowIndex, colIndex] = find(symmetryMatrix)

  %create bit strings to determine which elements to set to zero.
  bitStrings = strcat(dec2bin(0:2^(numOfSymmetricPairs)-1), dec2bin(2^(numOfSymmetricPairs) - 1 : -1: 0))

  A = cell(1,length(bitStrings))
  for k = 1:length(bitStrings)
    A{k} = D;
    bitString = bitStrings(k,:)
    for i = 1:length(rowIndex)
        if bitString(i) == '0'
          A{k}(rowIndex(i),colIndex(i)) = 0;
        end
    end
  end
