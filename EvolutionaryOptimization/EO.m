%Evolutionary Optimization 1.0
%
tic
D = [1,1,1,1,1,1;
     1,0,1,1,0,1;
     0,0,0,0,0,1;
     1,0,1,0,1,0;
     0,1,1,0,0,0;
     1,0,0,1,1,0];

%Collect information about data
[numRows, numCols] = size(D);
perm = [1:numRows];
maxP = factorial(numRows);
n=length(D);
sizePopulation = 10;
maxk = numRows*numRows - numRows;

%First: Generate a population (i.e. generate rankings)
%NOTE: There are numRows! possible rankings
%Write a for loop using randperm for get a more random initial population
firstGen = [];
for i = 1:sizePopulation
    perm = randperm(numRows);
    firstGen = [firstGen perm'];
end
firstGen;

%Second: Calculate fitness
%As of now, fitness = k
%Need to find a way to keep track of permuatations and their fitness
firstGenFit = [];
%op=[]
 for i = 1:length(firstGen)
    % perm=nextperm(perm,i);
     perm = firstGen(:,i);
     A = D(perm, perm);
     fitness=nnz(tril(A))+(numRows*(numRows-1)/2 - nnz(triu(A,1)));
     firstGenFit = [firstGenFit; fitness];
     %op = [op; i, fitness]
 end
%B = [sortrows(op, 2)]

iteration = 1;
kArray = [];
previousk= 10^10
k=min(firstGenFit)
while k < previousk || iteration <15
  if iteration == 1
    previousk = 100000000;
  else
    previousk = k;
  end
%Third: Selection
%Probability of choosing a member is proportional to its fitness
  matingArray = [];
  for i= 1:sizePopulation
    [mate1, mate2] = selection(firstGenFit,firstGen,sizePopulation);
    matingArray = [matingArray mate1 mate2];
  end

%Fourth: Mating
  offspringArray = [];
  for i = 1:length(matingArray)/2
    offspring = leftTieBreakMate(matingArray(:,i),matingArray(:,length(matingArray)/2+i));
    offspringArray = [offspringArray offspring];
  end

%Fifth: Fitness of offspring
  newFitArray = [];
  for i = 1:length(offspringArray)
      R = D(offspringArray(i),offspringArray(i));
      newFit =nnz(tril(R))+(numRows*(numRows-1)/2 - nnz(triu(R,1)));
      newFitArray = [newFitArray newFit];
  end

  k = min(newFitArray);
  firstGenFit = newFitArray';
  firstGen = offspringArray;
  iteration=iteration+1;
end
offspringArray
k
toc
