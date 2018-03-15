function y = countingSymmetries(D)
  %Collect information on input matrix D
  dim = size(D, 1);

  %Initialize numOfSymmetricElements
  numOfSymmetricElements = 0

  for i = 1:dim
    for j = 1:dim
      if D(i,j) == D(j,i) && D(i,j) == 1
        numOfSymmetricElements = numOfSymmetricElements + 1;
      end
    end
  end
y = numOfSymmetricElements/2
end
