function y = antiTransitive(D)
  if countingSymmetries(D) == 0
      [xCoord, yCoord] = find(D);
      for i = 1:length(xCoord)
          for j = 1:length(yCoord)
              if xCoord(i) == yCoord(j) || xCoord(j) ~= yCoord(i)
                  continue
              else
                  firstElement = [xCoord(i), yCoord(i)];
                  secondElement = [xCoord(j), yCoord(j)];
                  commonIndices =  intersect(find(xCoord == xCoord(i)), find(yCoord == yCoord(j)));
                  if ~isempty(commonIndices)
                      D(xCoord(commonIndices(1)), yCoord(commonIndices(1))) = 0;
                  end
              end
          end
      end
  y = D
  else
      A = enumeratingSymmetries(D);
      B = A;
      for k= 1:length(A)
          [xCoord, yCoord] = find(A{k});
          for i = 1:length(xCoord)
              for j = 1:length(yCoord)
                  if xCoord(i) == yCoord(j) || xCoord(j) ~= yCoord(i)
                      continue
                  else
                      firstElement = [xCoord(i), yCoord(i)];
                      secondElement = [xCoord(j), yCoord(j)];
                      commonIndices =  intersect(find(xCoord == xCoord(i)), find(yCoord == yCoord(j)));
                      if ~isempty(commonIndices)
                          A{k}(xCoord(commonIndices(1)), yCoord(commonIndices(1))) = 0;
                      end
                  end
              end
          end
      end
  y = A
  end
end
