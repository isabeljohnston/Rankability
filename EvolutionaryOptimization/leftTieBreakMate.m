function y = leftTieBreakMate(leftMate, rightMate)

%Information needed to loop through mates.
mateDimension = length(leftMate);
usedLeftIndices = zeros(mateDimension, 1);
usedRightIndices = zeros(mateDimension, 1);

%Allocate space for offspring
offspring = zeros(mateDimension, 1);


%If both mates agree on a ranking, the the offspring will inherit the ranking.
for i = 1:mateDimension
  if leftMate(i) == rightMate(i)
    offspring(i) = leftMate(i);
    usedLeftIndices(i) = 1;
    usedRightIndices(i) = 1;
  end
end

%If the mates do not agree on a ranking, average the positions and use the left
%mates ranking as a tie breaker.
for i =1:mateDimension
  if usedLeftIndices(i)
    continue
  end
  for j = 1:mateDimension
    if usedRightIndices(j) || leftMate(i) ~= rightMate(j)
      continue
    end
      %If the average of left and right rankings is an integer, and that
      %position is not filled in offspring, then place in desired place.
      if mod((i+j)/2,1) == 0 && offspring((i+j)/2) == 0
        offspring((i+j)/2) = leftMate(i);
        usedLeftIndices(i) = 1;
        usedRightIndices(j) = 1;

      %If the average of left and right rankings is an integer, and that
      %position is filled in offspring, fill in next closest.
      elseif mod((i+j)/2, 1) == 0
        openPositions = find(~offspring);
        closestPosition = openPositions(1);
        for k = 1:length(openPositions)
          if abs(openPositions(k) - ((i+j)/2)) < abs(closestPosition - ((i+j)/2))
            closestPosition = openPositions(k);
          end
        end
        offspring(closestPosition) = leftMate(i);
        usedLeftIndices(i) = 1;
        usedRightIndices(j) = 1;

      %if the average of left and right ranking is not an integer, place in
      %nearest position.
      elseif mod((i+j)/2, 1) ~= 0
        %Go closer to left ranking
        if i > ((i+j)/2)
          desiredPosition = ceil((i+j)/2);
        else
          desiredPosition = floor((i+j)/2);
        end

        if offspring(desiredPosition) == 0
          offspring(desiredPosition) = leftMate(i);
          usedLeftIndices(i) = 1;
          usedRightIndices(j) = 1;
        else
          openPositions = find(~offspring);
          closestPosition = openPositions(1);
          for k = 1:length(openPositions)
            if abs(openPositions(k) - desiredPosition) < abs(closestPosition - desiredPosition)
              closestPosition = openPositions(k);
            end
          end
          offspring(closestPosition) = leftMate(i);
          usedLeftIndices(i) = 1;
          usedRightIndices(j) = 1;
        end
      end
    end
  end
y = offspring;
end
